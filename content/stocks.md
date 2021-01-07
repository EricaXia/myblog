+++
title = "Building a Stock Prices App with Flask, MongoDB, MySQL on GCP, and Spark"
tags = ['APIs', 'Web Scraping','Time Series Data', 'MySQL', 'MongoDB', 'Google Cloud SQL', 'Flask', 'Spark']
date = "2020-03-28"
+++

<!-- TODO: Update image by re-running the app with latest news!! -->
![](/images/app_homepage_final.png)


## Introduction

This web application displays stock price data fetched from Yahoo Finance, along with relevant news articles pertaining to the companies, and display them in a user-friendly web application interface (UI). The aim is to provide a easy-to-use way to track companies' stock market performance and keep up-to-date with their latest relevant news. 

![](/images/tools_stock.png)

**MySQL on Google Cloud Platform** is used to store the stock prices data and **MongoDB Atlas** (NoSQL cloud database) is used to store the news articles data. 

The application is built using the Python framework **Flask**, along with the addition of features such as the ability to search both databases by company symbol or date. The stock price data is also aggregated at the industry-level using **Apache Spark**.

![]()

---

#### Project outline
1. Fetch data from Yahoo Finance and Google News using APIs.
2. Store the stock prices (time-series data) in MySQL relational tables on the Google Cloud Platform. 
3. Store the news articles metadata as key-value pair documents in MongoDB Atlas.
4. Data transformation and aggregation with Apache Spark
5. Unify the data sources within our Flask framework and build the application.

---
![]()

 ### 1. Using APIs to Fetch Data

First, the Yahoo Finance data is fetched using the [Yahoo Finance API](https://pypi.org/project/yahoo-finance/) (Python module). A date range is specified to gather stock prices for a given company. This project focuses on gathering prices for companies on the **S&P 500**. The data ranges from the beginning of the year 2020 (2020-01-02 is the first date) till the latest time the data is retrieved. Stock data is not collected when the market closes (weekends, holidays). The time-series stock price data consists of daily open price, highest, lowest, close price, daily trading volume, dividends paid, stock splits and date. 

Next, the Google News data is fetched using the [Google News API](https://pypi.org/project/GoogleNews/), which in turns gathers news stories from many different media outlets. Like the stock price data, a date range is specified to gather news data and also search specifically for a company name or ticker symbol from the S&P 500. The data consists of news headlines, a brief description, the URL of the original article, and the date.


![]()

---
<!-- TODO: -->
## \* *Page under construction* *
---
![]()

### 2. Data Storage on GCP 

The stock price data for the relevant date range is collected and first inserted into a local MySQL database instance. Then the records are uploaded directly to the Google Cloud SQL database. 

MySQL is the type of database chosen.

GCP is an easy and free way to store data in the cloud. It will be accessed by the app later.

<!-- Check out my blog post on getting started with MySQL on GCP [here](link).  -->

<!-- INSERT SCREENSHOTS HERE  -->

![]()

### 3. Data Storage on MongoDB Atlas.

The news data for S&P 500 companies in the date range is collected and uploaded directly to the collections in MongoDB Atlas with the help of PyMongo. 

<!-- Check out my blog post on MongoDB NoSQL databases [here](link). -->

<!-- INSERT SCREENSHOTS HERE -->

![]()

### 4. Data Transformation and Aggregation with Spark

Apache Spark is utilized for data cleaning, transformation, and aggregation. After the raw data is pulled from Yahoo Finance for each company and date, the PySpark package facilitates the usage of Spark's parallel processing capabilities. 

<!-- Check out my blog post on Spark [here](link). -->

<!-- INSERT SCREENSHOT -->

The resulting transformed data is the high, or max price, and low, or min price, over the entire time period, as well as the date of the occurring high or low price. Each row represents a company in the specified industry.

The Spark results are stored in additional tables in the MySQL database on GCP.

![]()

### 5. Building the Flask Application

The aim is to build a UI that unifies all these data sources (MySQL on GCP, MongoDB) to display the database results in a user-friendly manner, along with providing additional search capabilities.

Flask is a lightweight microframework for building web applications. The flexibility and easy integration with both SQL and NoSQL databases makes Flask an ideal choice for this project.







![]()

<!-- Overall, the highlight of this project was accessing APIs to gather the data, storing data using different storage solutions, and integrating it all together in a meaningful way on an intuitive user interface. This way a user can research a company or industry of interest, and immediately view recent prices and news articles for that company, and its industry-aggregated data.
 -->


 
[View the code on GitHub here.](https://github.com/EricaXia/stock_app)
