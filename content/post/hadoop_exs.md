+++
title = "Intro to Hadoop (Part Two)"
description = "Let's see how to get started using HDFS with examples."
summary = "Let's see how to get started using **HDFS** with examples, starting by setting up an **EC2 cluster in AWS**, installing Hadoop, and working within HDFS. Lastly, we'll cover a **MapReduce** example that implements the same logic as a given SQL query."
tags = ['Hadoop', 'HDFS', 'AWS', 'EC2', 'MapReduce']
date = "2021-01-12"
draft = false
+++

### Getting Started with Hadoop HDFS 


##### Overview
1. Set up AWS EC2 cluster. Official documentation [here](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create_cluster.html).
	- Use the *Amazon Linux AMI*
2. [Installing and Setting Up Hadoop](#installing-and-setting-up-hadoop)
3. [Starting HDFS](#starting-hdfs)
4. [Working with HDFS (Examples)](#working-with-hdfs)
5. [MapReduce Example](#mapreduce-example)

![]()

---

![]()

### Installing and Setting Up Hadoop

##### Downloading Hadoop
Log into the EC2 instance. Download and extract the Hadoop 3.1.4 archive from apache.org as follows:
```
wget http://archive.apache.org/dist/hadoop/common/hadoop-3.1.4/hadoop-3.1.4.tar.gz 

tar xvf hadoop-3.1.4.tar.gz

// Install Java SDK
sudo yum install java-1.8.0-devel
```

Add the following to the `.bashrc` file:
```
export JAVA_HOME=/usr/lib/jvm/java
export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar
export HADOOP_HOME=/home/ec2-user/hadoop-3.1.4
export PATH=${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${PATH}
```
Then type `source ~/.bashrc` to get the changes to take effect.

##### Psuedo-distributed Mode Setup
For the purposes of testing, we set up *psuedo-distributed mode* (where both NameNode and DataNodes reside on the same computer, as opposed to the fully-distributed mode where many nodes are running).

Edit the `<hadoop installation directory>/etc/hadoop/core-site.xml` file by adding:
```
<configuration> 
	<property> 
		<name>fs.defaultFS</name> 
		<value>hdfs://localhost:9000</value> 
	</property> 
</configuration>
```
The root URI of HDFS will be at `hdfs://localhost:9000`.

The next step is to set up *passphrase-less SSH*, for the reason being Hadoop can auto-start the DataNodes on machines running the daemons. Note in this example, DataNode is running on localhost in our setup, so all daemons will run on the same host machine.


In the console, enter
```
ssh-keygen-t rsa-P '' -f ~/.ssh/id_rsa  
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
```
This specifies an empty string as the password, and generates public (id_rsa.pub) and private (id_rsa) key pairs. Then, add the public key into the list of authorized keys. Finally, change the directory to have the proper file permissions.

To test start the system, type `ssh localhost` and `exit` to exit.


### Starting HDFS
Navigate to the Hadoop installation directory. By formatting the NameNode, all the metadata related to the DataNodes (contained in Fsimage and Editlog files) will be formatted. Then, we can start the HDFS daemons (NameNode and DataNodes).

```
bin/hdfs namenode -format
sbin/start-dfs.sh
```
To stop the system, type `sbin/stop-dfs.sh`.

To verify the file system is working properly, type `jps`. There should be three active Java processes: SecondaryNameNode, DataNode, and NameNode.

### Working with HDFS
To set up a home directory within HDFS:
```
bin/hdfs dfs -mkdir /user
bin/hdfsdfs-mkdir/user/ec2-user
```

Example of copying data from local file system to HDFS:
```
bin/hdfs dfs-put etc/hadoop/*.xml /user/ec2-user/input
```

To copy data from HDFS to local system:
```
bin/hdfs dfs -get /user/ec2-user test_dir
```

Example of listing directory contents:
```
bin/hdfs dfs -ls /user/ec2-user/
```

![]()

---

![]()

### MapReduce Example

MapReduce programs are written in Java. In order to compile Java files, we'll need to make sure HADOOP_CLASSPATH was properly exported in the previous steps.

Let's take a COVID-19 patient database as our example. The table name is called `region` with attributes such as `province`, `nursing_home_count`, and `elderly_population_ratio`. 

An example of a SQL query:

```
SELECT province, SUM(nursing_home_count)
FROM covid19.region
WHERE elderly_population_ratio >= 20
GROUP BY province
ORDER BY province
```

We'll implement a Hadoop MapReduce program `Sum.java` to emulate the above query and produce the same output. 

```
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class Sum {
    // Mapper
    public static class SumMapper extends Mapper<LongWritable, Text, Text, IntWritable> {

        private final static IntWritable one = new IntWritable(1); // constant of integer 1

        @Override
        public void map(LongWritable offset, Text lineText, Context context) throws IOException, InterruptedException {
            // Read input line by line into variables
            String line = lineText.toString();
            String province = line.split(",")[0];
            String city = line.split(",")[1];
            String elderly_population_ratio = line.split(",")[2];
            String ep_ratio0 = elderly_population_ratio.replace("'", "");
            ep_ratio0 = ep_ratio0.replaceAll("\\s", ""); 
            String nursing_home_count = line.split(",")[3];
            String nh_count0 = nursing_home_count.replace("'", "");
            nh_count0 = nh_count0.replaceAll("\\s", ""); 
            // Convert data types
            float ep_ratio = Float.parseFloat(ep_ratio0);
            int nh_count = Integer.parseInt(nh_count0);
            // Output
            if (ep_ratio >= 20) {
                context.write(new Text(province), new IntWritable(nh_count));
            }
        }
    }
    
    // Reducer
    public static class SumReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
        @Override
        public void reduce(Text province, Iterable<IntWritable> counts, Context context)
                throws IOException, InterruptedException {

            int sum = 0;
            // Loop over the array, sum all elements (increment them to `sum`)
            for (IntWritable count : counts) {
                sum += count.get();
            }
            // Output the `sum` variable
            context.write(province, new IntWritable(sum));

        }
    }
    
    // Main Class to combine mapper and reducer 
    public static void main(String[] args) throws Exception {
        if (args.length != 2) {
            System.err.println("Usage: Frequency <input path> <output path>");
            System.exit(-1);
        }
      Job job = Job.getInstance();
      job.setJarByClass(Sum.class);
      job.setJobName("Sum");
      FileInputFormat.addInputPath(job, new Path(args[0]));
      FileOutputFormat.setOutputPath(job, new Path(args[1]));
      job.setMapperClass(SumMapper.class);
      job.setReducerClass(SumReducer.class);
      job.setOutputKeyClass(Text.class);
      job.setOutputValueClass(IntWritable.class);
      System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
```

Within the `Sum` class are both the Mapper and the Reducer functions. Additional steps are needed to replace quotes in the string values and convert to proper data types. Input data is read in from a CSV file.

To compile the Java file, navigate to the directory containing the program, then type:
```
javac -classpath ${HADOOP_CLASSPATH} Sum.java 
jar -cvf Sum.jar Sum*.class
~/hadoop-3.1.2/bin/hadoop jar Sum.jar Sum region.csv output_sum
```
This compiles the Java program, packages the classes within a .jar file, and executes the program. The output is stored in `output_sum`, which can be accessed by typing 

```
bin/hdfs dfs -ls /user/ec2-user/output_sum
```

