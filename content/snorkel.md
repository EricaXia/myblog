+++
title = "Relation Extraction of Virus-Host Species from Epidemiological Research Literature"
tags = ['Machine Learning', 'Network Analysis', 'NLP']
date = "2019-11-06"
+++

### NLP & Machine Learning with the Snorkel framework
![](https://github.com/EricaXia/snorkel/raw/master/images/logo.png)
##### University of California, Davis - Epicenter for Disease Dynamics
Project led by [Dr. Pranav Pandit](https://panditpranav.github.io/) of the UC Davis One Health Institute. 
Project code repository [here](https://github.com/EricaXia/snorkel).

![]()

![](/images/network_small.png)

---

#### Contents
1. [Summary](#summary)
2. [Project Pipeline](#project-pipeline)
3. [Detailed Introduction](#introduction)
4. [Methodology](#methodology)
	- Problem Definition
	- Preprocessing
	- Labeling Functions
	- Generative Model
	- Discriminative Model (Compare logistic regression, RNN, LSTM)
5. [Results](#results)
	- Cross Validation
	- Network Analysis Visualization
6. [Conclusion](#conclusion)

---

## Summary 

In this project, we build a machine learning system (with the help of the [Snorkel](https://www.snorkel.org) framework developed by Stanford DAWN) to **extract and identify correct mentions of virus and animal host species relations** from academic literature in the context of **epidemiological research**.

![](https://www.snorkel.org/doks-theme/assets/images/layout/Labeling.png)

Considering a large majority of infectious diseases are spread from animals to humans, zoonotic diseases have become an important topic of study and the subject of many research studies. Various species of viruses, such as Flaviviruses, may cause the outbreak of viral zoonotic disease. Hence, the relations between viral and animal host species are major factors in understanding the transmission and characteristics of zoonotic diseases. **Natural Language Processing** extraction techniques can be used to identify species-level mentions of viral-host relations in academic text. 

This system should extract and identify correct mentions of virus and animal host species from academic research papers. The goal of such methods is to provide insights into scientific writing and research conducted on species linked to zoonotic disease. After extracting specific viral-host relations, we use **supervised machine learning** techniques to label entity pairs as having positive or negative associations. 

One challenge in the way of applying supervised learning methods is the creation of large, labeled training sets. In our project, we require training sets of confirmed viral and host species relations. Hence, we make use of Snorkel to create training sets. The training sets are noisy, machine labeled sets created by applying user-defined heuristics to extracted candidate pairs. By employing **weak supervision** strategies to efficiently label data, we avoid the bottleneck of requiring hand-labeled training data in order to employ machine learning prediction methods.

---

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

[**Part 4 - Discriminative End Extraction Model Training**]
- Train a LSTM model using training labels from Part 3
- Evaluate model performance on a blind test set

---

## Introduction

Zoonotic diseases have become an important topic of study and the subject of many research studies. Various species of viruses, such as Flaviviruses, may cause the outbreak of viral zoonotic disease. Hence, the relations between viral and animal host species are major factors in understanding the transmission and characteristics of zoonotic diseases. With the increase of academic literature in this field, there has been growing interest in extracting relevant data from these documents.

This paper concerns the extraction and identification of positive mentions of virus and animal host species relations from research journal papers. We use a weakly supervised machine learning approach for this relation extraction and classification task. The goal of this project is to develop a prediction model that correctly classifies virus-host pairs as having positive or negative associations. Such methods can provide insights into the scientific writing and international research conducted on species linked to zoonotic disease. 

The project is divided into two sub-tasks: relation extraction and relation classification. Relation extraction identifies potential candidate pairs of viral and host animal species by way of dictionary-based matching in a given corpus of text. Relation classification assigns the detected pairs a positive or negative class label by applying user-defined heuristics, called labeling functions. To define the labeling functions, we apply rules based on various linguistic features observed from human-verified pairs of viruses and host species. For instance, keyword-based labeling functions filter candidates by predefined keyword patterns, while distant supervision labeling functions compare candidates with a database of known pairs.

One challenge in the way of applying supervised learning methods is the creation of large, labeled training sets. Hand labeling large data sets can be a costly bottleneck to a machine learning system. In this project, training sets of positively related viral and host species are required to train the end model. Hence, data programming by way of the Snorkel framework is used to create training sets. These  noisy, machine labeled sets are created by the labeling functions of the relation classification task.

A generative model is deployed to unify the labeling functions and reduce noise in the final training set. The model calculates accuracies and correlations for each labeling function, based on the agreements and disagreements of all functions' class label predictions. Lastly, end extraction is performed by a range of methods including sparse logistic regression, recurrent neural network (RNN), and Long short-term memory network (LSTM) as the discriminative models. Each model's accuracy scores are compared for performance.

![]()

## Methodology

#### Problem Definition
The task is to extract relations between viral and host species and classify as either positive or negative. The data is funneled through the pipeline from initial preprocessing, to label function training through the generative model, and lastly to the discriminative (end-extraction) model.

#### Data
The corpus of text data is comprised of 88 documents from academic literature and 18,884 sentences. The sentences are randomly split into training, development, and testing sets. 20\% percent of the data was split into development and testing (10\% each). The following explains how this text data was preprocessed and prepared for further analysis.

#### Preprocessing
The original papers were stored as PDF documents. They have been combined and converted to one .tsv file, with a format of document name tab-separated by document content. The doc preprocessor reads in the documents. Spacy, an NLP preprocessing tool, splits the documents into sentences and tokens. We create matcher functions from predefined dictionaries to match virus and host names, including full names, abbreviations, and acronyms, in the corpus.

The next step is to extract candidates from the text. In our case, the candidate are pairs of virus-host species mentions. Candidates are identified, for each Sentence, as all pairs of n-grams tokens that were tagged from the matcher functions. 


#### Text Based Labeling Functions
User defined labeling functions specify rules for classification:

Candidates are classified based on the proximity to certain keywords that may signal a positive or negative relation. A simple example is the detection of the word "positive" nearby that likely indicates a positive relation between virus and host.
- Structure Based: Candidates are classified as positive or negative depending on their word proximity. 
- Distant Supervision: Candidates are compared to a database of known relation pairs. 

#### Generative Model

Using the Snorkel package, we rely on a generative model to compare and combine all user defined labeling functions. Before training the discriminative model, the data programming paradigm first calls for the use of generative models as a more sophisticated way to combine lower quality labeling functions. Since labeling functions are imperfect classifiers, their individual accuracies are modeled with maximum likelihood estimation using the majority vote between the functions' agreements and disagreements on candidate labels. The generative model then probabilistically models the true positive or negative class label for each candidate. 

From an intuitive angle, labeling functions are weighted in the generative model based on how much their class label outputs overlap. Once the model is trained, the label functions are combined into a reduced-noise training label set for training the end extractor. The generative model is fine-tuned using a hyper-parameter grid search over number of epochs, step size, and decay. While training the model, we also account for potential dependencies between labeling functions that may affect accuracy. Snorkel's DependencySelector function identifies a set of likely dependencies which are passed to the model during tuning. 

The optimal model parameters are found to be a 2.6e-5 step size, 9.5e-1 decay, and 100 epochs.  

As a result, the optimal model yields an F1 score of 0.757 with the development set. The next task is to improve this score on the test set by passing the training marginal probabilities to the end model.

<INSERT IMAGES>

#### Discriminative Model
Several different end models trained on the training set produced by the generative model can extrapolate and generalize beyond the initial search patterns defined by the user written labeling functions. The model can then predict on new data and unseen patterns. Each model is trained by minimizing the expected loss with respect to the probabilistic training labels. Each model is trained over five-fold cross validation.

##### Sparse Logistic Regression
Built from the Tensorflow library, the sparse logistic regression model is used as a baseline model to evaluate performance of the neural network methods. To avoid overfitting, penalty terms for l1 and l2 regularization methods is considered.  

First, the features of the train, test, and development sets are extracted, then the model runs a random grid search to test varying batch size, learning rate, l1 penalty, l2 penalty, and rebalance. A small hand-labeled set is used to evaluate the development set.

##### Recurrent Neural Network (RNN) for Relation Extraction
Built from the PyTorch library, the ReRNN model included with Snorkel is designed specifically for relation extraction. The ReNN model is trained over 30 epochs and evaluated on the hand-labeled development set.

##### Long Short Term Memory (LSTM) Network
Like the ReRNN, the LSTM is built from the PyTorch library. We conduct a random grid search over hyperparameters including learning rate, number of epochs, dropout rate, and rebalance. 



## Results

![](/images/snorkel-poc-roc.png)

#### Cross Validation
Precision, recall, F1, and accuracy scores, displayed in the table below, are used to evaluate the models. Though the ReRNN has the highest accuracy, the LSTM network has the highest F1 score. Thus, we choose the LSTM network to be the best performing model of the three.

![](/images/snorkel-results-table.png)

Figure 1 displays a receiver operating characteristic (ROC) curve, and Figure 2 displays the precision-recall Curves for the five-fold cross validation procedure on the baseline logistic regression model.

#### Network Analysis

A bipartite network visualization, created using the open-source software [Gephi](https://gephi.org/), can more uniquely and clearly depict the predicted results.

![](https://github.com/EricaXia/snorkel/raw/master/images/new_network.PNG)

The network figure displays a visual representation of the virus and host species relations. From the graphic alone, we can note several patterns such as the prevalent links to *West Nile virus*.


## Conclusion

Through the use of the Snorkel framework, we implement a weakly supervised approach to extract virus-host relations. After probabilistically modeling and combining user-written labeling functions, we apply three different discriminative models and compare ability to detect true relations. To select the best model, their outputs are compared and evaluated through error analysis. From the analysis and visualization of the results, project further lays the groundwork for future research into the identified viral and host animal species.



---


### Additional Data
- [Metadata table](https://github.com/EricaXia/snorkel/blob/master/metadata.tsv) 

### Citations

Ratner, A., Bach, S. H., Ehrenberg, H. R., Fries, J. A.,Wu,  S.,  &  Ré,  C.  (2017).  Snorkel:  Rapid  training  data  creation  with  weak  supervision. Retrieved from http://arxiv.org/abs/1711.10160

---


<!-- Work at the Epicenter is even more relevant in light of current events. Hindsight is indeed 20/20. Literally, the year 2020. -->

