# Weather-and-Sales-Prediction-Analysis

# Weather and Sales Prediction Analysis

This repository contains data and initial models built to analyse how weather affects Irish fast food sales. Data was gathered from two restaurants within the Midlands region of Ireland, spanning from May 2021 to May 2024.

## Project Overview

The analysis involves two key datasets:

1. **Weather_Sales_2021_24.csv**:
   - This dataset contains daily sales data from two fast-food restaurants between 2021 and 2024. It also includes weather parameters like temperature, humidity, wind speed, etc.
   - The goal of this dataset was to build **Random Forest models** to determine if fast food sales can be predicted by sales patterns and weather conditions.

2. **Product_Sales_Transposed.csv**:
   - This dataset contains sales information for various product categories within one of the restaurants. It was used to analyse which weather variables most significantly impact the sales of individual products.
   - **Linear regression models** were applied to identify the important weather factors affecting each product's sales.

## Models and Approach

- The Random Forest models were built and optimised using optimal mtry values and ntree. Further optimisation can still be undertaken for better accuracy in predicting sales based on weather.
- The Linear Regression models also need refinement to fully capture the effect of weather variables on product-level sales.

## How to Use

1. **Random Forest Models**: 
   - Load the `Weather_Sales_2021_24.csv` dataset into R or Python environment.
   - Build and optimise the Random Forest model to predict daily sales based on weather features.

2. **Linear Regression**:
   - Use the `Product_Sales_Transposed.csv` file to conduct regression analysis to explore how weather influences the sales of individual product categories.

## Future Work

- Model improvements are required for both Random Forest and Linear Regression models to make them more robust and predictive.
- Feature engineering and hyperparameter tuning should be applied to the Random Forest models to achieve higher predictive power.
