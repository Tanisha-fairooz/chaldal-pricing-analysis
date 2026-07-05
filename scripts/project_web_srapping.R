library(rvest)

#FRUITS

# URL of the Chaldal Fresh Fruit page
url <- "https://chaldal.com/fresh-fruit"

# Read HTML content of the webpage
webpage <- read_html(url)

# Select product containers
product_nodes <- webpage %>% html_nodes(".product")

# Scrape product names
product_names1 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

# Scrape sub texts (brand / quantity)
sub_texts1 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

# Scrape discounted prices
discounted_prices1 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    node_discount %>% html_text(trim = TRUE)
  } else {
    "NA"
  }
})

# Scrape original prices
original_prices1 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    node_price %>% html_text(trim = TRUE)
  } else {
    "NA"
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names:", length(product_names1), "\n",
    "Sub Texts:", length(sub_texts1), "\n",
    "Discounted Prices:", length(discounted_prices1), "\n",
    "Original Prices:", length(original_prices1), "\n")

# Pad vectors to same length
max_length <- max(
  length(product_names1),
  length(sub_texts1),
  length(discounted_prices1),
  length(original_prices1)
)

length(product_names1) <- max_length
length(sub_texts1) <- max_length
length(discounted_prices1) <- max_length
length(original_prices1) <- max_length

# Replace NA values
product_names1[is.na(product_names1)] <- "NA"
sub_texts1[is.na(sub_texts1)] <- "NA"
discounted_prices1[is.na(discounted_prices1)] <- "NA"
original_prices1[is.na(original_prices1)] <- "NA"

# Create final data frame with Category column
offers_data1 <- data.frame(
  Category = "Fruits",
  ProductName = product_names1,
  SubText = sub_texts1,
  DiscountedPrice = discounted_prices1,
  OriginalPrice = original_prices1,
  stringsAsFactors = FALSE
)

# Preview data
print(head(offers_data1))

# Save to CSV
write.csv(offers_data1, "OFFER1.csv", row.names = FALSE)

#EGGS

# URL of the Chaldal Egg page
url <- "https://chaldal.com/eggs"

# Read HTML content of the webpage
webpage <- read_html(url)

# Select product containers
product_nodes <- webpage %>% html_nodes(".product")

# Scrape product names
product_names2 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

# Scrape sub texts (brand / quantity)
sub_texts2 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

# Scrape discounted prices
discounted_prices2 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    node_discount %>% html_text(trim = TRUE)
  } else {
    "NA"
  }
})

# Scrape original prices
original_prices2 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    node_price %>% html_text(trim = TRUE)
  } else {
    "NA"
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names:", length(product_names2), "\n",
    "Sub Texts:", length(sub_texts2), "\n",
    "Discounted Prices:", length(discounted_prices2), "\n",
    "Original Prices:", length(original_prices2), "\n")

# Pad vectors to same length
max_length <- max(
  length(product_names2),
  length(sub_texts2),
  length(discounted_prices2),
  length(original_prices2)
)

length(product_names2) <- max_length
length(sub_texts2) <- max_length
length(discounted_prices2) <- max_length
length(original_prices2) <- max_length

# Replace NA values
product_names2[is.na(product_names2)] <- "NA"
sub_texts2[is.na(sub_texts2)] <- "NA"
discounted_prices2[is.na(discounted_prices2)] <- "NA"
original_prices2[is.na(original_prices2)] <- "NA"

# Create final data frame with Category column
offers_data12 <- data.frame(
  Category = "Eggs",
  ProductName = product_names2,
  SubText = sub_texts2,
  DiscountedPrice = discounted_prices2,
  OriginalPrice = original_prices2,
  stringsAsFactors = FALSE
)

# Preview data
print(head(offers_data12))

# Save to CSV
write.csv(offers_data2, "OFFER2.csv", row.names = FALSE)

#VEGETABLES

# URL of the Chaldal Vegetable page
url <- "https://chaldal.com/fresh-vegetable"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names3 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts3 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices3 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices3 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names3), "\n",
    "Sub Texts: ", length(sub_texts3), "\n",
    "Discounted Prices: ", length(discounted_prices3), "\n",
    "Original Prices: ", length(original_prices3), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names3), length(sub_texts3), length(discounted_prices3), length(original_prices3))

length(product_names3) <- max_length
length(sub_texts3) <- max_length
length(discounted_prices3) <- max_length
length(original_prices3) <- max_length

# Replace missing values with "NA"
product_names3[is.na(product_names3)] <- "NA"
sub_texts3[is.na(sub_texts3)] <- "NA"
discounted_prices3[is.na(discounted_prices3)] <- "NA"
original_prices3[is.na(original_prices3)] <- "NA"

