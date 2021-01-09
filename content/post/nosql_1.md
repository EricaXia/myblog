+++
title = "NoSQL Databases and MongoDB Explained"
description = "What is NoSQL and why is it needed?"
tags = ['NoSQL', 'MongoDB']
date = "2021-01-08"
draft = false
+++

### NoSQL Databases

What are NoSQL databases? Simply put, NoSQL databases are databases that *don't* store data in a traditional relational table format (SQL). Hence, they are called "not only SQL", or NoSQL for short. Data is instead stored in one of the following types of databases: *document*, *key-value*, *column*, or *graph*. One widely used example of a *document* style NoSQL database is **MongoDB**, which will be discussed further in this post.

![](/images/nosql1.png)

![]()


### NoSQL vs. SQL

SQL relational databases allow us to store data in tabular format (data is organizd in relational tables and rows.). We can perform either DDL or DML operations. DML, or Data Definition Language, sets up the relational database schema (which defines the tables, attributes, indexes, relations, and more). However, the rigid structure of relational databases can sometimes pose a challenge for developers. Hence, NoSQL databases arose as a more flexible, agile storage solution.

NoSQL databases have more flexible schemas that can be changed on-the-go as project requirements may change. Additionally, NoSQL provides opportunities for horizontal scaling to add a greater quantity of inexpensive commodity hardware, whereas SQL databases typically require vertical scaling to larger servers.

![]()


### ACID vs. BASE data stores

In relational databases, the existence of four components represented by the acronym **ACID** ensures that transactions are performed in a timely manner. 

**ACID** stands for:
* **Atomicity**: Commitments to the database are "all or none". If something fails, all changes are rolled back.
* **Consistency**: Transforms the database from one consistent state to another. Thus, there are no "half-completed" transactions.
* **Isolated**: Results are not visible until transaction has been committed.
* **Durability**: Results survive failures.

A database that is *ACID-compliant* has guaranteed validity of its data to protect against power failures and other malfunctions.


On the other hand, NoSQL databases possess a set of alternative, near-opposite properties represented by the acronym **BASE**.

**BASE** stands for:
* **Basically Available**: Guarantees availability of the data. There will be a response guaranteed to any request (can be a failure).
* **Soft state**: The system's state can change over time.
* **Eventual consistency**: The system eventually becomes consistent once it stops receiving input.

Hence, NoSQL databases give up the A,C and/or D properties of ACID in return for improved scalability. Most NoSQL databases don't support ACID transactions with some exceptions, such as MongoDB.

![]()


### Example of NoSQL: MongoDB

As an open-source (freely available and contributed to) NoSQL database, [MongoDB](https://www.mongodb.com/) is employed by organizations across all industries for a wide range of data storage applications. As an agile database, MongoDB allows schemas to be modifed easily and rapidly during the development process. It's designed for efficiency and high availability, in addition to its ability to scale to massive, complex architectures. MongoDB provides high efficiency for read and write operations by using in-memory computing. 

As a document-oriented database, data is stored in *collections* and *documents*, instead of tables and rows. Each record is a BSON document, which is a binary representation of a JSON document, though more file types are supported compared to JSON. Multiple collections are stored in a database.

![]()

Code Snippet:
```
db.createCollection("users");

db.users.insertMany( [
    { name: "Mary", age: 15 },
    { name: "Joe", age: 6 },
    { name: "Selena", age: 22 },
    { name: "Cary", age: 15}
] );

db.users.aggregate([
	{$group: {
		_id: "$age",
		count: {$sum: 1}}}
])
```
*Example of setting up a MongoDB collection, inserting user records, and a sample aggregation operation (Group documents by field "age" and compute count of each distinct age value.).*
