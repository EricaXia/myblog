+++
title = "Classification of MNIST Handwritten Digits using K-Nearest-Neighbors in R"
tags = ['R', 'KNN', 'Machine Learning']
date = "2018-12-31"
+++

### Supervised machine learning classification

Data: Handwritten numerical digits pulled from MNIST (Modified National Institute of Standards and Technology database)

#### K-Nearest Neighbors algorithm implementation
<!-- TODO: -->
<!-- Concept: **Under Construction** -->

Using the class labels of the "k" closest neighboring observations from the train set, the KNN algorithm classifies a given observation. The power of the algorithm will depend on the power of "k" and which distance metric is used. Distance metrics include Euclidean, Manhattan, or Minkowski measures of distance.


#### 10-fold Cross Validation to Estimate the Error Rate for KNN

In order to make cross validation run efficiently, I first calculated the distance matrices (for Euclidean and Manhattan distance metrics) beforehand, then ordered the matrices from least to greatest and obtained the index labels. The data was shuffled randomly and split into ten folds by assigning each observation a number from 1 to 10. The folds were stored in a list of indicies. My cv_error_knn function applies the same process to each of the ten folds: the distance matrix is subsetted using the current fold, before being passed to the KNN function. My KNN function had to be altered slightly so it would accept a distance matrix as a parameter, rather than a distance metric. Each iteration of the loop resulted in a vector of predictions which is compared to the real values to estimate an error rate. Finally, I took the average of the ten error rates to get my overall error rate. For k = 3 neighbors, my estimated cross validation error is about 0.01495, or 1.5%. (The error will differ slightly each time the function is run, but it stays around the same range.)


#### Graphically Displaying the Average Digit

![](https://github.com/EricaXia/knn_digits/raw/main_code/images/mnist_var_img.png)