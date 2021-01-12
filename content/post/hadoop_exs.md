+++
title = "Intro to Hadoop (Part Two)"
description = "Let's see how to get started using Hadoop HDFS with examples."
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
5. [MapReduce Examples](#mapreduce-examples)

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

<INSERT SCREENSHOT HERE>


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

### MapReduce Examples

To be continued.

