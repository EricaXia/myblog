+++
title = "How A/B Testing Works"
description = "What is A/B Testing?"
tags = ['A/B Testing', 'hypothesis testing']
date = "2021-01-25"
draft = false
+++

## What is A/B Testing? :microscope:

A common example of A/B testing is a business making changes to its website with two versions. One version of the website let's call A, the other version let's call B. The two versions may be almost identical, but with some key changes such as changing the wording of the website, or the placement of a button. Then we measure responses from visitors who visit either of the websites to see which version performs better, using some success metric such as clickthrough rate. 

![](https://images.pexels.com/photos/196644/pexels-photo-196644.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500)

As a randomized control experiment, A/B testing is a formal method for testing hypotheses. The findings are used for making decisions to estimate certain parameters of the population (e.g. all website visitors) based on sample statistics (e.g. website visitors who participated in the experiment).

Goal: Find out which website version increases the clickthrough rate (our success metric). A/B testing will be the method used to gather data and analyze which version performs better.

**A/B testing is highly recommended to use for testing and implementing a new feature or design on a product (website, app, etc).**

![]()

## Primer on Hypothesis Testing :mag_right:

A hypothesis is an educated guess about certain world phenomena that has yet to be verified. It should be verifiable by an experiment or by an observation. 

In [statistical hypothesis testing](https://en.wikipedia.org/wiki/Statistical_hypothesis_testing), a hypothesis should include both independent variables and dependent variables. An independent variable's value doesn't depend on other variable's values. A dependent variable reflect the effect of the independent variables. Sometimes we call the independent variables $x$, and the dependent variables $y$. The goal is to investigate the cause-and-effect relationship between $x$ and $y$.

An example of a hypothesis statement structure is the "If...x..., then...y".

For instance, "If we change the wording of the website button from 'Buy Now' to 'Add to Cart', it will increase the clickthrough rate." In other words, the button text is the independent variable, and the clickthrough rate is the dependent variable.

![]()

![](https://st2.depositphotos.com/1071909/10144/i/600/depositphotos_101447584-stock-photo-a-and-b-split-testing.jpg)

## A/B Testing Process :chart_with_upwards_trend:

*1. Research and Preparation*
- **Collect data** on your user base to perform background research and identify areas of need. For instance, if your website is underperforming on a certain page, investigate which pages and by how much the page is underperforming.
- **Define and identify business goals**. To measure the success of A/B testing, we'll need to identify business KPIs and define success metrics. The goal can be a metric as simple as click-through rate, or sales rate. At an organization, this may involve discussing goals with multiple teams to gain perspectives and get information.
- **Generate a specific hypothesis**. Much like a scientific experiment, we'll need to start with a specific null and alternative hypotheses. If there's multiple ideas for new features, for instance, we'll need to prioritize which hypotheses are most important to test first. This is when we can tie in relevance to the business goals from step (ii). 

*2. Design the Experiment*
- **Create variations** for the test. For instance, we can generate copy A and copy B of a website to compare results. Copy A can represent the "control group" to support the null hypothesis maintaining the status quo without the new feature, and copy B can represent the "treatment group" with the new feature.

*3. Run the A/B Test*
- Start the experiment and begin **gathering data**. New observations will be randomly assigned to either the control or treatment group. For example, new website visitors will be randomly taken to either Copy A or Copy B of the site.

*4. Analyze Results*
- We'll need to discover whether there's a **statistically significant difference** between results of A and B. This is where statistical tests (e.g. z-test, t-test) will come in handy.
- **Discuss and present results** to others. Tweak and continue to optimize product as needed for desired results in success metrics.

![]()

## Applications :computer:
A/B Testing is commonly used in the development and refinement of products and services. For example, as mentioned before, a webpage design, an email campaign, or the design of a mobile app. There's a multitude of ways to tweak and optimize the details and designs of features for better results and happier customers. Businesses need a measurable, verifiable, scientifically-sound way to test what will drive the best results and user feedback.

![]()


## Further reading
https://en.wikipedia.org/wiki/A/B_testing
