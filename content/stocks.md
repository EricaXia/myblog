+++
title = "Building a Stock Prices App with Flask, MongoDB, MySQL on GCP, and Spark"
tags = ['APIs', 'Web Scraping','Time Series Data', 'MySQL', 'MongoDB', 'Google Cloud SQL', 'Flask', 'Spark']
date = "2020-03-28"
+++

<!-- TODO: Update image by re-running the app with latest news!! -->
![](/images/app_homepage_final.png)


## Introduction

Here's a way to display stock price data fetched from Yahoo Finance, along with relevant news articles pertaining to the companies, and display them in a user-friendly web application interface (UI). The aim is to provide a easy-to-use way to track companies' stock market performance and keep up-to-date with their latest relevant news. 

![](/images/tools_stock.png)

**MySQL on Google Cloud Platform** is used to store the stock prices data and **MongoDB Atlas** (NoSQL cloud database) is used to store the news articles data. 

The application is built using the Python framework **Flask**, along with the addition of features such as the ability to search both databases by company symbol or date. The stock price data is also aggregated at the industry-level using **Apache Spark**.

![]()

---

## Project outline
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







<!-- TODO: -->
\* *Page under construction* *




<!-- ### 2. Data Storage on GCP 

### 3. Data Storage on MongoDB Atlas.

Check out my blog post on MongoDB NoSQL databases here.   

### 4. Data Transformation and Aggregation with Spark

we used Spark to do data cleaning, transformation, and aggregation. After pulling the raw data from Yahoo Finance for each company and date, we use the PySpark package to use the parallel processsing capabilities of Spark and Spark RDDs. We get the resulting transformed data as the high, or max price, and low, or min price, over the entire time period, as well as the date of the occuring high or low price. Each row represents a company in the specified industry.

We can also search by symbol on the industry aggregated data as well, FOr instance if we search the stock symbol for Microsoft, MSFT, we get the resulting aggregated data for Microsoft.

### 5. Building the Flask Application -->










<!-- Overall, the highlight of this project was accessing APIs to gather the data, storing data using different storage solutions, and integrating it all together in a meaningful way on an intuitive user interface. This way a user can research a company or industry of interest, and immediately view recent prices and news articles for that company, and its industry-aggregated data.
 -->


 
[View the code on GitHub here.](https://github.com/EricaXia/stock_app)
