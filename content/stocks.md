+++
title = "Building a Stock Prices App with Flask, MongoDB, MySQL on GCP, and Spark"
tags = ['APIs', 'Web Scraping','Time Series Data', 'MySQL', 'MongoDB', 'Google Cloud SQL', 'Flask', 'Spark']
date = "2020-03-28"
+++

<!-- TODO: Update image by re-running the app with latest news!! -->
![](/images/app_homepage_final.png)


## Introduction

This web application displays stock price data fetched from Yahoo Finance, along with relevant news articles pertaining to the companies, and display them in a user-friendly web application interface (UI). The aim is to provide a easy-to-use way to track companies' stock market performance and keep up-to-date with their latest relevant news. 

![](/images/tools-stock-app.png)

**MySQL on [Google Cloud Platform](https://cloud.google.com/sql)** is used to store the stock prices data and **[MongoDB Atlas](https://www.mongodb.com/cloud)** (NoSQL cloud database) is used to store the news articles data. 

The application is built using the Python framework **[Flask](https://flask.palletsprojects.com/en/1.1.x/)**, along with the addition of features such as the ability to search both databases by company symbol or date. The stock price data is also aggregated at the industry-level using **[Apache Spark](https://spark.apache.org/docs/latest/)**.

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


### 2. Data Storage on GCP 

The stock price data for the relevant date range is collected and inserted into the Google Cloud Platform (GCP) database. MySQL, one of the most popular open-source SQL databases, is the database chosen. Its many features include complete ACID support, scability, high-performance engine, ANSI-standard SQL, and much more. GCP is an easy and inexpensive way to store data in the cloud with SQL instances. The database will be accessed by the app later.

Within Python, the package [PyMySQL](https://pymysql.readthedocs.io/en/latest/) is used to connect to the cloud database. 
```
for i in Symbols:
    symbol = yf.Ticker(i)
    df = symbol.history(start=start, end=end)
        cur.execute("CREATE TABLE " + i + "(date date,open varchar(250),high varchar(250),low varchar(250),close varchar(250),volume varchar(250),dividends varchar(250))")
        for row in df.iterrows():
            date = row[1][7]
            open1 = row[1][0]
            high = row[1][1]
            low = row[1][2]
            close = row[1][3]
            volume = row[1][4]
            dividends=row[1][5]
            cur.execute(f"INSERT INTO " + i + "(date,open,high,low,close,volume,dividends) VALUES " + f"('{date}','{open1}','{high}','{low}','{close}','{volume}','{dividends}');")
```  
![](/images/gcp-stock-db.png)


<!-- Check out my blog post on getting started with MySQL on GCP [here](link).  -->

![]()

### 3. Data Storage on MongoDB Atlas.

After scraping the news data for S&P 500 companies in the date range specificed, the data is cleaned and transformed in Jupyter notebooks before being uploaded directly to the collections in MongoDB Atlas. The [PyMongo](https://pymongo.readthedocs.io/en/stable/) package is used to connect to the database. 

<!-- Check out my blog post on MongoDB NoSQL databases [here](link). -->

![](/images/stocks-mongodb.png)

![]()

### 4. Data Transformation and Aggregation with Spark

Apache Spark is utilized for data cleaning, transformation, and aggregation. After the raw data is pulled from Yahoo Finance for each company and date, the [PySpark](https://spark.apache.org/docs/latest/api/python/index.html) package facilitates the usage of Spark's parallel processing capabilities. 

Example of how industry-level data is aggregated with Spark:
```
sc = SparkContext.getOrCreate()
spark = SparkSession(sc)
stockspark = spark.read.json('stockdata.json')
companyspark = spark.read.json('companyinfo.json')
sectorjoin = stockspark.join(companyspark, stockspark.name == companyspark.Symbol).select(stockspark.date, companyspark.Symbol,
                                                                                          stockspark.open, stockspark.close, stockspark.high, stockspark.low, stockspark.volume, stockspark.dividends, companyspark.Sector)
health_care = sectorjoin[(sectorjoin.Sector == 'Health Care')].groupBy(['Symbol', 'Sector']).agg(
    fc.max('close').alias('Period_High'), fc.min('close').alias('Period_Low'))
information_technology = sectorjoin[(sectorjoin.Sector == 'Information Technology')].groupBy(
    ['Symbol', 'Sector']).agg(fc.max('close').alias('Period_High'), fc.min('close').alias('Period_Low'))

```

The resulting transformed data is the high, or max price, and low, or min price, over the entire time period, as well as the date of the occurring high or low price. Each row represents a company in the specified industry.

The project includes the industries organized by sectors of the S&P 500: **Health Care, Information Technology, Communication Services, Consumer Discretionary, Utilities, Financials, Materials, Real Estate, Consumer Staples, and Energy**.

The Spark results are stored in additional tables in the MySQL cloud database.

![]()

### 5. Building the Flask Application

The aim is to build a UI that unifies all these data sources (MySQL on GCP, MongoDB) to display the database results in a user-friendly manner, along with providing additional search capabilities.

[Flask](https://flask.palletsprojects.com/en/1.1.x/) is a lightweight microframework for building web applications. The flexibility and easy integration with both SQL and NoSQL databases makes Flask an ideal choice for this project.

Project Structure:
![](/images/stock-directory.png)


```
from flask import Blueprint, render_template, Flask, request, make_response, redirect, url_for
from pymysql import ProgrammingError
from .extensions import mongo, open_connection, get_companies, get_company_name_sector, get_prices, search_by_date, get_current_close_price, get_agg_prices, search_by_sym
from .forms import SymSearchForm, DateSearchForm

main = Blueprint('main', __name__)

# Main Page


@main.route('/', methods=['GET', 'POST'])
def index():

    # define MongoDB collection
    news_col = mongo.db.articles
    mdb_results = news_col.find().limit(15).sort("dt", -1)
    sql_results = get_companies(limit=20)  # a list of dicts

    # Search feature
    form = SymSearchForm(request.form)
    if request.method == 'POST':
        sym_query = form.symbol.data
        return redirect(url_for('.show', sym=sym_query))

    return render_template('index.html', mdb_results=mdb_results, sql_results=sql_results, form=form)


# Page template to show company stock info
@main.route('/<sym>', methods=['GET', 'POST'])
def show(sym):

    # SQL results for the company
    price_results = get_prices(symbol=sym, limit=40)  # a list of dicts
    # Mongo results
    news_col = mongo.db.articles
    mdb_results = news_col.find({"Symbol": sym}).limit(15).sort("dt", -1)

    # Search feature
    form = DateSearchForm(request.form)
    if request.method == 'POST' and form.validate():
        dt_query = form.date.data
        dt_query_str = str(dt_query)
        # Search MySQL db for prices on a given date
        price_res = search_by_date(
            symbol=sym, date=dt_query)  # a list of dicts
        # Search MongoDB for news on a given dt
        news_res = news_col.find({"Symbol": sym, "dt": dt_query_str}).limit(
            15).sort("dt", -1)  # this is a cursor
        new_res_list = list(news_res)

        return render_template('search_results.html', sym=sym, form=form, price_results=price_res, news_results=news_res, news_res_list=new_res_list)

    # Show current price
    current_price = get_current_close_price(sym)
    # Get full company name
    name_sector = get_company_name_sector(sym)
    c_name = name_sector['name']
    s_name = name_sector['sector']
    ind_link0 = "Industry_" + s_name.replace(" ", "_")
    ind_link = f"/spark/{ind_link0}"
    return render_template('page.html', symbol=sym, price_results=price_results, mdb_results=mdb_results, form=form, current_price=current_price, c_name=c_name, industry=s_name, ind_link=ind_link)

```


---
<!-- TODO: -->
## \* *Page under construction* *
---
![]()

![]()

<!-- Overall, the highlight of this project was accessing APIs to gather the data, storing data using different storage solutions, and integrating it all together in a meaningful way on an intuitive user interface. This way a user can research a company or industry of interest, and immediately view recent prices and news articles for that company, and its industry-aggregated data.
 -->


 
[View the code on GitHub here.](https://github.com/EricaXia/stock_app)