# Combine all data into a structured data frame
offers_data3 <- data.frame(
  Category = "Vegetables",
  ProductName = product_names3,
  SubText = sub_texts3,
  DiscountedPrice = discounted_prices3,
  OriginalPrice = original_prices3,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data3))

# Save the cleaned data into a CSV file
write.csv(offers_data3, "OFFER3.csv", row.names = FALSE)

#SPICES

# URL of the Chaldal Spices page
url <- "https://chaldal.com/spices"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names4 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts4 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices4 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices4 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names4), "\n",
    "Sub Texts: ", length(sub_texts4), "\n",
    "Discounted Prices: ", length(discounted_prices4), "\n",
    "Original Prices: ", length(original_prices4), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names4), length(sub_texts4), length(discounted_prices4), length(original_prices4))

length(product_names4) <- max_length
length(sub_texts4) <- max_length
length(discounted_prices4) <- max_length
length(original_prices4) <- max_length

# Replace missing values with "NA"
product_names4[is.na(product_names4)] <- "NA"
sub_texts4[is.na(sub_texts4)] <- "NA"
discounted_prices4[is.na(discounted_prices4)] <- "NA"
original_prices4[is.na(original_prices4)] <- "NA"

# Combine all data into a structured data frame
offers_data4 <- data.frame(
  Category = "Spices",
  ProductName = product_names4,
  SubText = sub_texts4,
  DiscountedPrice = discounted_prices4,
  OriginalPrice = original_prices4,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data4))

# Save the cleaned data into a CSV file
write.csv(offers_data4, "OFFER4.csv", row.names = FALSE)

#RICE

# URL of the Chaldal Rice page
url <- "https://chaldal.com/rices"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names5 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts5 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices5 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices5 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names5), "\n",
    "Sub Texts: ", length(sub_texts5), "\n",
    "Discounted Prices: ", length(discounted_prices5), "\n",
    "Original Prices: ", length(original_prices5), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names5), length(sub_texts5), length(discounted_prices5), length(original_prices5))

length(product_names5) <- max_length
length(sub_texts5) <- max_length
length(discounted_prices5) <- max_length
length(original_prices5) <- max_length

# Replace missing values with "NA"
product_names5[is.na(product_names5)] <- "NA"
sub_texts5[is.na(sub_texts5)] <- "NA"
discounted_prices5[is.na(discounted_prices5)] <- "NA"
original_prices5[is.na(original_prices5)] <- "NA"

# Combine all data into a structured data frame
offers_data5 <- data.frame(
  Category = "Rices",
  ProductName = product_names5,
  SubText = sub_texts5,
  DiscountedPrice = discounted_prices5,
  OriginalPrice = original_prices5,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data5))

# Save the cleaned data into a CSV file
write.csv(offers_data5, "OFFER5.csv", row.names = FALSE)

#LENTIL

# URL of the Chaldal Lentil page
url <- "https://chaldal.com/dal-or-lentil"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names6 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts6 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices6 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices6 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names6), "\n",
    "Sub Texts: ", length(sub_texts6), "\n",
    "Discounted Prices: ", length(discounted_prices6), "\n",
    "Original Prices: ", length(original_prices6), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names6), length(sub_texts6), length(discounted_prices6), length(original_prices6))

length(product_names6) <- max_length
length(sub_texts6) <- max_length
length(discounted_prices6) <- max_length
length(original_prices6) <- max_length

# Replace missing values with "NA"
product_names6[is.na(product_names6)] <- "NA"
sub_texts6[is.na(sub_texts6)] <- "NA"
discounted_prices6[is.na(discounted_prices6)] <- "NA"
original_prices6[is.na(original_prices6)] <- "NA"

# Combine all data into a structured data frame
offers_data6 <- data.frame(
  Category = "Lentil",
  ProductName = product_names6,
  SubText = sub_texts6,
  DiscountedPrice = discounted_prices6,
  OriginalPrice = original_prices6,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data6))

# Save the cleaned data into a CSV file
write.csv(offers_data6, "OFFER6.csv", row.names = FALSE)

#CHICKEN POULTRY

# URL of the Chaldal chicken-poultry page
url <- "https://chaldal.com/chicken-poultry"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names7 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts7 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices7 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices7 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names7), "\n",
    "Sub Texts: ", length(sub_texts7), "\n",
    "Discounted Prices: ", length(discounted_prices7), "\n",
    "Original Prices: ", length(original_prices7), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names7), length(sub_texts7), length(discounted_prices7), length(original_prices7))

length(product_names7) <- max_length
length(sub_texts7) <- max_length
length(discounted_prices7) <- max_length
length(original_prices7) <- max_length

