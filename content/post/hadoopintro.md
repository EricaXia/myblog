+++
title = "Intro to Hadoop (Part One)"
description = "What is Hadoop and what is it used for? How do the components of Hadoop, including HDFS, MapReduce, and YARN work? Let's investigate!"
tags = ['Hadoop', 'HDFS', 'MapReduce']
date = "2020-12-22"
draft = false
+++

![](/../images/hadoop-logo.png)

What is Hadoop and what is it used for? How do the components of Hadoop, including HDFS, MapReduce, and YARN work? Let's investigate!

## What is Hadoop?

Hadoop is a open-source Java software framework for the storage and distributed processing of big data, first developed by Google in 2004. It runs on clusters of commodity hardware. Hadoop can be summarized as several major components:

1. **Hadoop Distributed File System (HDFS)** - Provides distributed data storage
2. **YARN** - Responsible for resource allocation and management, job scheduling, and more tasks
3. **MapReduce** - A programming paradigm and software framework to process large-scale data, via distributed data processing


## Why Hadoop?

Why do we need Hadoop? The ever-growing prevalence of large-scale data requires a distributed model of processing and storage for efficiency. Hadoop arose to address these concerns. It can scale to petabytes in storage and processing capabilities.

Compared to a Network File System (NFS), HDFS is defined to withstand failures, which is known as fault tolerance. This is because it stores multiple replicas (copies) of files, whereas a NFS does not have any built-in fault tolerance.


### 1. HDFS: Hadoop Distributed File System

HDFS runs on a network of clusters, which in turn contain many nodes. A **node** is a process running on a virtual or physical machine. A **cluster** is a collection of nodes that are networked together to store data and perform parallel processing. A physical collection of nodes, approximately thirty to forty nodes, is called a **rack**. One Hadoop cluster may contain many racks. A network of clusters comprises the HDFS.

HDFS is structured by data blocks. Each file is pre-divided into blocks that are then stored across a cluster of machines. Blocks in HDFS are 128 MB in size, compared to the much smaller disk block size of 4 KB. The larger block size allows for faster streaming reads and reduces the amount of metadata required per file.

The system architecture is comprised of a NameNode and multiple DataNodes.

![](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/images/hdfsarchitecture.png)

A **NameNode** is the main node in HDFS. It's a highly-available server that's responsible for maintaining and managing the data blocks stored in HDFS. It also manages the **Namespace**, which includes the file tree and file metadata, and controls client access. The metadata contains important information about files including pointers to the data block locations, file permissions, file sizes, and more. This makes it possible to access the data.

**DataNodes** are the worker nodes of HDFS. These block servers store the actual data, often run on inexpensive commodity hardware. They perform low level read and write requests from clients. DataNodes send regular “heartbeat" reports to provide regular status updates to the NameNode, indicating the DataNode is ready to receive commands for block replicating or deleting.

One main function of the the NameNode is to map the data blocks to the DataNodes, via the information contained in the metadata. This lets client applications know which data blocks are needed to process, and where they're located. The NameNode is also responsible for all file system operations including opening and closing files or directories. The NameNode sends instructions to the DataNodes to execute instructions such as creating, deleting, or replicating data blocks. Clients interact with the DataNodes directly in order to modify the blocks. 

Since the NameNode is so crucial to the functioning of the HDFS, it has the risk of being a **single point of failure (SPOF)**. In early versions of Hadoop, if the NameNode went down, the entire cluster it managed would also go down. All access to HDFS would be shut off. Clients wouldn't be able to read, write, or list any files. Thus, there was a need to configure the system to back up the NameNode’s metadata in case of failure. 

This issue brings about the introduction of the **High Availability (HA)** feature starting with Hadoop 2. The HA feature introduces two NameNodes, but only one NameNode has an ‘active’ status where the other NameNode is on ‘standby’ status. The active NameNode is responsible for interacting with clients and requests, while the standby NameNode only syncing its current state with the active Name Node’s state. Thus the standby Name Node provides high availability for the HDFS through its regular checkpointing feature. If the active Name Node fails, the standby Name Node can take over its responsibilities to respond to clients’ requests. 


### 2. MapReduce Programming Paradigm

As a programming framework, MapReduce was designed for big data processing on distributed systems. 

The process of MapReduce can be summarized in the following steps:

1. Takes input data as a set of key-value pairs.
2. Splits the data. For instance, this can be splitting a table into its individual rows.
3. Map Phase: Maps any function on each element that doesn't require any other elements.
4. Shuffle and Sort Phase: Shuffling transfers the mappers' output to the reducers. Sorting merges and sorts the mappers' outputs. Shuffle and sort occurs simultaneously. For instance, sort all rows by the numerical count of a specific element.
5. Reduce Phase: Aggregates the elements. 
6. Outputs result.

![](/../images/mapreduce1.png)


### 3. YARN

To be continued.


In the next post of this series, we'll look at concrete examples of how to get started running Hadoop.


---


## Sources

Check out the official [Hadoop documentation](http://hadoop.apache.org/docs/current/) here.