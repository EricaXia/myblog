+++
title = "Building a Stock Prices App with Flask, MongoDB, MySQL on GCP, and Spark"
tags = ['APIs', 'Web Scraping','Time Series Data', 'MySQL', 'MongoDB', 'Google Cloud SQL', 'Flask', 'Spark']
date = "2020-03-28"
+++

## Introduction

We can display stock price data fetched from Yahoo Finance, along with relevant news articles pertaining to the companies, and display them in a user-friendly web application interface (UI). The aim is to provide a easy-to-use way to track companies' stock market performance and keep up-to-date with their latest relevant news. 

MySQL on Google Cloud Platform is used to store the stock prices data and MongoDB Atlas (NoSQL cloud database) is used to store the news articles data. 

The application is built using the Python framework Flask. The stock price data is also aggregated at the industry-level using Apache Spark.

!! Insert screenshot of app

## Project outline
1. Fetch data from Yahoo Finance and Google News using APIs
2. Store the stock prices (time-series data) in MySQL relational tables on the Google Cloud Platform. 
3. Store the news articles metadata as key-value pair documents in MongoDB Atlas.
4. Unify the data sources within our Flask framework and build the application.
5. Test and deploy.



