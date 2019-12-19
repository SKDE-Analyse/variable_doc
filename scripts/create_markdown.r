
# Read csv file
data <- read.table('scripts/npr.csv', header = TRUE,  sep = ';',  stringsAsFactors = FALSE)


data$dataset <- paste(data$LIBNAME, data$MEMNAME, sep = ".")
data$var_lowercase <- iconv(tolower(data$NAME), from = 'UTF-8', to = 'ASCII//TRANSLIT')

# Loop over unique variables
for (variable in unique(data$var_lowercase)) {
  only_value <- dplyr::filter(data, var_lowercase == variable)

  # List of variable names (different case)
  var_values <- paste(unique(only_value$NAME), collapse = ", ")

  # List of files containing this variable
  file_list <- paste(unique(only_value$dataset), collapse = ", ")

  var_format <- paste(unique(only_value$FORMAT), collapse = ", ")

  var_length <- paste(unique(only_value$LENGTH), collapse = ", ")

  var_label <- paste(unique(only_value$LABEL), collapse = ", ")

  var_type <- paste(unique(only_value$TYPE), collapse = ", ")

  text <- paste0("
# ", unique(only_value$NAME)[1], " {-}

| | |
|----|----|
| Navn     | ", var_values, " |
| Label    | ", var_label, " |
| Type     | ", var_type, " |
| Length   | ", var_length, "    |
| Format   | ", var_format, " |
| Kilde    |   |

**Finnes i filene**

", file_list, "
")

  filename <- paste0("npr/", iconv(variable, from = 'UTF-8', to = 'ASCII//TRANSLIT'), ".Rmd")
  if (!file.exists(filename)) {
    file_var <- file(filename)
  } else {
    filename <- paste0("npr/", iconv(variable, from = 'UTF-8', to = 'ASCII//TRANSLIT'), ".Rmd")
    file_var <- file(filename)
  }
  writeLines(text, file_var)
  close(file_var)
  
}
