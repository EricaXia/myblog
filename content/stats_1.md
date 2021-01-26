+++
title = "Statistics (Part I)"
tags = ['Statistics']
+++

## Precision, Recall, PR Curve, and ROC Curve

#### Definition
Say we have a *binary prediction model* that predicts either positive or negative for a test. A common example is whether or not a medical test returns positive or negative for a disease. However, we can't be sure that this test is 100% accurate. Therefore, we'd like to measure the accuracy and precision of this test. We can use precision and recall to do so.

Terms:
- *True Positive (TP)* = Test returns positive result and the patient has the disease

- *False Positive (FP)* = Test returns positive, patient does NOT actually have the disease

- *True Negative (TN)* = Test returns negative, and patient doesn't have the disease

- *False Negative (FN)* = Test returns negative, and the patient DOES have the disease.

The **precision** describes the percentage of positive predictions that were correct. That is, the number of true positives divided by the total *predicted positive* observations.

$$ precision = \frac{TP}{TP + FP} $$

The **recall**, also known as sensitivity or TPR, describes the percentage of true positives that are labeled as positive by the model. That is, the number of true positives divided by the total *actual positive* observations.

$$ recall = \frac{TP}{TP + FN} $$

*So by the definitions, we can see that precision and recall are closely related concepts. They both use the number of true positives in the numerator. The value of the precision tells us "How good/useful is this model at predicting the true positives?". The value of recall answers "How complete are the true positive predictions made by the model?" or "How well did the model capture everything positive?"*

Another measure used for the ROC described further on down is the **false positive rate (FPR)**, which is the number of false positives divided by the total *actual negative* observations: 

$$ FPR = \frac{FP}{TN + FP} $$

<!-- #### Precision-Recall Tradeoff -->


#### ROC Curve
The Receiver operating characteristic (ROC) curve plots the *false positive rate (FPR)* on the x-axis against the *true positive rate* (or recall) on the y-axis. Various threshold settings are plotted to form this probability curve.  

Example:
![](https://developers.google.com/machine-learning/crash-course/images/ROCCurve.svg)

So what does this curve mean exactly? What does it represent? How can we use it to determine how good the model is?

In general, we can compare different curves on the same plot to compare the performance of different models at different candidate *thresholds*. Lowering the *threshold* will classify more observations as positive.

The AUC, or area under the curve, can be used to summarize the models' skill. 

The curve illustrates a trade-off: smaller values on the x-axis mean lower false positives and higher true negatives. Larger values on the y-axis mean there are higher true positives and lower false negatives.

Generally, good models will have curves with a shape that curve upwards to the top left corner of the plot.

![]()

#### Precision Recall Curve
Another type of curve we can use to evaluate a model is the PR curve. It plots recall on the x-axis and precision on the y-axis. Like ROC curves, it calculates points on the curve at different threshold settings. Ideally, our model provides a balance between precision and recall, by bending towards the upper right corner of the plot.

![Example of PR curve](https://www.researchgate.net/profile/Farhan_Akram/publication/274015950/figure/fig10/AS:328319821205505@1455288953065/PR-curve-using-precision-and-recall-from-segmentation-results-of-116-images-with-tumor.png)

This curve can provide an accurate depiction of a model's classification performance, since they evaluate the true positive ratio among all the positive predictions made. 

![]()

So when do we use ROC curves versus PR curves to evaluate models? When there is a high class imbalance (e.g. many positive instances and only a few negative instances), we should use the PR curve. Otherwise, if the classes are more balanced (e.g. roughly equal positive and negative instances), we should use the ROC curve.

![]()

#### Resources
Wikipedia has detailed pages on these concepts with visual explanations:
- https://en.wikipedia.org/wiki/Precision_and_recall
- https://en.wikipedia.org/wiki/Sensitivity_and_specificity

