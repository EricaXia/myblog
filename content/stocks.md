+++
title = "Building a Stock Prices App with Flask, MongoDB, MySQL on GCP, and Spark"
tags = ['APIs', 'Web Scraping','Time Series Data', 'MySQL', 'MongoDB', 'Google Cloud SQL', 'Flask', 'Spark']
date = "2020-03-28"
+++

<!-- TODO: Update image by re-running the app with latest news!! -->
![](/images/app_homepage_final.png#center)


## Introduction

Here's a way to display stock price data fetched from Yahoo Finance, along with relevant news articles pertaining to the companies, and display them in a user-friendly web application interface (UI). The aim is to provide a easy-to-use way to track companies' stock market performance and keep up-to-date with their latest relevant news. 

MySQL on Google Cloud Platform is used to store the stock prices data and MongoDB Atlas (NoSQL cloud database) is used to store the news articles data. 

The application is built using the Python framework Flask, along with the addition of features such as the ability to search both databases by company symbol or date. The stock price data is also aggregated at the industry-level using Apache Spark.



## Project outline
1. Fetch data from Yahoo Finance and Google News using APIs.
2. Store the stock prices (time-series data) in MySQL relational tables on the Google Cloud Platform. 
3. Store the news articles metadata as key-value pair documents in MongoDB Atlas.
4. Unify the data sources within our Flask framework and build the application.
5. Test and deploy.


### 1. Using APIs to Fetch Data

First, the Yahoo Finance data is fetched using the Yahoo Finance API.
Next, the Google News data is fetched using the Google News API.

### 2. Data Storage on GCP 



### 3. Data Storage on MongoDB Atlas.

<!-- Check out my blog post on MongoDB NoSQL databases here.  -->


### 4. Building the Flask Application



### 5. Testing and Deployment

