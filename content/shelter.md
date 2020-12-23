+++
title = "Flask Web App: Prediction of Animal Shelter Outcomes"
tags = ['Logistic Regression', 'Flask', 'Web Application']
date = "2019-12-06"
+++
### EDA and Logistic Regression Modeling Project
## [**View the app here**](https://animal-shelter-prediction.herokuapp.com)

---

**Description:** 
This project aims to explore animal shelter outcomes for pets given a dataset provided by Sonoma County. Some initial questions I have : 
1. What is the reality of animals being adopted vs. animals being euthanized in Sonoma County pet shelters? 
2. What are common characteristics of pets who are being adopted or euthanized?
3. How can we improve animal shelter outcomes?

[Data source: Sonoma County Animal Shelter Data](https://data.sonomacounty.ca.gov/Government/Animal-Shelter-Intake-and-Outcome/924a-vesw)

---

#### Table of Contents

1. [Data Cleaning](#1-data-cleaning)
2. [Visualization](#2-visualizations)
3. [Modeling & Analysis](#3-modeling-and-analysis)
4. [Web App Deployment to Heroku](#4-web-app-deployment)
---

## 1. Data Cleaning 

The first step in analysis is to read, clean, and organize in order to potentially visualize the data. Some questions we can ask: What some key features and defining characteristics of the dataset? What are the types and distributions of the variables? Are there any visible trends?

An important though sometimes tedious step is to thoroughly clean the data and do feature engineering. We first read in the CSV file and browse the head (first few entries) of the dataset. It's important to identify what features/variables will be important for answering initial questions and doing modeling later on, and drop what won't be used. For this analysis, I decided to focus on just a few key features: Type, Age, Color, Breed, Intake Condition, and Outcome. I also filtered "Type" for only Cats and Dogs, so unknown animal types won't be considered. 

The data is then checked for any missing values (NAs) and outliers. These missing values are removed from the data. Particularly if missing "Outcome Type", then that observation wouldn't be useful for creating a predictor later on. "Age", the only numerical variable, has a few outliers skewed to the far right. Since animals are unlikely to be above twenty or so years of age, these outliers are replaced with the median age.

Some of the other column classes, such as "Intake Condition" have values merged or replaced to simplify the analysis while retaining the accuracy of the data. The initial dataset has a "Color" column for each animal, which could be a unique combination of two or more colors. This column was split into individual "First Color" and "Second Color" columns, duplicates replaced/merged, and all the same colors on one or the other column. A similar procedure was done to standardize the "Breed" column where animals may be a mix of two breeds.

After cleaning and feature engineering, we have a dataset of 7,710 observations and 11 features to work with. Here's what the head of the dataset looks like when finished:

![](https://github.com/EricaXia/shelter/raw/master/imgs/eda1.PNG)


## 2. Visualizations

After cleaning, we can run some basic Exploratory Data Analysis to investigate and better understand our data. 

- What's the count of animals being adopted or not?

![](https://github.com/EricaXia/shelter/raw/master/imgs/eda0.PNG)

From the normalized value counts of the dataset, we have about 60/40 ratio of animals being adopted/euthanized.

- What's the distribution of animal age by outcome type?

![](https://github.com/EricaXia/shelter/raw/master/imgs/eda3.PNG)

On average, euthanized animals have higher average ages. Adopted animals tend to be at younger ages. The distributions both still seem to be right skewed, since most animals won't live as long as twenty years old, and most animals who come into the shelter are of younger age.

- What's the count of animals by type (cat or dog) being adopted?

![](https://github.com/EricaXia/shelter/raw/master/imgs/eda4.PNG)

There's a slightly greater number of cats than dogs overall at the shelter. Thus, more cats get adopted and euthanized compared to dogs. Both cats and dogs get adopted at about the same ratio to total cats and dogs (70% adoption rate).

<br />
## 3. Modeling and Analysis

### 3.1. One Hot Encoding (Categorical) and Standardizing (Numerical)
To train a classifier model, we need to convert all categorical features to numerical so the model can interpret them. Additionally, we'll scale the numerical feature "Age" by standardization.  These tasks are done with the OneHotEncoder and StandardScaler from the scikit-learn library.

### 3.2. Modeling
Once all the features are converted to appropriate formats that the model can interpret, it's time to build the model. In sklearn, a pipeline is defined to transform, split, and model the data. We use a Logistic Regression model with the LBFGS solver. 

```
categorical_transformer = Pipeline(steps = [('onehot', OneHotEncoder(handle_unknown='ignore'))])

preprocessor = ColumnTransformer(
    transformers=[
        ('num', numeric_transformer, numeric_features),
        ('cat', categorical_transformer, categorical_features)])
        
# Append classifier to preprocessing pipeline
clf = Pipeline(steps=[('preprocessor', preprocessor),
                      ('classifier', LogisticRegression(solver='lbfgs', max_iter = 500))])

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)
print("model score: %.3f" % clf.score(X_test, y_test))

# gets the predicted probabilities
prob = clf.predict_proba(X_test)[:,1]

```

As a final visual, we can view the coefficients most positively and negatively correlated with adoption chance.

![](https://github.com/EricaXia/shelter/raw/master/imgs/eda_last.PNG)

The features most strongly impacting adoption chances are animal health. Healthy animals are likely to be adopted, while untreatable animals are very unlikely to be adopted, likely due to low survival rate.

### 3.3. Error Analysis

The ROC and Precision-Recall curves can give us some insight into the model performance. The ROC curve shows the true positive rate and false positive rate (sensitivity and specificity) tradeoff for the logistic regression model. Given the area under the curve (which measures ability to correctly predict class) is 0.86, the model displays some skill in predicting outcomes.

![](https://github.com/EricaXia/shelter/raw/master/imgs/LogReg_ROC.png)

The PRC shows the tradeoff between precision (positive predictive value) and recall (sensitivity) at different classification thresholds (classifying an observation as adopted if probability is above a certain value we vary). Since PRCs tend to be more constant and thus more reliable for imbalanced datasets such as ours, we prefer to use this curve for our analysis. The closer the curve is to the upper right corner, the better the prediction is. (A perfect test would have a curve overlapping the upper right corner with both prec/recall equal to 1.)

![](https://github.com/EricaXia/shelter/raw/master/imgs/pr_curve.png)


## 4. Web App Deployment

The model is contained within a Python script. A web application can create interactivity with users by collecting their input and providing a prediction output. We can build a web application using Flask, a "microframework" for building smaller apps. To collect the data from users, we design an HTML template for users to interact with the web application, with different options (such as animal type, age, and color) to feed into the model.

<center>
{{< figure library="true" src="htmlform.png" title="Static HTML Form" lightbox="true" >}}
</center>


After creating the static page, we use Flask to host it. First, a conda virtual environment is created to contain all dependencies. Then, we create a Python file called 'script.py' used to run Flask and the model. In the code below, the ValuePredictor function takes in the user's input from the form, converts the input to the correct format, and feeds it to the model (stored in a .pkl file). The function returns the final prediction and predicted probability.

```
def ValuePredictor(to_predict_list):
    to_predict_dict = {k: v for k, v in zip(cols, to_predict_list)}
    to_predict = pd.DataFrame(data=to_predict_dict, columns=cols, index=[0])
    loaded_model = pickle.load(open("clf_model.pkl","rb"))
    result = loaded_model.predict(to_predict)
    prob = loaded_model.predict_proba(to_predict)[:,0]
    return(result[0], prob[0])


@app.route('/result',methods = ['POST'])
def result():
    if request.method == 'POST':
        to_predict_list = request.form.to_dict()
        to_predict_list=list(to_predict_list.values())
        outcome = ValuePredictor(to_predict_list)
        
        if outcome[0]== "ADOPTION":
            prediction = 'ADOPTION'
            probability = '{:.2%}'.format(np.round(outcome[1], decimals=2))
            
            
        elif outcome[0] == "EUTHANIZE":
            prediction='EUTHANIZE'
            probability = '{:.2%}'.format(np.round(outcome[1], decimals=2))
            
        return render_template("result.html", prediction = prediction, probability = probability)

```

A separate HTML file displaying the prediction and probability is created to show the user's results. To host the app online, we deploy the app to Heroku, a free plaform that lets us run apps online in the cloud. 

{{< figure library="true" src="heroku.png" lightbox="true" >}}