library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)  

data <- read.csv("MergedData.csv", stringsAsFactors = FALSE)
head(data)


# Remove leading/trailing whitespace
data$OriginalPrice <- trimws(data$OriginalPrice)
data$DiscountedPrice <- trimws(data$DiscountedPrice)

# Convert price values to numeric
data$OriginalPrice <- parse_number(data$OriginalPrice)
data$DiscountedPrice <- parse_number(data$DiscountedPrice)

# Remove rows with NA OriginalPrice
data <- data[!is.na(data$OriginalPrice), ]

# Replace missing SubText with "Unknown"
data$SubText[data$SubText == ""] <- "Unknown"


# Add Discount Flag
# 1 = discount available, 0 = no discount
data$DiscountFlag <- ifelse(is.na(data$DiscountedPrice), 0, 1)
head(data)

# Add Final Price

# Use discounted price if available, otherwise original price
data$FinalPrice <- ifelse(
  is.na(data$DiscountedPrice),
  data$OriginalPrice,
  data$DiscountedPrice
)
head(data)

# Only calculate if a discount is available
data$DiscountPercentage <- ifelse(
  data$DiscountFlag == 1,
  round(((data$OriginalPrice - data$DiscountedPrice) / data$OriginalPrice) * 100),
  NA
)

head(data,10)

# Descriptive Price Analysis


# Average Price per Category
avg_price <- data %>%
  group_by(Category) %>%
  summarise(
    AverageOriginalPrice = mean(OriginalPrice, na.rm = TRUE),
    AverageFinalPrice    = mean(FinalPrice, na.rm = TRUE)
  )

print("Average Price per Category:")
print(avg_price)

# Price Range (Min–Max) per Category
price_range <- data %>%
  group_by(Category) %>%
  summarise(
    MinOriginalPrice = min(OriginalPrice, na.rm = TRUE),
    MaxOriginalPrice = max(OriginalPrice, na.rm = TRUE),
    MinFinalPrice    = min(FinalPrice, na.rm = TRUE),
    MaxFinalPrice    = max(FinalPrice, na.rm = TRUE)
  )

print("Price Range per Category:")
print(price_range)

# Summary Statistics
print("Original Price Summary:")
print(summary(data$OriginalPrice))

print("Final Price Summary:")
print(summary(data$FinalPrice))


# Prepare data in long format
data_long <- data %>%
  select(Category, OriginalPrice, FinalPrice) %>%
  pivot_longer(cols = c(OriginalPrice, FinalPrice), 
               names_to = "PriceType", values_to = "Price")

# Get all unique categories
categories <- unique(data$Category)

# Loop through categories and create a boxplot for each
for(cat in categories){
  cat_data <- data_long %>% filter(Category == cat)
  
  p <- ggplot(cat_data, aes(x = PriceType, y = Price, fill = PriceType)) +
    geom_boxplot(width = 0.5) +
    labs(title = paste("Price Comparison for", cat),
         x = "",
         y = "Price (Taka)") +
    scale_fill_manual(values = c("OriginalPrice" = "lightblue", "FinalPrice" = "lightgreen")) +
    theme_minimal() +
    theme(legend.position = "none")
  
  print(p)
}

# Number of products per category

products_per_category <- data %>%
  group_by(Category) %>%
  summarise(ProductCount = n()) %>%
  arrange(desc(ProductCount))

print(products_per_category)

#Categories with number of unique product
category_variety <- data %>%
  group_by(Category) %>%
  summarise(UniqueProducts = n_distinct(ProductName)) %>%
  arrange(desc(UniqueProducts))

print(category_variety)

#Count of discounted products per category
discount_count <- data %>%
  filter(DiscountFlag == 1) %>%
  group_by(Category) %>%
  summarise(DiscountedProducts = n()) %>%
  arrange(desc(DiscountedProducts))

print(discount_count)

#Average discount percentage per category
avg_discount_percent <- data %>%
  filter(DiscountFlag == 1) %>%
  group_by(Category) %>%
  summarise(
    AverageDiscountPercent = mean(DiscountPercentage, na.rm = TRUE)
  ) %>%
  arrange(desc(AverageDiscountPercent))

print(avg_discount_percent)


#Discount frequency by category
discount_frequency <- data %>%
  group_by(Category) %>%
  summarise(
    TotalProducts = n(),
    DiscountedProducts = sum(DiscountFlag),
    DiscountFrequencyPercent = round((DiscountedProducts / TotalProducts) * 100, 2)
  ) %>%
  arrange(desc(DiscountFrequencyPercent))

print(discount_frequency)

#Percentage of products with vs without discounts (Overall distribution)

discount_distribution <- data %>%
  summarise(
    Discounted = sum(DiscountFlag == 1),
    NoDiscount = sum(DiscountFlag == 0)
  ) %>%
  pivot_longer(
    cols = everything(),
    names_to = "DiscountStatus",
    values_to = "Count"
  ) %>%
  mutate(Percentage = round((Count / sum(Count)) * 100, 2))

