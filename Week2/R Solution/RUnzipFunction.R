################################################################################
# Name: Mubanga Nsofu                                                          #
# Institution: Nexford University (NXU)                                        #
# Date : 15th July 2024                                                        #
# Course: BAN 6420                                                             #
# Program: Master of Science Data Analytics (MSDA)                             #
# Lecturer: Professor Raphael Wanjiku                                          #
# Assignment : 2                                                               #
################################################################################

# STEP 1 --------------
# Understand the Requirements
#' a.) Download the Zipped file from Github created earlier on by the 
#' Jupyter notebook and 
#' b.) Unzip the file using R in the current working directory


# STEP 2 ---------------
# Code the Solution using methods from the {utils} package that comes 
# with base R. This package has zip and download utilities


# STEP 3 --------------
# Implement the steps above using a function for easier code maintenance instead 
# of a script


#Function Description

################################################################################
#' Download and Extract ZIP File
#'
#' This function downloads a ZIP file from a specified URL, extracts its contents
#' into a specified directory, and cleans up the downloaded ZIP file.
#'
#' @param url The URL of the ZIP file to download.
#' @param destfile The destination file path for the downloaded ZIP file.
#' @param unzip_dir The directory where the contents of the ZIP file will be extracted.
#'
#' @return TRUE if the extraction is successful, FALSE otherwise.
#'
#' @example
#' url <- "https://github.com/RProDigest/MSDA_NXU_BAN6420/blob/main/Week2/Employee%20Profile.zip?raw=TRUE"
#' destfile <- "Employee_Profile.zip"
#' unzip_dir <- "repository"
#' download_and_extract_zip(url, destfile, unzip_dir)
################################################################################


# Define the function below
 

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

# Usage of the function with your GitHub URL
url <- "https://github.com/RProDigest/MSDA_NXU_BAN6420/blob/main/Week2/Employee%20Profile.zip?raw=TRUE"
destfile <- "Employee_Profile.zip"
unzip_dir <- "EmployeeFolder"

download_and_extract_zip(url, destfile, unzip_dir)




