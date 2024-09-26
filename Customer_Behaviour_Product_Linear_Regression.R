# linear regression
library(readxl)
library(dplyr)
library(car)

product_data <- read_excel("~/EK_Predictions_RStudio/Data_Files/Product_Sales_Transposed.xlsx", sheet = 1)
product_data <- product_data %>% filter(Beverage != 0)

#------------------------------------------------------------------------ Burger 
burgermodel <- lm(Burger ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(burgermodel)
vif(burgermodel)

#------------------------------------------------------------------------ Beverage
beveragemodel <- lm(Beverage ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(beveragemodel)
vif(beveragemodel)

#------------------------------------------------------------------------ Chicken 
chickenmodel <- lm(Chicken ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(chickenmodel)
vif(chickenmodel)

#------------------------------------------------------------------------ Combo_Meal 
combomodel <- lm(Combo_Meal ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(combomodel)
vif(combomodel)

#------------------------------------------------------------------------ Fish 
fishmodel <- lm(Fish ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(fishmodel)
vif(fishmodel)

#------------------------------------------------------------------------ Chips 
friesmodel <- lm(Fries ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(friesmodel)
vif(friesmodel)

#------------------------------------------------------------------------ Ice_Cream 
icecreammodel <- lm(Ice_Cream ~ sun + rain + evap + rh + maxtp + mintp + avgtp + wdsp, data = product_data)
summary(icecreammodel)
vif(icecreammodel)

#------------------------------------------------------------------------ Kids_Meal 
kidsmealmodel <- lm(Kids_Meal ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(kidsmealmodel)
vif(kidsmealmodel)
#------------------------------------------------------------------------ Milkshake 
milkshakemodel <- lm(Milkshake ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(milkshakemodel)
vif(milkshakemodel)

#------------------------------------------------------------------------ Other 
othermodel <- lm(Other ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(othermodel)
vif(othermodel)

#------------------------------------------------------------------------ Pizza 
pizzamodel <- lm(Pizza ~ sun + rain + evap + rh + avgtp + wdsp, data = product_data)
summary(pizzamodel)
vif(pizzamodel)

#------------------------------------------------------------------------ Portions 
portionsmodel <- lm(Portions ~ sun + rain + evap + rh +avgtp + wdsp, data = product_data)
summary(portionsmodel)
vif(portionsmodel)
