+++
title = "Regression Models"
tags = []
+++

<!-- TODO: more detail about validation/error measurement, coding examples, what's good for (use cases) -->

#### TOC:
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
$ \hat{y} = h_\theta(x) = \boldsymbol{\theta \cdot x} $

Where $\boldsymbol{\theta}$ represents the vector of weights or coefficients, and $\boldsymbol{x}$ represents the vector of predictor variables.

How do we train a lin. reg. model?

> "Training" a model means to find and set parameters for the model (in this case, $\theta$) that *best* fit the model.

In order to find these parameters, we need to have a way to measure what the *best fit* would be. It's common to find parameters that minimize the [RMSE](https://en.wikipedia.org/wiki/Root-mean-square_deviation) or [MSE](https://en.wikipedia.org/wiki/Mean_squared_error).

Linear Regression algorithms:
- Normal equation
- SVD
- Gradient Descent (Batch, Stochastic, Mini-batch)


## Ridge Regression
### (L2 Regularization)

A regularized version of linear regression. *Regularized* meaning selected or fine-tuned to improve the model's predictive capability. An $L_2$ regularization term is added to the model in order to keep the model weights as small as possible. 

The regularization term added to the model is calculated as:

$$ \alpha\sum_{i=1}^n \theta^2_i $$

$\alpha$ is the hyperparameter term, which controls how much to regularize the model.

The cost function to minimize is calculated as:

$$ J(\theta) = MSE(\theta) + \alpha\frac{1}{2}\sum_{i=1}^n \theta^2_i$$

By the equation, we can see that ridge regression penalizes the *weights squared*.

> Why regularization? We want to mitigate the possible effects of [multicollinearity](https://en.wikipedia.org/wiki/Multicollinearity) on the model. If the coefficients are highly correlated with each other, then in essence they are redundantly measuring the same thing. This doesn't make the model predict any better, and can become very sensitive to small changes. In turn, this reduces the precision of the coefficient estimates and weakens the [power](https://en.wikipedia.org/wiki/Power_of_a_test) of our model. It would be difficult to identify individually, statistically significant independent variables.

Ridge tends to work better if the model has many parameters $\theta$ with equivalent values. Thus, most of the $X$ predictors affect the result.

*Drawbacks of Ridge?* It doesn't reduce the number of features. Hence, it's not the best choice for feature selection/reduction if there are too many initial features.


## Lasso Regression 
### (L1 Regularization)

"LASSO" stands for *Least Absolute Shrinkage and Selection Operator*.

Taking things a step further, this is also a regularized version of linear regression, adding a $L_1$ regularization term to penalize the weights. 

It tends to eliminate the weight of the *least important* features (setting their weights = 0), so this process has a **feature selection** element, different from Ridge. Since less relevant features are removed, this results in a sparse model with few nonzero parameters. Compare this to Ridge, which never sets the weights to 0. 

Cost function of Lasso:
$$ J(\theta) = MSE(\theta) + \alpha\sum_{i=1}^n |\theta_i| $$

Note the difference in the regularization term compared with Ridge.

Lasso tends to work better when there's a smaller number of parameters relevant to the model results. Thus, we can narrow down the important features in our model.

*Drawbacks of Lasso?* If the number of features *p* is more than the number of observations *n* (e.g. the data set size is small), then at most n features are picked as non-zero. Even if all *p* predictors are relevant to the model, some will be dropped.


## Logistic Regression
 
Logistic Regression is a binary prediction model. That is, it predicts a binary probability of a class or label that can take on one of two values. It also  can be used to model several classes or categories, with each probability assigned between 0 and 1. 

See [here](/shelter) for example of using logistic regression to predict shelter outcomes (survive or don't survive).





---

## How do we choose the best model?
It depends. Generally, we seek a balance between [bias and variance](https://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff). We analyze different measure such as R-Squared, Adjusted R-Squared, p-values/power, or automated procedures such as stepwise regression.

Often the simplest model that results in random residuals/errors with high precision and low bias is ideal.
 
Complex models tend to overfit the data.


<!-- Sources:  -->
<!-- Hands on ML -->
<!-- Google develoeprs ML crash course -->

 