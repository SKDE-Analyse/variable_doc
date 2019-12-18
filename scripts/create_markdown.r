
# Read csv file
data <- read.table('scripts/npr.csv', header = TRUE,  sep = ';',  stringsAsFactors = FALSE)

# Loop over unique variables

for (variable in unique(data$NAME)) {
  print(variable)
  only_value <- dplyr::filter(data, NAME == variable)
  print(only_value)
}
