from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.model_selection import train_test_split
!pip install seaborn
import pandas as pd
import numpy as np
import matplotlib.pyplot as mp
import seaborn as sb

# read csv file and preview data
df2 = pd.read_csv("life_expectancy_data.csv")
df2.head()

# make headers snake case
df2.columns = [x.lower() for x in df2.columns]
df2.columns = df2.columns.str.replace("[ ]", "_", regex=True)

df2.rename(columns = {
    "life_expectancy_": "life_expectancy",
    "measles_": "measles",
    "_thinness__1-19_years": "thinness_5-19_years",
    "_thinness_5-9_years": "thinness_5-9_years",
    "_bmi_": "bmi",
    "under-five_deaths_": "under_five_deaths",
    "diphtheria_": "diphtheria",
    "_hiv/aids": "hiv/aids"
    }, inplace = True)

print(df2.columns)

# drop na rows
df2 = df2.dropna().reset_index(drop=True)

# check no. of rows after dropping na rows
len(df2.index)

# seaborn correlation heatmap
print(df2.corr())

dataplot = sb.heatmap(df2.corr())
mp.show()

# prepare data
# hypothesis 1: life_expectancy = f(alcohol, bmi, hiv/aids)
# hypothesis 2: life_expectancy = f(bmi, income_composition_of_resources, schooling)
# hypothesis 3: life_expectancy = f(alcohol, bmi, schooling)
X = df2[ ["bmi", "income_composition_of_resources", "schooling"] ]
y = df2[ "life_expectancy" ]

# split data: train 80, test 20
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# train 1: linear model
model1 = LinearRegression()
model1.fit(X_train, y_train)

# train 2: random forest
model2 = RandomForestRegressor()
model2.fit(X_train, y_train)

# train 3: KNeighborsRegressor
model3 = KNeighborsRegressor()
model3.fit(X_train, y_train)

# test models
pred1 = model1.predict(X_test)
pred2 = model2.predict(X_test)
pred3 = model3.predict(X_test)

# evaluate model
# MAE
mae1 = np.mean(np.absolute(y_test - pred1))
mae2 = np.mean(np.absolute(y_test - pred2))
mae3 = np.mean(np.absolute(y_test - pred3))

# MSE
mse1 = np.mean((y_test - pred1)**2)
mse2 = np.mean((y_test - pred2)**2)
mse3 = np.mean((y_test - pred3)**2)

print(f"linear model: mae = {mae1}, mse = {mse1}")
print(f"random forest model: mae = {mae2}, mse = {mse2}")
print(f"KNN model: mae = {mae3}, mse = {mse3}")

"""
Results from hypothesis 1:
f(alcohol, bmi, hiv/aids)
linear model: mae = 4.155678439323432, mse = 28.893475979308928
random forest model: mae = 2.3354817676767685, mse = 10.482935125436875
KNN model: mae = 2.8727272727272726, mse = 14.123684848484851

Results from hypothesis 2:
f(bmi, income_composition_of_resources, schooling)
linear model: mae = 3.99193775273157, mse = 27.062286239805264
random forest model: mae = 2.2785181818181828, mse = 9.871165427272706
KNN model: mae = 3.67169696969697, mse = 26.591938181818186

Results from hypothesis 3:
f(alcohol, bmi, schooling)
linear model: mae = 4.492796198058538, mse = 32.316142975552275
random forest model: mae = 2.7383484848484825, mse = 14.337098851515144
KNN model: mae = 3.247030303030303, mse = 19.394938181818183

Conclusion:
Random forest is the best model of all three. Hypothesis 2 is the most accurate.
*life expectancy = f(bmi, income composition of resources, schooling)
*income composition of resources = rate at which society has a higher, middle, or lower-incom class. (high %, high life expectancy)
"""

r_squared1 = model1.score(X, y)
r_squared2 = model2.score(X, y)
r_squared3 = model3.score(X, y)

print(r_squared1, r_squared2, r_squared3)
