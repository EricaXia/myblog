+++
title = "Regression Models"
tags = []
+++

<!-- Outline: basic definition, how it's calculated, validation/error measurement, examples, what's good for (use cases) -->

[Linear](#linear-regression)
[Ridge](#ridge-regression)
[Lasso](#lasso-regression)
[Logistic](#logistic-regression)



---

## Linear Regression
 
A linear model makes a prediction on a target variable by calculating a weighted sum of the input variables (*features*), plus a constant intercept (*bias term*).

![](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Linear_regression.svg/1200px-Linear_regression.svg.png) 

The basic equation of a line: $Y = a + bX$ 

The slope of the line is b, and the y-intercept is a.

Similarly, in linear regression, the model can be represented in vectorized form:
$ \hat{y} = h_\theta(x) = \theta \cdot x $


How do we train a lin. reg. model?

> "Training" a model means to find and set parameters for the model (in this case, $\theta$) that *best* fit the model.

In order to find these parameters, we need to have a way to measure what the *best fit* would be. It's common to find parameters that minimize the [RMSE](https://en.wikipedia.org/wiki/Root-mean-square_deviation) or [MSE](https://en.wikipedia.org/wiki/Mean_squared_error).

Linear Regression algorithms:
- Normal equation
- SVD
- Gradient Descent (Batch, Stochastic, Mini-batch)

## Ridge Regression

A regularized version of linear regression. *Regularized* meaning selected or fine-tuned to improve the model's predictive capability. An $l1$ regularization term is added to the model in order to keep the model weights as small as possible. 

The regularization term added to the model is calculated as:

$$ \alpha\sum_{i=1}^n \theta^2_i $$

$\alpha$ is the hyperparameter term, which controls how much to regularize the model.

The cost function to minimize is calculated as:

$$ J(\theta) = MSE(\theta) + \alpha\frac{1}{2}\sum_{i=1}^n \theta^2_i$$


> Why regularization? We want to mitigate the possible effects of [multicollinearity](https://en.wikipedia.org/wiki/Multicollinearity) on the model. If the coefficients are highly correlated with each other, then in essence they are redundantly measuring the same thing. This doesn't make the model predict any better, and can become very sensitive to small changes. In turn, this reduces the precision of the coefficient estimates and weakens the [power](https://en.wikipedia.org/wiki/Power_of_a_test) of our model. It would be difficult to identify individually, statistically significant independent variables.

Drawbacks of Ridge? It doesn't reduce the number of features. Hence, it's not the best choice for feature selection/reduction if there are too many initial features.


## Lasso Regression

"LASSO" stands for *Least Absolute Shrinkage and Selection Operator*.

Taking things a step further, this type of regression is also a regularized version of linear reg. 

It tends to eliminate the weight of the *least important* features (setting their weights to 0), so this process has a variable selection element. This results in a sparse model with few nonzero parameters. Compare this to Ridge, which never sets values to 0. 

Drawbacks of Lasso? If the number of features *p* is more than the number of observations *n* (e.g. the data set size is small), then at most n features are picked as non-zero. Even if all *p* predictors are relevant to the model, some will be dropped.


## Logistic Regression
 
Logistic Regression predicts a binary probability of a class or label. It can be used to model several classes or categories, with each probability assigned between 0 and 1. 

See [here](/shelter) for example of using logistic regression to predict shelter outcomes (survive or don't).





---

## How do we choose the best model?
It depends. Generally, we seek a balance between [bias and variance](https://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff). We analyze different measure such as R-Squared, Adjusted R-Squared, p-values/power, or automated procedures such as stepwise regression.

Often the simplest model that results in random residuals/errors with high precision and low bias is ideal.
 
Complex models tend to overfit the data.



 