
# Employee Details Download and Unzip Using R

This README provides detailed instructions and explanations for using the R function download_and_extract_zip , making it easy for users to understand and implement the functionality, and enjoy an automated approach in downloading and unzipping the file

This function provides functionality to:

- Downloading a Zipped file
- Creating a directory in the current R directory.
- Uncompressing the file.
- Deleting the Zipped file for memory management
- Exception handling


## Prerequisites

- R 4.4.0 or higher

## Installation 

No Installation required as the {utils} package comes with installation of base R


## Author Details and Links

- mnsofu@learner.nexford.org
- ![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/:RProDigest)


 
## Features

- Downloads a zipped file from my Github repository

- Attempts to Unzip the File

- Deletes the zipped file

- Handles errors and warnings gracefully


## Documentation


1. Run the R funtion in R studio or any IDE so that the function will be in the R environment.
This can be easily accomplished by placing the cursor on the function name and pressing the following:

```sh
[command + enter] for MAC OS
[ctrl + enter] for Windows/Linux
```

For clarity the function is shown below

```sh

download_and_extract_zip <- function(url, destfile, unzip_dir) {
  # Step 1: Download the ZIP file from the provided URL
  tryCatch({
    # Exception handling
    cat("Downloading the ZIP file from:", url, "\n") # Prints downloading zip file
    utils::download.file(url, destfile, mode = "wb", # Write binary mode, used for binary files like images
                  # PDFs, ZIP files, etc. This ensures that the file is written
                  #exactly as it is without any modification.
                  quiet = FALSE) # FALSE displays the progress bar and messages.
    cat("Download completed: ", destfile, "\n")
  }, error = function(e) {
    cat("Error downloading file:", e$message, "\n") # print error if it occurs
    return(FALSE)
  })
  
  # Step 2: Define the directory to unzip the contents
  if (!dir.exists(unzip_dir)) {
    cat("Creating directory for unzipping:", unzip_dir, "\n")
    dir.create(unzip_dir) # create this directory in working directory if it doesnt exist
  }
  
  # Step 3: Unzip the file
  # This block of code prints TRUE if the unzip operation is successful otherwise
  # it will print a warning if there is a warning and an error if there is an 
  # error
  
  unzip_success <- tryCatch({ # Exception handling incase unzip fails
    cat("Unzipping the file:", # Print message saying unzipping intoo unzip_dir
        destfile,
        "into directory:",
        unzip_dir,
        "\n")
   utils::unzip(destfile, exdir = unzip_dir)
    TRUE
  }, warning = function(w) {
    cat("Warning unzipping the file:", w$message, "\n")# Print warning 
    FALSE
  }, error = function(e) {
    cat("Error unzipping the file:", e$message, "\n")# Print error 
    FALSE
  })
  
  if (!unzip_success) {
    cat("Failed to unzip the file. Cleaning up...\n") # Print zip failed 
    file.remove(destfile)
    unlink(unzip_dir, recursive = TRUE)
    return(FALSE)
  }
  
  # Step 4: If unzip was successful removed ZIP file
  file.remove(destfile)
  cat("Unzipping completed. Files are in the directory:",
      unzip_dir,
      "\n")
  return(TRUE)
}

```

2. Run the example below to obtain the unzipped file

```sh
# Usage of the function with my GitHub URL

url <- "https://github.com/RProDigest/MSDA_NXU_BAN6420/blob/main/Week2/Employee%20Profile.zip?raw=TRUE"
destfile <- "Employee_Profile.zip"
unzip_dir <- "EmployeeFolder"

download_and_extract_zip(url, destfile, unzip_dir)
```

- Note in the url we have specified ?raw=TRUE
- Note (For Windows) R will use mode = "wb" by default when it detects from the end of the URL that certain file formats, including .zip, are being downloaded. However, the URL finishing with a query string instead of a file format means the check fails so you need to set the mode explicitly. 


3. You should see a new folder created Called Employeefolder. inside the folder there will be an employee_details.csv file

```sh


## Error Handling

The function include error handling to manage potential issues gracefully:

The code inside the main block (tryCatch({...})) tries to unzip the file specified by destfile into the directory specified by unzip_dir.
It prints a message indicating that the unzipping process is starting.
If successful, it returns TRUE.
Handle Warnings:

If a warning occurs during the unzipping process, the warning handler is triggered.
It prints a message indicating that a warning occurred, along with the warning message.
It returns FALSE to indicate that the unzipping process encountered an issue.
Handle Errors:

If an error occurs during the unzipping process, the error handler is triggered.
It prints a message indicating that an error occurred, along with the error message.
It returns FALSE to indicate that the unzipping process failed.

The above have been implemented using the tryCatch block functionality in R
## 🚀 About Me
I'm a data scientist with a backgrouund in Mobile Telecomunications  with a passion to share knowledge and solve problems


## Support

For support, email mnsofu@learner.nexford.org or RProDigest@Protonmail.com.


## License

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

This project is licensed under the MIT License. Feel free to use and modify the code as needed.