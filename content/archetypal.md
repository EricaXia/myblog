+++
title = "Archetypal Analysis"
+++

#### What is Archetypal Analysis (AA)?

![](/images/aa_1.jpg)

AA is a type of **unsupervised clustering learning method** to find groups, or segments, of data. It is "unsupervised" in the sense that this process defines groups without knowing ahead of time what they will look like. The machine identifies them without being trained by labeled instances.

Compared to another unsupervised method such as k-means, AA finds extreme points on the boundaries of the data set. This works well for an example use case such as [customer segmentation](https://en.wikipedia.org/wiki/Market_segmentation), which would be served better by identifying unique groups with distinguishable characteristics, rather than multiple groups that seem similar to each other.

Archetypal analysis works by representing the data observations as *convex combinations* of extreme points, which represent our *archetypes*. How the algorithm finds these points is via estimation of the *Principal [Convex Hull](https://en.wikipedia.org/wiki/Convex_hull) (PCH)*, which is basically the border enclosing all the points. You can picture it as a rubber band stretching over the furthest-out "corners" of the data.

 > A convex combination is a linear combination of points (which can be vectors, scalars, ..), with the extra constraints that all coefficients (of the terms) are non-negative and sum to 1.


Main equation for AA algorithm:

$$ ||X-XCS||^2_F $$

To estimate these outermost points, the algorithm aims to find matrices C and S, which generate the PCH (and the archetypes) of the data matrix X, by minimizing the difference between the original data matrix X and the approximations represented by the product XCS. This is also called [residual sum of squares](https://en.wikipedia.org/wiki/Residual_sum_of_squares) (RSS). 

 > RSS is a matrix norm. First, find this matrix difference then calculate the norm as the square root of the sum of the squares of the elements of the matrix. So it's like a vector norm that represents size or magnitude.

 $$ RSS = ||X - \alpha Z^T||_2 $$


The matrix C describes how the archetypes are constructed from the observations (say, customers or users to segment) in X. In the image, archetype #1 is a convex combination of multiple users. C contains these users' coefficients.

Archetypes matrix is represented by product XC. 

The S matrix captures how each user can be described in terms of the archetypes in XC. S is the percentage projections matrix, where users are represented as percent mixtures of archetypes. 
* S is an n x k matrix (n = number of observations, k = number of archetypes given)

For practical purposes, the number of archetypes k will need to be iteratively tweaked and the results analyzed. In a business context, this may be finding the balance (and sometimes trade-off) between interpretability or usability and measurement scores.


This code implements a method proposed by Morup and Hansen in their [2012 paper](https://www.sciencedirect.com/science/article/abs/pii/S0925231211006060), to find matrices C and S.

-	The FurthestSum procedure finds the location of the (k) extreme points on the PCH
-	New point j_new = argmax(sum of norm(xi-xj), j is contained in C)
-	A projected gradient method simultaneously updates C and S
-	(projected gradient = gradient descent with constraints)
-	The problem is recast as l1-normalization variables (new equations for ~s and ~c). Each alternating update is performing on all elements (C and S) simultaneously, with μ as a step-size parameter tuned by line-search.
-	The line-search method seeks the minimum of a defined nonlinear function by selecting a reasonable direction vector that, when computed iteratively with a reasonable step size, will provide a function value closer to the absolute minimum of the function 
	- Formulas for these variables can be viewed in the paper
-	This is a non-convex optimization problem [it may have multiple feasible regions]. The algorithm only finds local minimum solutions, so there may be varying results depending on the random seed that’s set.


---
Sources
* [Cutler and Breiman, Archetypal Analysis](https://digitalassets.lib.berkeley.edu/sdtr/ucb/text/379.pdf)