+++
title = "Social Network Analysis of Potential Threat Actors On GitHub"
tags = ['Network Analysis', 'Cybersecurity', 'GitHub', 'Git', 'Python', 'APIs']
date = "2020-11-28"
+++

*Team project in collaboration with the **Center for Knowledge-Powered Interdisciplinary Data Science (CKIDS) at USC.*** 

*Group Members: Erica Xia, Nghi Le, Erin Szeto*

Project Advisor: Jeremy Abramson, PhD (Viterbi School of Engineering, ISI)

---

This project focuses on the detection of potential threat actors on GitHub. We accomplish this by discovering the users who interact with proof-of-concept CVE repositories and analyze their relationships using **social graph network analysis**. Detecting potentially malicious users who interact with software exploits is the first step towards the process of threat attribution in cybersecurity. 

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

In an ever-expanding digital world with exponentially increasing amounts of generated data, cybersecurity and threat mitigation are becoming increasingly important. Computer networks revolutionized the way we communicate, via data transmission and management. However, cyberthreats can just as easily travel on these networks, attacking large organizations such as government institutions. The work involved in tracking and analyzing these threats is no small feat. The first step is the detection of potential threats, in order to move forward with mitigating the damage done.


<!-- <more intro about CVEs, software repos, github>
 -->

We want to identify persons of interest on Github. We first do this by identifying specific software these people may be interested in.

In the beginning, we start with gathering data using the Github API and building a dataset of software repositories and users who interact with them (starred, forked, cloned, etc). Next, we dive into graph building and analysis. 

<!-- <intro about social graph analysis in laymans terms for someone whos unfamiliar> -->



### Motivation and Problem Statement


Our goal is to implement detection of potential threat actors by analyzing users who interact with proof-of-concept CVE implementations. This, in turn, lays the groundwork for threat attribution and entity resolution.

We plan to do this by building and analyzing social graphs of user interactions. For example, Facebook has friend networks, Twitter has social graphs built on retweets or likes. We ask: *How can we represent our users in a data structure (graphs) that can represent connections across multiple dimensions? Which aspect of user interactions (forking, starring, or cloning a repository) is most interesting to represent?*


**Problem Statement:**

Malicious software and their users (contributors, propagators) continue to be a problem in the field of cybersecurity. 
Which CVEs have POC GitHub repositories?
Given the list of malicious repositories, what users interacted with them?
Out of these users, how do they interact with the repos? How many repos did they interact with in common?
How to represent interactions data using graphs?


<!-- TODO: -->
\* *Page under construction* *



<!-- 
### Methodology and Approach


#### Gathering data


![](/images/star-hist.png)



#### Storing data




#### Building social network graphs


Python package networkx

Gephi



### Results


![](/images/network1.png)
![](/images/network2.png)
![](/images/degree-distrb.png)




 -->
[View the project's GitHub code here](https://github.com/github-cve-social-graph/network_graphs)