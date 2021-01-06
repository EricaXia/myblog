+++
title = "Social Network Analysis of Potential Threat Actors On GitHub"
tags = ['Network Analysis', 'Cybersecurity', 'GitHub', 'Git', 'Python', 'APIs']
date = "2020-11-28"
+++

*Team project in collaboration with the **Center for Knowledge-Powered Interdisciplinary Data Science (CKIDS) at USC.*** 

*Group Members: Erica Xia, Nghi Le, Erin Szeto*

Project Advisor: Jeremy Abramson, PhD (Viterbi School of Engineering, ISI)

---

This project focuses on the early detection of potential threat actors on GitHub. We accomplish this by discovering the users who interact with proof-of-concept (PoC) CVE repositories and analyze their relationships using **social graph network analysis**. Detecting potentially malicious users who interact with software exploits, via analysis of **open-source intelligence (OSINT)**, is the first step towards the process of threat attribution. 

The generated social graphs are analyzed to determine if "black hat" threat actors have distinct networks apart from "white hat" users. Successful detection could help accelerate the discovery of dangerous threat actors, in addition to aiding in linking threat actor personas on different platforms (entity resolution).  

![](/images/nw-preview.png)

The software repositories investigated are gathered from the [Common Vulnerabilities and Exposures records](https://cve.mitre.org/index.html) created and maintained by MITRE. 


![](/images/cve-logo.png)


---

**Outline**

1. [Introduction](#introduction)
2. [Motivation and Problem Statement](#motivation-and-problem-statement)
3. [Methodology and Approach](#methodology-and-approach)
4. [Results](#results)

---



### Introduction

In an ever-expanding digital world with exponentially increasing amounts of generated data, threat mitigation is becoming increasingly important. Computer networks revolutionized the way we communicate, via data transmission and management. However, cyberthreats can just as easily travel on these networks, targeting organizations and government institutions. In the field of cybersecurity, the work involved in detecting, tracking, analyzing, and defending against these threats is no small feat. Detection of potential threats is an important step in order to move forward with stopping them.

![](/images/github-logo.png)

**GitHub** is a free code hosting platform, popular with developers across the world. However, threat actors may also use this service to access **Proof-of-Concept (PoC)** vulnerabilities and exploits (CVEs). Thus, we want to identify 'persons of interest' on Github by first identifying malicious software these users may be interested in. Then the users who interact with this software can be gathered, and their relationships analyzed with **social network graphs**.

<!-- <brief intro about social graphs>
Graphs are mathematical abstractions of complex systems of relations and interactions. A graph represents a network of objects (called nodes or vertices) with pairwise connections (edges). Graphs are ubiquitously used in fields as diverse as biology⁵ ⁶ ⁷, quantum chemistry⁸, and high-energy physics⁹. Social networks like Twitter are examples of very large-scale complex graphs where the nodes model users and Tweets, while the edges model interactions such as replies, Retweets, or favs. Public conversations happening on our platform typically generate hundreds of millions of Tweets and Retweets every day. This makes Twitter perhaps one of the largest producers of graph-structured data in the world, second perhaps only to the Large Hadron Collider.   -->


### Motivation and Problem Statement

Our goal is to implement detection of potential threat actors by analyzing users who interact with proof-of-concept CVE implementations. This, in turn, lays the groundwork for threat attribution and entity resolution.

We plan to do this by building and analyzing social network graphs of user interactions. For example, social graphs can be built from Facebook data that visualize how friends are connected. Twitter social graphs can model retweets or likes between users. 

For our project, we first begin by asking: How can we represent our users in a data structure that can represent connections across multiple dimensions? And which aspect of user interactions (forking, starring, or cloning a repository) is most interesting to represent?

**Problem Statement:**

* Which CVEs have PoC GitHub repositories?
* Given this list of malicious repositories, what users interacted with them?
* How did these users interact with the repositories? How many did they interact with in common?
* How do we represent user interactions using graphs?


### Methodology and Approach

We start with gathering data using the Github API and building a dataset of software repositories and users who interact with them (starred, forked, cloned, etc). 

#### Gathering and Storing Data: CVEs

The [National Vulnerabilities Database API](https://nvd.nist.gov/vuln/data-feeds) is used to gather the list of CVEs. We specifically retrieve all CVEs with the keyword "github". Each response is in JSON format and has various elements with information about the CVE. We obtained 15,000 CVEs. From those CVEs, there were over 6,000 malicious GitHub reference links.

The CVE data is stored as documents in **MongoDB Atlas**. We use the **PyMongo** package in Python to store all documents in the same collection to the cloud. Next, we query the database of extracted CVEs to find reference links containing the “Exploit” tag, and then we extract URL links that contain "github.com".

In the end, we are left with about 2000 unique GitHub repos to query from.

#### Gathering Data: Github Users

The links to the repositories in question are then used to query from GitHub through the [Github GraphQL API](https://docs.github.com/en/free-pro-team@latest/graphql). For the purposes of creating the initial social graphs, we focused on only stargazers (users who starred a repository). We queried for the stargazers’ information and compiled them into CSV files.

Distribution of stargazers:
![](/images/star-hist.png)

As shown by the histogram, the majority of users only star between 10 and 15 of the repositories investigated. A minority of users star greater than 15. We are most interested in the users who star a large number of repositories.




<!-- TODO: -->
\* *Page under construction* *


<!-- #### Building social network graphs

Python package networkx
Gephi


### Results

![](/images/network1.png)
![](/images/network2.png)
![](/images/degree-distrb.png)
 -->

[View the project's GitHub code here](https://github.com/github-cve-social-graph/network_graphs)