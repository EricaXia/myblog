+++
title = "Social Network Analysis of Potential Threat Actors On GitHub"
tags = ['Network Analysis', 'Cybersecurity', 'GitHub', 'Git', 'Python', 'APIs']
date = "2020-11-28"
+++

![](/images/nw-preview.png)

*Team project in collaboration with the **Center for Knowledge-Powered Interdisciplinary Data Science (CKIDS) at USC.*** 
*Group Members: Erica Xia, Nghi Le, Erin Szeto*
Project Advisor: Jeremy Abramson, PhD (Viterbi School of Engineering, ISI)

---

![]()

Cyber threat attribution is becoming an increasingly critical and challenging problem. One possible way to mitigate these threats is the early identification of potentially malicious users (threat actors). Detecting potentially malicious users who interact with software exploits via analysis of **open-source intelligence (OSINT)** is the first step towards threat attribution. 

This project focuses on the detection of potential threat actors on [GitHub](https://github.com/). We accomplish this by discovering users who interact with proof-of-concept (PoC) CVE repositories and analyze their relationships using **[social network analysis](https://en.wikipedia.org/wiki/Social_network_analysis)**. 

We analyze the generated social graphs to determine if "black hat" threat actors have distinct networks apart from "white hat" users. Successful detection could help accelerate the discovery of threat actors, in addition to aiding in linking their personas on different platforms.  

The software repositories investigated are gathered from the [Common Vulnerabilities and Exposures (CVE) records](https://cve.mitre.org/index.html) maintained by MITRE. 


<!-- ![](/images/cve-logo.png) -->

![]()

---

**Outline**

1. [Introduction](#introduction)
2. [Motivation and Problem Statement](#motivation-and-problem-statement)
3. [Methodology and Approach](#methodology-and-approach)
4. [Results](#results)
5. [Conclusion](#conclusion)

---

![]()


### Introduction

In an ever-expanding digital world with exponentially increasing amounts of generated data, threat mitigation is becoming increasingly important. Computer networks revolutionized the way we communicate, via data transmission and management. However, cyberthreats can just as easily travel on these networks, targeting organizations and government institutions. In the field of cybersecurity, the work involved in detecting, tracking, analyzing, and defending against these threats is no small feat. Detection of potential threats is an important step in order to move forward with stopping them.

![](/images/github-logo.png)

**GitHub** is a free code hosting platform, popular with developers across the world. However, threat actors may also use this service to access **Proof-of-Concept (PoC)** vulnerabilities and exploits (CVEs). Thus, we want to identify 'persons of interest' on GitHub by first identifying malicious software these users may be interested in. Then the users who interact with this software can be gathered, and their relationships analyzed with **social network graphs**.

[Graphs](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)) are mathematical representations of interactions and relationships between entities, as described by a network of nodes and edges. Edges are pair-wise connections between adjacent nodes. [Graph theory](https://en.wikipedia.org/wiki/Graph_theory), a major branch of mathematics, has diverse applications. In areas as varied as biology, physics, and economics, graphs are universally used to represent complex systems. 

In particular, social network graphs are a compelling way to model interactions between users. For example, graphs can be built from Facebook data that visualize how friends are connected. Twitter social graphs can model retweets or likes between users. 

![]()

### Motivation and Problem Statement

Our goal is to detect potential threat actors by analyzing users who interact with proof-of-concept CVE implementations, laying the groundwork for future threat attribution and entity resolution. We plan to do this by building and analyzing social network graphs of user interactions.

For our project, we first investigate ways to best represent our users in a data structure that can represent connections across multiple dimensions. Additionally, we must consider which aspect of user interactions (forking, starring, or cloning a repository) is most meaningful to represent.

Our Initial Questions:
* Which CVEs have PoC GitHub repositories?
* Given this list of repositories, what users interacted with them?
* How did these users interact with the repositories? How many did they interact with in common?
* How do we represent user interactions using graphs?

![]()

### Methodology and Approach

We start with gathering data using the GitHub API and building a dataset of software repositories and users who interact with them (starred, forked, cloned, etc). 

#### Gathering and Storing Data: CVEs

The [National Vulnerabilities Database API](https://nvd.nist.gov/vuln/data-feeds) is used to gather the list of CVEs. We specifically retrieve all CVEs with the keyword "GitHub". Each response is in JSON format and has various elements with information about the CVE. We obtained 15,000 CVEs. From those CVEs, there were over 6,000 malicious GitHub reference links.

The CVE data is stored as documents in **MongoDB Atlas**. We use the **PyMongo** package in Python to store all documents in the same collection to the cloud. Next, we query the database of extracted CVEs to find reference links containing the “Exploit” tag, and then we extract URL links that contain "GitHub.com".

In the end, we are left with about 2,000 unique GitHub repos to query from.

#### Gathering Data: GitHub Users

The links to the repositories in question are then used to query from GitHub through the [GitHub GraphQL API](https://docs.GitHub.com/en/free-pro-team@latest/graphql). For the purposes of creating the initial social graphs, we focused on only stargazers (users who starred a repository). We queried for the stargazers’ information and compiled them into CSV files.

The GitHub API provides information on users' usernames, full names (if provided), company, location, number of followers, and more. For the initial purposes of our project, we are just interested in the usernames.

Distribution of stargazers:
![](/images/star-hist.png)

As shown by the histogram, the majority of users only star between 10 and 15 of the repositories investigated. A minority of users star greater than 15. We are most interested in the users who star a large number of repositories.



#### Building Social Network Graphs

To build the graphs, we utilized the Python package [networkx](https://networkx.org/) and the open-source visualization software [Gephi](https://gephi.org/).

First, the CSV files of all users' data are imported into Jupyter notebooks and converted to a [Pandas](https://pandas.pydata.org/) dataframe in Python. The dataframe columns consist of the *username* and the *repository name*. The data is cleaned and transformed. We use the [itertools.combinations](https://docs.python.org/3/library/itertools.html#itertools.combinations) function to generate all possible combinations of user pairs and append these to a new dataframe. The result is an edge list of users, which is a computer-readable way to represent adjacent nodes. With the help of networkx, we convert the edge list to a [.gexf](https://gephi.org/gexf/format/) file.

This graph file can be read by and imported into our network visualization software, Gephi. Gephi has detailed settings and options to customize the appearance of the graph. 

We chose the *Yifan Hu Proportional* layout, which is very similar to the original [Yifan Hu layout](http://yifanhu.net/PUB/graph_draw_small.pdf), which is a fast algorithm with good quality results on larger graphs. To decrease the complexity, this algorithm combines a force-directed model with a graph coarsening technique (called a multilevel algorithm). A [Barnes-Hut simulation](https://en.wikipedia.org/wiki/Barnes%E2%80%93Hut_simulation) approximates the repulsive forces on one node from a cluster of distant nodes, which considers them as one super-node. The only difference is that the proportional version calculates node locations with a proportional displacement technique. 

After modifying and experimenting with Gephi's settings to best represent our user data, the results are as follows:

![]()


### Results

Here is the overall graph of the users. 
![](/images/network1.png)

The **edge weight**, which is thickness of the lines, represents how many repositories the two users have in common.

To narrow down our users, we filtered by users who have at least 10 repositories in common. This resulted in about 300 nodes, representing the users, and about 2,500 edges, representing the connections between users. So two users will have a connection if they starred at least 10 repositories in common. The maximum number of starred repositories in common we found was 26 (highest edge weight = 26)

We can see by the shape of the graph that the most active users, who have more connections that the others, are focused in the center. And the less active users are on the edges.

![]()

Here is a close up of one of the users as an example.
The user 'denji' has the most number of connections with other users (connected with about 200 other users). The closeup depicts the connections with other users who starred same repos as denji.

![](/images/network2.png)

As shown by the closeup image example, we can identify several users of interest who have more connections and more repositories in common with others. This is visualized by the greater quantity of edges comes from those user nodes, and the higher edge weight (thickness).


![]()

Distribution of the node [degrees](https://en.wikipedia.org/wiki/Degree_(graph_theory)):
![](/images/degree-distrb.png)

The average degree is around 17, thus 17 is the average number of connections with other users. 



![]()

### Conclusion

We discovered more users than hypothesized to have an interest in these malicious repositories, as analyzed by their starring behavior on Github. 

This could prove to be valuable information for cyber threat attribution by playing a role in identifying potential threat actors. Our results could lay the groundwork for further research on these specific users identified in our graph. 

In the future we can research these users elsewhere on the web, and study their behaviors and intentions on other platforms. We can also further analyze and evaluate the graphs using machine learning methods. For instance the Neo4j platform could help identify more important patterns within the graphs with AI methods.

![]()

[View the project code on GitHub](https://GitHub.com/GitHub-cve-social-graph/network_graphs)