+++
title = "What is Differential Privacy?"
description = "Today, as AI/ML technologies proliferate across diverse industries and use cases, the notion of data privacy is more important than ever."
tags = ['differential privacy', 'privacy', 'AI/ML', 'statistics', 'cryptography']
date = "2021-06-15"
draft = true
+++

Privacy is very important.

* healthcare data determine if patient in a study - sensitive medical information
- Pharmacuetical trials
- hospital records
- Covid 19 studies .. possiblities are endless
* uber taxi rides - e.g. dont want people to know identity of a person e.g. a celebrity rode in a car and where
* traffic statistics like on google maps - we dont want indiv ppls traffic patterns to appear
* voter records
* movie reviews (e.g. the de anonymized netflix prize example)


## What is Differential Privacy?

DP is this....

"Gold standard" of privacy

formalized, mathemtically rigorous definition of data privacy

Notion of DP has had a lot of investigation in academia, but still limited in its use and implementation to real world cases other than at big companies like Google, Microsoft, etc.

The reason it's called "differential" privacy is because the difference between the world without the individual's data and the world with the individual's data should have roughly the same output. So that an adversary would not know the difference.


## Attacks

## Local v Global DP

## Overview of implementation, tools, projects
* Add noise to data
	- SmartNoise part of OpenDP project
* Privacy / query budget
* DP models
* DP-SGD like in DL models


## Tradeoffs?
* Accuracy
