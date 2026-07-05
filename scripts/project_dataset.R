# List all your CSV files
csv_files <- c(
  "OFFER1.csv", "OFFER2.csv", "OFFER3.csv", "OFFER4.csv",
  "OFFER5.csv", "OFFER6.csv", "OFFER7.csv", "OFFER8.csv",
  "OFFER9.csv", "OFFER10.csv", "OFFER11.csv", "OFFER12.csv",
  "OFFER13.csv"
)

# Read all CSVs into a list of data frames
list_of_dfs <- lapply(csv_files, read.csv, stringsAsFactors = FALSE)

# Merge all CSVs into one data frame
Offers_data_all <- do.call(rbind, list_of_dfs)

# Save merged CSV
write.csv(Offers_data_all, "MergedData.csv", row.names = FALSE)


