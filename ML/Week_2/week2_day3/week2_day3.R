#install.packages('caTools')
library(caTools)


# Reading the data from the csv file and assign it to data variable.
data <- read.csv("/Users/ahmadbasha/Desktop/week2_day3/boston.csv")
# View the data
View(data)
# Print the structure of the data
str(data)

# save the result by seed 
set.seed(2)
# split the data 
split = sample.split(data, SplitRatio =.80)
training_set = subset(data, split == TRUE) # Set True for train set
test_set = subset(data, split == FALSE) # Set false for Test set

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Note: There is no need to do feature scaling since the package we are using takes care of this for us

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = target ~ RM+LSTAT+PTRATIO+TAX+INDUS,
               data = training_set)

# Another indication of statistical significance if the p-value is less than 5%
# we can see there are 3 stars with RM,LSTAT,PTRATIO  which means they are very 
# important to affect the target and a dot with INDUS and nothing for TAX 
summary(regressor)


# To get the coefficients 
regressor$coefficients
# This gives the intercept
regressor$coefficients[1]
# This gives the coefficient
regressor$coefficients[2]


# Predicting the test
y_pred = predict(regressor, newdata = test_set)
# actual 
y_actual <- test_set$target

# the error
error <- y_pred - test_set$target 

percent_error <- abs(error)/y_pred
percent_error <- round(percent_error,2)

# Create new variable to hold errors
df_multi <- data.frame(y_pred, y_actual, error, percent_error)
# we can see we have many big errors and some small erros. 
# in index 20 with 0.00 which is the best and 413 has a big error 
View(df_multi)

################### improve 

# so , we can make the improve the model by taking the thrree stars columns 
#  RM,LSTAT,PTRATIO 
regressormlr = lm(formula = target ~ RM+LSTAT+PTRATIO,
               data = training_set)
# we can see all thre stars except Intercept with two stars 
# also RSE increase littl bit from 5.27 to 5.283 now
summary(regressormlr)

# Predicting the test
y_pred_mlr= predict(regressormlr, newdata = test_set)
# actual 
y_actual_mlr <- test_set$target

# the error
error_mlr <- y_pred_mlr - test_set$target 

percent_error_mlr <- abs(error_mlr)/y_pred_mlr
percent_error_mlr <- round(percent_error_mlr,2)

# Create new variable to hold errors
df_multi_mlr <- data.frame(y_pred_mlr, y_actual_mlr, error_mlr, percent_error_mlr)
# we can see we have many big errors and some small erros. 
# in index 20 with 0.00 which is the best and 413 still has a big error
View(df_multi_mlr)

# for me i think the first model and the second model there is no big different 
# between them because RSE increase littl bit from 5.27 to 5.283 now
# maybe if we have a larger i might choose the second one but with this two 
# i'll go with the first one 




