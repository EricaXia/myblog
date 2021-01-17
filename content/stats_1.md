+++
title = "Statistics (Part I)"
tags = []
+++

## Precision, Recall, PR Curve, and ROC Curve

#### Definition
Say we have a binary prediction model that predicts either positive or negative for a test. A common example is whether or not a medical test returns positive or negative for a disease. However, we can't be sure that this test is 100% accurate. Therefore, we'd like to measure the accuracy and precision of this test. We can use precision and recall to do so.

*True Positive (TP)* = Test returns positive result and the patient has the disease

*False Positive (FP)* = Test returns positive, patient does NOT actually have the disease

*True Negative (TN)* = Test returns negative, and patient doesn't have the disease

*False Negative (FN)* = Test returns negative, and the patient DOES have the disease.

The **precision** describes the percentage of positive predictions that were correct. That is, the number of true positives divided by the total *predicted positive* observations.

$$ precision = \frac{TP}{TP + FP} $$

The **recall** describes the percentage of true positives that are labeled as positive by the model. That is, the number of true positives divided by the total *actual positive* observations.

$$ recall = \frac{TP}{TP + FN} $$

Another measure used for the ROC described further on down is the false positive rate, or FPR: 

$$ FPR = \frac{FP}{TN + FP} $$

<!-- #### Precision-Recall Tradeoff -->


#### ROC Curve
The Receiver operating characteristic (ROC) curve plots the *false positive rate (FPR)* on the x-axis against the *true positive rate* (or recall) on the y-axis. Various threshold settings are plotted to form this probability curve.  

Example:
![](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Roccurves.png/440px-Roccurves.png)

So what does this curve mean exactly? What does it represent? How can we use it to determine how good the model is?

In general, we can compare different curves on the same plot to compare the performance of different models. The AUC, or area under the curve, can be used to summarize the models' skill. 

The curve illustrates a trade-off: smaller values on the x-axis mean lower false positives and higher true negatives. Larger values on the y-axis mean there are higher true positives and lower false negatives.

Generally, good models will have curves with a shape that curve upwards to the top left corner of the plot.


## Bias-Variance Tradeoff

## Hypothesis Testing , P-value