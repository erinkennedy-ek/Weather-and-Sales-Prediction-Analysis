#====================================
library(tidyr)
library(ggplot2)


accuracydf <- data.frame(
  Model = c("All_Model", "Tuned_All_Model", "Climate_Model", "Tuned_Climate_Model"),
  MAE = c(624.1952, 536.8051, 616.5841, 531.048),
  RMSE = c(966.8824, 908.8939, 956.8538, 904.6512),
  R_Squared = c(83.96, 87.25, 84.52, 87.42)
)

accuracydf_long <- accuracydf |> 
  pivot_longer(cols = -Model, names_to = "Metric", values_to = "Value") |> 
  mutate(
    Metric = factor(Metric, levels = c("RMSE", "MAE", "R_Squared")),
    Scaled_Value = ifelse(Metric == "R_Squared", Value, Value / 10)
  )


ggplot(accuracydf_long, aes(x = Model, y = Scaled_Value, fill = Metric)) +
  geom_col(data = accuracydf_long |> filter(Metric %in% c("RMSE", "MAE")), 
           aes(fill = Metric), position = "dodge") +
  geom_line(data = accuracydf_long |> filter(Metric == "R_Squared"), 
            aes(group = 1, color = Metric), size = 1.2) +
  geom_point(data = accuracydf_long |> filter(Metric == "R_Squared"), 
             aes(colour = Metric), size = 3) +
  scale_y_continuous(
    name = "R-Squared (%)", 
    sec.axis = sec_axis(~ . * 10, name = "MAE / RMSE")
  ) +
  labs(title = "Customer Behaviour Model Performance Metrics", x = "Model") +
  theme_minimal() +
  scale_fill_manual(values = c("RMSE" = "red", "MAE" = "blue")) +
  scale_colour_manual(values = c("R_Squared" = "green")) +
  theme(legend.position = "top")

