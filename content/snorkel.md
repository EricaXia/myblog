+++
title = "NLP & Machine Learning with the Snorkel Framework"
tags = ['Machine Learning', 'Network Analysis', 'NLP']
date = "2019-11-06"
+++

![](https://github.com/EricaXia/snorkel/raw/master/images/logo.png)
### "Relation Extraction of Virus-Host Species from Epidemiological Research Literature"
#### University of California, Davis - Epicenter for Disease Dynamics
Project led by [Dr. Pranav Pandit](https://panditpranav.github.io/) of the UC Davis One Health Institute. 

![]()

---

![]()

### Summary 
In this project, we build a machine learning system (with the help of the [Snorkel](https://www.snorkel.org) framework developed by Stanford DAWN) to extract and identify correct mentions of virus and animal host species relations from academic literature in the context of epidemiological research.

Considering a large majority of infectious diseases are spread from animals to humans, zoonotic diseases have become an important topic of study and the subject of many research studies. Various species of viruses, such as Flaviviruses, may cause the outbreak of viral zoonotic disease. Hence, the relations between viral and animal host species are major factors in understanding the transmission and characteristics of zoonotic diseases. Natural Language Processing extraction techniques can be used to identify species-level mentions of viral-host relations in academic text. 

This system should extract and identify correct mentions of virus and animal host species from academic research papers. The goal of such methods is to provide insights into scientific writing and research conducted on species linked to zoonotic disease. After extracting specific viral-host relations, we use supervised machine learning techniques to label entity pairs as having positive or negative associations. 

One challenge in the way of applying supervised learning methods is the creation of large, labeled training sets. In our project, we require training sets of confirmed viral and host species relations. Hence, we make use of Snorkel (created by Stanford's HazyResearch group) to create a training sets. The training sets are noisy, machine labeled sets created by applying user-defined heuristics, called labeling functions, to extracted candidate pairs. 

![](https://www.snorkel.org/doks-theme/assets/images/layout/Labeling.png)

A generative model is deployed to unify the labeling functions and reduce noise in the final training set. Finally, end extraction is performed by different models (including LogReg, LSTM, and RNN) to predict correct relation mentions.    

![](https://github.com/EricaXia/snorkel/raw/master/images/new_network.PNG)

## Project Pipeline

The tasks are broken up into each step of the pipeline. 


[**Part 1 - Document Preparation, Preprocessing, and Candidate Extraction**]
- Read in a corpus of documents in .tsv format
- Extract candidates through dictionary matching

[**Part 2 - Labeling Functions Development**]
- Develop Labeling Functions to label candidates as true or false
- Compare LF performance with hand labeled set (gold labels)

[**Part 3 - Generative Model Training**]
- Unify the LFs and reduce their noise
- Use marginal predictions from the model as the probabilistic training labels (for the end extraction model in Part 4)

[**Part 4 - Discriminitive End Extraction Model Training**]
- Train a LSTM model using training labels from Part 3
- Evaluate model performance on a blind test set

### Additional Data
- [Metadata table](https://github.com/EricaXia/snorkel/blob/master/metadata.tsv) 

<br>

## [View the code here](https://github.com/EricaXia/snorkel)

