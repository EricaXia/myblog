+++
title = "k-Nearest-Neighbors Algorithm"
tags = []
+++

The kNN algorithm is a supervised classification algorithm. In order to use kNN, we'll need labeled training data to train the model. We will classify each unlabeled observation based on the labels of the *k* points closest in distance.

Wikipedia provides a simple conceptual image of how kNN works:
![](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/KnnClassification.svg/440px-KnnClassification.svg.png)

In the inner most solid-line circle, the green dot represents the test observation to classify. The blue square and the two red triangles represent its 3 closest *labeled* observations. The label is classified based on majority vote. 

If we set k = 3, then the observation is predicted/labeled as a red triangle, since there are more red within the solid circle. 

If we set k = 5, expanding the circle to the boundaries of the dashed line, then the prediction changes to blue, because now there are 3 blue > 2 red within the dashed circle.


**Note: a drawback of kNN is that it doesn't work well with skewed class distributions. The more frequently occurring class is going to be predicted more often, since there are more labeled points for that class. For example, if a test result has a high number of negative observations and only a small proportion of positive, then new points are more likely going to be classified as negative. One way to remedy this is to set weights for the classes.


<!-- Source: wikipedia -->
