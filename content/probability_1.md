+++
title = "Probability"
tags = []
date = "2021-02-23"
+++
---
## What is Probability?

Probability is defined as the chance of an event occurring. More concretely, probability is calculated by dividing the number of times an event occurs by the total number of trials.

$$ Pr(Y) = \frac{\text{Number of times Y occurs}}{\text{Total number of trials}}$$

## Odds
We use probability to calculate the odds. Odds can be thought of as the likelihood of an event occur relative to the event *not* occurring. The odds is calculated by dividing the probability an event occurs by the probability the event does *not* occur. 

$$ O(Y) = \frac{Pr(Y)}{1 - Pr(Y)} $$

Given the odds, we can also calculate probability by reversing the equation.

$$ Pr(Y) = \frac{O(Y)}{1 + O(Y)} $$


### Odds Ratio

Odds Ratio is an important concept for models such as logistic regression. Given *two* events A and B, the odds ratio signifies the strength of their association. Usually we view one event A as the *exposure* or the treatment, and the other event B as the outcome. In the context of a model, we can view A as the effect of the predictors on B the response variable.


** Under construction **

TODO:
- Properties: multiplication, addition, complement
- Mutual exclusivity 
- Law of total probability
- De-morgans law
- union, intersect
- partition
- Random variables
- PMFs, PDFs
- common prob distributions