# Replace missing values with "NA"
product_names7[is.na(product_names7)] <- "NA"
sub_texts7[is.na(sub_texts7)] <- "NA"
discounted_prices7[is.na(discounted_prices7)] <- "NA"
original_prices7[is.na(original_prices7)] <- "NA"

# Combine all data into a structured data frame
offers_data7 <- data.frame(
  Category = "Chicken Poultry",
  ProductName = product_names7,
  SubText = sub_texts7,
  DiscountedPrice = discounted_prices7,
  OriginalPrice = original_prices7,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data7))

# Save the cleaned data into a CSV file
write.csv(offers_data7, "OFFER7.csv", row.names = FALSE)

#FROZEN FISH

# URL of the Chaldal frozen-fish page
url <- "https://chaldal.com/frozen-fish"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names8 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts8 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices8 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices8 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names8), "\n",
    "Sub Texts: ", length(sub_texts8), "\n",
    "Discounted Prices: ", length(discounted_prices8), "\n",
    "Original Prices: ", length(original_prices8), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names8), length(sub_texts8), length(discounted_prices8), length(original_prices8))

length(product_names8) <- max_length
length(sub_texts8) <- max_length
length(discounted_prices8) <- max_length
length(original_prices8) <- max_length

# Replace missing values with "NA"
product_names8[is.na(product_names8)] <- "NA"
sub_texts8[is.na(sub_texts8)] <- "NA"
discounted_prices8[is.na(discounted_prices8)] <- "NA"
original_prices8[is.na(original_prices8)] <- "NA"

# Combine all data into a structured data frame
offers_data8 <- data.frame(
  Category = "Frozen Fish",
  ProductName = product_names8,
  SubText = sub_texts8,
  DiscountedPrice = discounted_prices8,
  OriginalPrice = original_prices8,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data8))

# Save the cleaned data into a CSV file
write.csv(offers_data8, "OFFER8.csv", row.names = FALSE)

#MEAT 

# URL of the Chaldal Meat page
url <- "https://chaldal.com/meat-new"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names9 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts9 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices9 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices9 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names9), "\n",
    "Sub Texts: ", length(sub_texts9), "\n",
    "Discounted Prices: ", length(discounted_prices9), "\n",
    "Original Prices: ", length(original_prices9), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names9), length(sub_texts9), length(discounted_prices9), length(original_prices9))

length(product_names9) <- max_length
length(sub_texts9) <- max_length
length(discounted_prices9) <- max_length
length(original_prices9) <- max_length

# Replace missing values with "NA"
product_names9[is.na(product_names9)] <- "NA"
sub_texts9[is.na(sub_texts9)] <- "NA"
discounted_prices9[is.na(discounted_prices9)] <- "NA"
original_prices9[is.na(original_prices9)] <- "NA"

# Combine all data into a structured data frame
offers_data9 <- data.frame(
  Category = "Meat",
  ProductName = product_names9,
  SubText = sub_texts9,
  DiscountedPrice = discounted_prices9,
  OriginalPrice = original_prices9,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data9))

# Save the cleaned data into a CSV file
write.csv(offers_data9, "OFFER9.csv", row.names = FALSE)

#PICKELS

# URL of the Chaldal pickels page
url <- "https://chaldal.com/pickles"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names10 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts10 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices10 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices10 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names10), "\n",
    "Sub Texts: ", length(sub_texts10), "\n",
    "Discounted Prices: ", length(discounted_prices10), "\n",
    "Original Prices: ", length(original_prices10), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names10), length(sub_texts10), length(discounted_prices10), length(original_prices10))

length(product_names10) <- max_length
length(sub_texts10) <- max_length
length(discounted_prices10) <- max_length
length(original_prices10) <- max_length

# Replace missing values with "NA"
product_names10[is.na(product_names10)] <- "NA"
sub_texts10[is.na(sub_texts10)] <- "NA"
discounted_prices10[is.na(discounted_prices10)] <- "NA"
original_prices10[is.na(original_prices10)] <- "NA"

# Combine all data into a structured data frame
offers_data10 <- data.frame(
  Category = "Pickles",
  ProductName = product_names10,
  SubText = sub_texts10,
  DiscountedPrice = discounted_prices10,
  OriginalPrice = original_prices10,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data10))

# Save the cleaned data into a CSV file
write.csv(offers_data10, "OFFER10.csv", row.names = FALSE)

#TEA

