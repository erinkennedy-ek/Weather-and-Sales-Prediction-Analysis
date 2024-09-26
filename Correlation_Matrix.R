#(learn_with_R) (Brett Lantz)
-------------------------------------------#introduction

library(dplyr)
library(ggplot2)
library(tidyr)
product_data <- read_excel("~/EK_Predictions_RStudio/Data_Files/Product_Sales_Transposed.xlsx")

str(product_data)
product_data <- na.omit(product_data)
product_data <- product_data %>% filter(Beverage != 0)
names(product_data)
dim(product_data) #1109 23
#View(product_data)

# ----------------------------------Visualising Summary Stats
summary(product_data)
product_long <- product_data %>%
  pivot_longer(cols = Beverage:Portions, names_to = "Category", values_to = "Value")

summary_stats <- product_long %>%
  group_by(Category) %>%
  summarize(
    Mean = mean(Value, na.rm = TRUE),
    Median = median(Value, na.rm = TRUE),
    SD = sd(Value, na.rm = TRUE)
  )

summary_long <- summary_stats %>%
  pivot_longer(cols = c(Mean, Median, SD), names_to = "Statistic", values_to = "Value")

ggplot(summary_long, aes(x = Category, y = Value, fill = Statistic)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Summary Statistics for Product Categories",
       x = "Product Category",
       y = "Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
#-------------------------------------------------------------------------time series graph
product_data$date <- as.Date(product_data$date, format = "%Y-%m-%d")

monthly_data <- product_data %>%
  mutate(YearMonth = floor_date(Date, "month")) %>%
  group_by(YearMonth) %>%
  summarise(across(Beverage:Portions, sum, na.rm = TRUE), .groups = "drop")

long_data <- monthly_data %>%
  pivot_longer(cols = Beverage:Portions, names_to = "Category", values_to = "Sales")

ggplot(long_data, aes(x = YearMonth, y = Sales, color = Category)) +
  geom_line() +
  labs(title = "Monthly Sales Trends",
       x = "Month",
       y = "Sales",
       color = "Product Category") +
  theme_minimal() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
#--------------------------------------------------------------2023-2024 Monthly Graph
library(lubridate)

product_data$date <- as.Date(product_data$date, format = "%Y-%m-%d")
filtered_data <- product_data %>%
  filter(date >= as.Date("2023-01-01"))

monthly_data <- filtered_data %>%
  mutate(YearMonth = floor_date(Date, "month")) %>%
  group_by(YearMonth) %>%
  summarise(across(Beverage:Portions, sum, na.rm = TRUE), .groups = "drop")

long_data <- monthly_data %>%
  pivot_longer(cols = Beverage:Portions, names_to = "Category", values_to = "Sales")

ggplot(long_data, aes(x = YearMonth, y = Sales, color = Category)) +
  geom_line() +
  labs(title = "Monthly Sales Trends (2023 - May 2024)",
       x = "Date",
       y = "Sales",
       color = "Product Category") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#----------------------------------------------------------correlation matrix
library(corrplot)
colnames(product_data)

product_data_numeric <- product_data %>%
  select(where(is.numeric))

#product_data_numeric <- na.omit(numeric_data)

cor_matrix <- cor(product_data_numeric, use = "complete.obs")
cor_matrix<- round(cor_matrix,2)
cor_matrix

#------------------------------------------------------------------- circle heatmap
#corrplot(cor_matrix, method = "circle")
#-------------------------------------------------------------------- square heatmap

library(ggplot2)
library(tidyr)

cor_matrix <- cor(product_data_numeric) 
cor_matrix_df <- as.data.frame(as.table(cor_matrix))

ggplot(data = cor_matrix_df, aes(x = Var1, y = Var2, fill = Freq)) +
  geom_tile(color = "white") + 
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), space = "Lab", 
                       name = "Correlation") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1),
        axis.text.y = element_text(size = 12)) +
  coord_fixed() +
  labs(x = "", y = "")



#-------------------------------------------------------------------scatterplot matrix

pairs(product_data_numeric[c("Beverage", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Burger", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Chicken", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Combo_Meal", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Fish", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Fries", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Ice_Cream", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Kids_Meal", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Milkshake", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Other", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Pizza", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
pairs(product_data_numeric[c("Portions", "sun", "wdsp", "rain", "evap", "rh", "maxtp","mintp","avgtp")])
