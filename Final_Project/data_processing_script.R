#########################################################################################
# Name: Mubanga Nsofu
# Institution: Nexford University
# Final Project: R script for post processing data from MongoDB
# 20th August 2024
########################################################################################


# Install and Load necessary libraries

if (!require(pacman)) {
  install.packages("pacman")
} # Check if package manager is installed

pacman::p_load(
  R6, # Package for R6 classes
  mongolite, # MongoDB interface for R
  data.table, # Data manipulation package
  jsonlite, # JSON handling package
  tidyverse # Meta package for data science lifcycle
)

# This line of code helps us connect to the MongoDB database and collection
mongo_connection <- mongo(collection = "user_data", db = "survey_db", url = "mongodb://localhost:27017/")

# We can then retrieve  all the documents from the 'user_data' collection as a data frame
data_df <- mongo_connection$find("{}") # Retrieves all documents

# This is a nested list so we have to unnest it

data_df %>%
  unnest(c(age, gender, income, expenses)) -> data_df_tbl

# We then check if the data frame is empty
if (nrow(data_df_tbl) > 0) {
  # Here we then define the User class, using R6 OOP

  User <- R6::R6Class("User",
    public = list(
      first_name = NULL,
      last_name = NULL,
      age = NULL,
      gender = NULL,
      race = NULL,
      income = NULL,
      expenses = NULL,
      initialize = function(first_name, last_name, age, gender, race, income, expenses) {
        self$first_name <- first_name
        self$last_name <- last_name
        self$age <- age
        self$gender <- gender
        self$race <- race
        self$income <- income
        self$expenses <- expenses
      },
      to_csv = function(filename) {
        # We have to ensure all expense fields are present and default to NA if missing
        utilities <- ifelse(!is.null(self$expenses$utilities), self$expenses$utilities, NA)
        entertainment <- ifelse(!is.null(self$expenses$entertainment), self$expenses$entertainment, NA)
        school_fees <- ifelse(!is.null(self$expenses$school_fees), self$expenses$school_fees, NA)
        shopping <- ifelse(!is.null(self$expenses$shopping), self$expenses$shopping, NA)
        healthcare <- ifelse(!is.null(self$expenses$healthcare), self$expenses$healthcare, NA)

        # We then convert the object to a data frame row
        df <- data.frame(
          First_Name = self$first_name,
          Last_Name = self$last_name,
          Age = self$age,
          Gender = self$gender,
          Race = self$race,
          Income = self$income,
          Utilities = utilities,
          Entertainment = entertainment,
          School_Fees = school_fees,
          Shopping = shopping,
          Healthcare = healthcare,
          stringsAsFactors = FALSE
        )

        # Finally we write the row to a CSV file
        fwrite(df, file = filename, append = TRUE, col.names = !file.exists(filename))
      }
    )
  )

  # We specify the filename for the CSV file
  filename <- "user_data.csv"

  # We loop through the data and store it in a CSV
  for (i in seq_len(nrow(data_df_tbl))) {
    user_data <- data_df_tbl[i, ]

    # Here we print  the extracted values to check them
    print(user_data$utilities)
    print(user_data$entertainment)
    print(user_data$school_fees)
    print(user_data$shopping)
    print(user_data$healthcare)

    # Here we create an instance of the User class with the data
    user <- User$new(
      first_name = user_data$first_name,
      last_name = user_data$last_name,
      age = user_data$age,
      gender = user_data$gender,
      race = user_data$race,
      income = user_data$income,
      expenses = list(
        utilities = user_data$utilities,
        entertainment = user_data$entertainment,
        school_fees = user_data$school_fees,
        shopping = user_data$shopping,
        healthcare = user_data$healthcare
      )
    )
    user$to_csv(filename)
  }

  print("Our data has been successfully written to the CSV file.")
} else {
  print("No data found in the MongoDB collection.")
}
