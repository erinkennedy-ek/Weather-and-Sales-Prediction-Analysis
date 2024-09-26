# Weather-and-Sales-Prediction-Analysis

This repository contains data, R scripts, and initial models built to analyse how weather affects Irish fast food sales. The analysis uses both random forest and linear regression models. Data is sourced from two Midlands fast food restaurants, spanning May 2021 to May 2024

## Project Overview

The analysis involves two key datasets and four primary R scripts:

### Datasets:
1. **Weather_Sales_2021_24.csv**:
   - Daily sales data from two fast food restaurants (2021-2024), along with weather data.
   - Used for Random Forest modelling to predict sales based on weather.

2. **Product_Sales_Transposed.csv**:
   - Contains categories of products sold in one of the restaurants.
   - Used for linear regression analysis to determine how weather affects individual product sales.

### R Scripts:
1. **Customer_Behaviour_Product_Linear_Regression.R**:
   - Contains linear regression models for each product category to identify important weather variables influencing sales.

2. **Correlation_Matrix.R**:
   - Provides visualisations such as scatterplot matrices and correlation matrices to analyse relationships between product sales and weather variables.

3. **Customer_Behaviour_Model_Performance_Metrics.R**:
   - Produces a graphic (dual-axis barplot and lineplot) showing the performance metrics (MAE, RMSE, R-squared) of the Random Forest models used in the analysis.

4. **Customer_Pref_Random_Forest.R**:
   - Contains the code to build and evaluate five Random Forest models, designed to predict customer preferences and sales based on weather and sales patterns.
   - The most impressive four models are discussed in the thesis.

## Model Performance Summary

- The Random Forest models show varying accuracy, with performance metrics such as Mean Absolute Error (MAE), Root Mean Square Error (RMSE), and R-squared values compared across different models.
- The linear regression models helped identify which weather variables (e.g., temperature, humidity) were most influential for individual product categories.

## How to Use

1. **Data**: Load the `Weather_Sales_2021_24.csv` and `Product_Sales_Transposed.csv` datasets into R.
2. **Run Models**:
   - Use the **Customer_Behaviour_Product_Linear_Regression.R** script to replicate the linear regression analysis on product sales.
   - Use **Customer_Pref_Random_Forest.R** to build the Random Forest models. 
3. **Visualisations**: Evaluate by inserting metrics into **Customer_Behaviour_Model_Performance_Metrics.R** from Random Forest models. Use **Correlation_Matrix.R** to explore the relationship between product/weather variables visually.

## Future Work

- Further optimisation of both the Random Forest and Linear Regression models is necessary.

- Feature engineering and hyperparameter tuning should be applied to the Random Forest models to achieve higher predictive power.
