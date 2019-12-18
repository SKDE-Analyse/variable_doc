
# Read csv file
data <- read.table('scripts/npr.csv', header = TRUE,  sep = ';',  stringsAsFactors = FALSE)

# Loop over unique variables

for (variable in unique(data$NAME)) {
  only_value <- dplyr::filter(data, NAME == variable)
  
  # List of files containing this variable
  file_list <- ""
  for (i in seq_along(only_value$LIBNAME)) {
    file_list <- paste0(file_list, only_value$LIBNAME[i], ".", only_value$MEMNAME[i])
    if (i != length(only_value$LIBNAME)) {
      file_list <- paste0(file_list, ", ")
    }
  }
  
  var_format <- ""
  k <- 0
  for (i in unique(only_value$FORMAT)) {
    var_format <- paste0(var_format, i)
    k <- k + 1
    if (k != length(unique(only_value$FORMAT))) {
      var_format <- paste0(var_format, ", ")
    }
  }

  var_length <- ""
  k <- 0
  for (i in unique(only_value$LENGTH)) {
    var_length <- paste0(var_length, i)
    k <- k + 1
    if (k != length(unique(only_value$LENGTH))) {
      var_length <- paste0(var_length, ", ")
    }
  }

  var_label <- ""
  k <- 0
  for (i in unique(only_value$LABEL)) {
    var_label <- paste0(var_label, i)
    k <- k + 1
    if (k != length(unique(only_value$LABEL))) {
      var_label <- paste0(var_label, ", ")
    }
  }
  
  var_type <- ""
  k <- 0
  for (i in unique(only_value$TYPE)) {
    var_type <- paste0(var_type, i)
    k <- k + 1
    if (k != length(unique(only_value$TYPE))) {
      var_type <- paste0(var_type, ", ")
    }
  }
  
  text <- paste0("
# ", variable, " {-}

| | |
|----|----|
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