print(discount_distribution)

#Products with the highest discounts (Top discounted products)

highest_discounts <- data %>%
  filter(DiscountFlag == 1) %>%
  arrange(desc(DiscountPercentage)) %>%
  select(
    ProductName,
    Category,
    OriginalPrice,
    DiscountedPrice,
    DiscountPercentage
  )

head(highest_discounts, 10)

#Discount Percentage Distribution by Category

ggplot(data %>% filter(!is.na(DiscountPercentage)), aes(x = DiscountPercentage, fill = Category)) +
  
  geom_histogram(binwidth = 5, position = "dodge") +
  
  labs(title = "Discount Percentage Distribution by Category", x = "Discount Percentage (%)", y = "Count") +
  
  theme_minimal()

# Boxplot of Original vs Discounted Prices

library(ggplot2)

ggplot(data, aes(x = Category, y = OriginalPrice, fill = Category)) +
  
  geom_boxplot() +
  
  labs(title = "Original Prices by Category", x = "Category", y = "Price") +
  
  theme_minimal()

ggplot(data, aes(x = Category, y = DiscountPercentage, fill = Category)) +
  
  geom_boxplot() +
  
  labs(title = "Discount Percentages by Category", x = "Category", y = "Discount %") +
  
  theme_minimal()



#ANOVA TEST

anova_result <- aov(FinalPrice ~ Category, data = data)
summary(anova_result)


anova_discount <- aov(DiscountPercentage ~ Category,
                      data = data %>% filter(!is.na(DiscountPercentage)))
summary(anova_discount)

#CHI SQUARE

discount_table <- table(data$Category, data$DiscountFlag)
chi_result <- chisq.test(discount_table)
print(chi_result)

#MODELLING

library(dplyr)
library(caret)
library(randomForest)

rf_data <- data %>%
  filter(!is.na(DiscountPercentage)) %>%
  select(DiscountPercentage, Category, OriginalPrice)

rf_data$Category <- as.factor(rf_data$Category)

set.seed(123)

train_index <- createDataPartition(
  rf_data$DiscountPercentage,
  p = 0.7,
  list = FALSE
)

train_data <- rf_data[train_index, ]
test_data  <- rf_data[-train_index, ]

set.seed(123)

rf_model <- randomForest(
  DiscountPercentage ~ Category + OriginalPrice,
  data = train_data,
  ntree = 500,
  importance = TRUE
)

print(rf_model)

importance(rf_model)
varImpPlot(rf_model)
rf_pred <- predict(rf_model, test_data)
rf_rmse <- RMSE(rf_pred, test_data$DiscountPercentage)
rf_r2   <- R2(rf_pred, test_data$DiscountPercentage)

rf_rmse
rf_r2

plot(
  test_data$DiscountPercentage,
  rf_pred,
  xlab = "Actual Discount %",
  ylab = "Predicted Discount %",
  main = "Random Forest: Actual vs Predicted"
)
abline(0, 1, col = "red")

#modeling with flag
rf_data <- data %>%
  select(DiscountFlag, Category, OriginalPrice)

rf_data$Category <- as.factor(rf_data$Category)
rf_data$DiscountFlag <- as.factor(rf_data$DiscountFlag)
set.seed(123)

train_index <- createDataPartition(
  rf_data$DiscountFlag,
  p = 0.7,
  list = FALSE
)

train_data <- rf_data[train_index, ]
test_data  <- rf_data[-train_index, ]
set.seed(123)

rf_model <- randomForest(
  DiscountFlag ~ Category + OriginalPrice,
  data = train_data,
  ntree = 500,
  importance = TRUE
)

print(rf_model)

importance(rf_model)
varImpPlot(rf_model)

rf_pred <- predict(rf_model, test_data)
confusionMatrix(rf_pred, test_data$DiscountFlag)


# Confusion Matrix
cm <- confusionMatrix(rf_pred, test_data$DiscountFlag)
print(cm)

# Accuracy
accuracy <- cm$overall['Accuracy']
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))

# Plot Confusion Matrix using ggplot
cm_table <- as.data.frame(cm$table)
colnames(cm_table) <- c("Reference", "Prediction", "Freq")

ggplot(cm_table, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), vjust = 1) +
  scale_fill_gradient(low = "lightblue", high = "steelblue") +
  labs(title = "Confusion Matrix", x = "Actual", y = "Predicted") +
  theme_minimal()



# Boxplot of Original vs Discounted Prices
ggplot(data, aes(x = Category, y = OriginalPrice, fill = Category)) +  
  geom_boxplot() +  
  labs(title = "Original Prices by Category", x = "Category", y = "Price") +
  theme_minimal()

ggplot(data, aes(x = Category, y = DiscountPercentage, fill = Category)) + 
  geom_boxplot() +
  labs(title = "Discount Percentages by Category", x = "Category", y = "Discount %") +
  theme_minimal()