# URL of the Chaldal tea page
url <- "https://chaldal.com/beverages-tea"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names11 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts11 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices11 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices11 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names11), "\n",
    "Sub Texts: ", length(sub_texts11), "\n",
    "Discounted Prices: ", length(discounted_prices11), "\n",
    "Original Prices: ", length(original_prices11), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names11), length(sub_texts11), length(discounted_prices11), length(original_prices11))

length(product_names11) <- max_length
length(sub_texts11) <- max_length
length(discounted_prices11) <- max_length
length(original_prices11) <- max_length

# Replace missing values with "NA"
product_names11[is.na(product_names11)] <- "NA"
sub_texts11[is.na(sub_texts11)] <- "NA"
discounted_prices11[is.na(discounted_prices11)] <- "NA"
original_prices11[is.na(original_prices11)] <- "NA"

# Combine all data into a structured data frame
offers_data11 <- data.frame(
  Category = "Tea",
  ProductName = product_names11,
  SubText = sub_texts11,
  DiscountedPrice = discounted_prices11,
  OriginalPrice = original_prices11,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data11))

# Save the cleaned data into a CSV file
write.csv(offers_data11, "OFFER11.csv", row.names = FALSE)

#SOFT DRNINKS 

# URL of the Chaldal Soft drinks page
url <- "https://chaldal.com/soft-drinks"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names12 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts12 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices12 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices12 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names12), "\n",
    "Sub Texts: ", length(sub_texts12), "\n",
    "Discounted Prices: ", length(discounted_prices12), "\n",
    "Original Prices: ", length(original_prices12), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names12), length(sub_texts12), length(discounted_prices12), length(original_prices12))

length(product_names12) <- max_length
length(sub_texts12) <- max_length
length(discounted_prices12) <- max_length
length(original_prices12) <- max_length

# Replace missing values with "NA"
product_names12[is.na(product_names12)] <- "NA"
sub_texts12[is.na(sub_texts12)] <- "NA"
discounted_prices12[is.na(discounted_prices12)] <- "NA"
original_prices12[is.na(original_prices12)] <- "NA"

# Combine all data into a structured data frame
offers_data12 <- data.frame(
  Category = "Soft Drinks",
  ProductName = product_names12,
  SubText = sub_texts12,
  DiscountedPrice = discounted_prices12,
  OriginalPrice = original_prices12,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data12))

# Save the cleaned data into a CSV file
write.csv(offers_data12, "OFFER12.csv", row.names = FALSE)

#NUTS & DRIED FRUITS

# URL of the Chaldal Nuts and dried fruits page
url <- "https://chaldal.com/nuts-dried-fruits"

# Read HTML content of the webpage
webpage <- read_html(url)

# Use the 'product' container to ensure consistent scraping within each product grouping
product_nodes <- webpage %>% html_nodes(".product")

# Scrape individual fields
product_names13 <- product_nodes %>%
  html_nodes(".name") %>%
  html_text(trim = TRUE)

sub_texts13 <- product_nodes %>%
  html_nodes(".subText") %>%
  html_text(trim = TRUE)

discounted_prices13 <- sapply(product_nodes, function(node) {
  node_discount <- node %>% html_nodes(".discountedPrice")
  if (length(node_discount) > 0) {
    return(node_discount %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

original_prices13 <- sapply(product_nodes, function(node) {
  node_price <- node %>% html_nodes(".price")
  if (length(node_price) > 0) {
    return(node_price %>% html_text(trim = TRUE))
  } else {
    return("NA")
  }
})

# Check lengths
cat("Lengths:\n",
    "Product Names: ", length(product_names13), "\n",
    "Sub Texts: ", length(sub_texts13), "\n",
    "Discounted Prices: ", length(discounted_prices13), "\n",
    "Original Prices: ", length(original_prices13), "\n")

# Pad vectors to the same length
max_length <- max(length(product_names13), length(sub_texts13), length(discounted_prices13), length(original_prices13))

length(product_names13) <- max_length
length(sub_texts13) <- max_length
length(discounted_prices13) <- max_length
length(original_prices13) <- max_length

# Replace missing values with "NA"
product_names13[is.na(product_names13)] <- "NA"
sub_texts13[is.na(sub_texts13)] <- "NA"
discounted_prices13[is.na(discounted_prices13)] <- "NA"
original_prices13[is.na(original_prices13)] <- "NA"

# Combine all data into a structured data frame
offers_data13 <- data.frame(
  Category = "Nuts and Dried fruits",
  ProductName = product_names13,
  SubText = sub_texts13,
  DiscountedPrice = discounted_prices13,
  OriginalPrice = original_prices13,
  stringsAsFactors = FALSE
)

# Preview the structured data
print(head(offers_data13))

# Save the cleaned data into a CSV file
write.csv(offers_data13, "OFFER13.csv", row.names = FALSE)