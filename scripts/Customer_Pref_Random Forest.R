# Sheet 1 of Weather Sales 2021-24, Includes Delivery


install.packages("caTools")
install.packages('randomForest') 
install.packages('caret')  
install.packages("dplyr") 
install.packages('e1071', dependencies=TRUE)
names(daily_data)
library("dplyr")                       
library(caTools)
library(randomForest)
library(caret)
library(readxl)

daily_data <- read_excel("~/EK_Predictions_RStudio/Data_Files/Weather_Sales_2021_24.xlsx",
                         sheet= 1, skip=24)

daily_data <- na.omit(daily_data)
daily_data <- subset(daily_data, Final_Total != 0)
names(daily_data)
print(head(daily_data))
#View(daily_data)
daily_data$sun <- as.numeric(daily_data$sun)
#daily_data$Net_Total <- as.numeric(daily_data$Net_Total)
daily_data$Final_Total <- as.numeric(daily_data$Final_Total)
#daily_data$Avg_Amt <- as.numeric(daily_data$Avg_Amt)
#daily_data$Trans_Count <- as.numeric(daily_data$Trans_Count)

dim(daily_data) 
str(daily_data)
summary(daily_data$Final_Total)  

set.seed(100)
train <- sample(nrow(daily_data), 0.8*nrow(daily_data), 
                replace = FALSE)
data_train <- daily_data[train,]
data_test <- daily_data[-train,]
names(daily_data)

dim(data_train) 
head(data_train)

dim(data_test)  
head(data_test)

bestmtry <- tuneRF(data_train,data_train$Final_Total,stepFactor = 1.2, improve = 0.01, trace=T, plot= T) #32

#Model 1 - allmodel
allmodel <- randomForest(Final_Total~.,data= data_train)
allmodel                  #var=84.12      

importance(allmodel)

varImpPlot(allmodel) # imp = store_id, day,date, glorad, wdsp

pred_test <- predict(allmodel, newdata = data_test) 
pred_test

mae <- mean(abs(pred_test - data_test$Final_Total))
rmse <- sqrt(mean((pred_test - data_test$Final_Total)^2))

print(paste("MAE:", mae)) #"MAE: 644.31"

print(paste("RMSE:", rmse)) #"RMSE: 993.08"

plot(data_test$Final_Total, pred_test, 
     xlab = "Actual", ylab = "Predicted",
     main = "Actual vs Predicted Sales")

abline(0, 1, col = "red")

# SECOND MODEL - tunedallmodel
#Rf model with optimal mtry (19)

tunedallmodel <- randomForest(Final_Total ~ ., data = data_train, mtry = 32)
tunedallmodel        #87.08 var                

importance(tunedallmodel)                       
varImpPlot(tunedallmodel)          #sore_id, day, date, month, glorad, cbl                        

pred_test <- predict(tunedallmodel, newdata = data_test)
pred_test

mae <- mean(abs(pred_test - data_test$Final_Total))
rmse <- sqrt(mean((pred_test - data_test$Final_Total)^2))

print(paste("MAE:", mae)) # MAE: 588.17
print(paste("RMSE:", rmse)) #"RMSE: 922.25

plot(data_test$Final_Total, pred_test, 
     xlab = "Actual", ylab = "Predicted",
     main = "Actual vs Predicted Sales")

abline(0, 1, col = "red")

# THIRD MODEL - climatemodel

set.seed(100)
train <- sample(nrow(daily_data), 0.8*nrow(daily_data), 
                replace = FALSE)
data_train <- daily_data[train,]
data_test <- daily_data[-train,]

str(daily_data)
climatemodel <- randomForest(Final_Total ~ rain + sun + glorad + month + 
                               wdsp + maxtp + mintp + avgtp+ gmin + cbl + hm + ddhm + hg + 
                               soil + pe + evap + smd_wd + smd_md + smd_pd + 
                               rain_category + rain_class +dp+svp+avp+vp+rh+humidex+
                               humidex_class,
                             data = data_train)

climatemodel   #=53.34% var                     

importance(climatemodel)

varImpPlot(climatemodel) #cbl, glorad, gmin, rh, ddhm 

pred_test <- predict(climatemodel, newdata = data_test)
pred_test

mae <- mean(abs(pred_test - data_test$Final_Total))
rmse <- sqrt(mean((pred_test - data_test$Final_Total)^2))

print(paste("MAE:", mae)) # "MAE: 2407.84

print(paste("RMSE:", rmse)) #"RMSE: 2695.32

plot(data_test$Final_Total, pred_test, 
     xlab = "Actual", ylab = "Predicted",
     main = "Actual vs Predicted Sales")

abline(0, 1, col = "red")

#FOURTH MODEL -tunedclimatemodel

set.seed(100)
train <- sample(nrow(daily_data), 0.8*nrow(daily_data), 
                replace = FALSE)
data_train <- daily_data[train,]
data_test <- daily_data[-train,]

bestmtry <- tuneRF(data_train,data_train$Final_Total,stepFactor = 1.2, improve = 0.01, trace=T, plot= T) 

tunedclimatemodel <- randomForest(Final_Total ~ rain + sun + glorad + month + 
                                    wdsp + maxtp + mintp + avgtp+ gmin + cbl + hm + ddhm + hg + 
                                    soil + pe + evap + smd_wd + smd_md + smd_pd + 
                                    rain_category + rain_class +dp+svp+avp+vp+rh+humidex+
                                    humidex_class, data = data_train, mtry = 32)

tunedclimatemodel                  #-54.79% var      

importance(tunedclimatemodel)

varImpPlot(tunedclimatemodel) #cbl, rh, glorad, ddhm, gmin, wdsp



pred_test <- predict(tunedclimatemodel, newdata = data_test)
pred_test



mae <- mean(abs(pred_test - data_test$Final_Total))
rmse <- sqrt(mean((pred_test - data_test$Final_Total)^2))

print(paste("MAE:", mae)) # "MAE: 2418.11

print(paste("RMSE:", rmse)) # "RMSE: 2708.54

plot(data_test$Final_Total, pred_test, 
     xlab = "Actual", ylab = "Predicted",
     main = "Actual vs Predicted Sales")

abline(0, 1, col = "red")

#FIFTH MODEL - primaryclimatemodel

primaryclimatemodel <- randomForest(Final_Total ~ rain + sun + glorad + month + 
                               wdsp + maxtp + mintp + avgtp+ cbl+ soil + evap +rh
                               + day+date+pe,
                             data = data_train)


primaryclimatemodel                  #-45.65     

importance(primaryclimatemodel)

varImpPlot(primaryclimatemodel) #day, date, wdsp, glorad,rh

pred_test <- predict(primaryclimatemodel, newdata = data_test)
pred_test

mae <- mean(abs(pred_test - data_test$Final_Total))
rmse <- sqrt(mean((pred_test - data_test$Final_Total)^2))

print(paste("MAE:", mae)) # "MAE: 2376

print(paste("RMSE:", rmse)) # "RMSE: 2645

plot(data_test$Final_Total, pred_test, 
     xlab = "Actual", ylab = "Predicted",
     main = "Actual vs Predicted Sales")

abline(0, 1, col = "red")

