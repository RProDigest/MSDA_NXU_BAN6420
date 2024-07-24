################################################################################
#  Name: Mubanga Nsofu                                                         #
#  Date: 23rd July 2024                                                        #
# Institution: Nexford University                                              #
# Date 23rd July 2024                                                          #
# Module: BAN 6420 Module 3                                                    #
# Lecturer: Prof. R. Wanjiku                                                   #
#Project: OOP Implementation of Insurance Management Policy System in R        #
###############################################################################


#' 1.0 SYNOPSIS
#' 
#' This R script implements an object-oriented system to manage policyholders,
#'  products, and payments using the R6 package. 
#'  The script demonstrates key OOP principles such as inheritance, encapsulation, 
#'  and polymorphism. Additionally, it integrates # Python's `faker` library via 
#'  the `reticulate` package to generate synthetic data for testing and 
#'  demonstration purposes.
#'  
#' Key components of the system include:
#' 
#' - BaseEntity Class: A base class providing common attributes and methods for 
#' derived classes.
#' - Product Class: Inherits from BaseEntity, representing an insurance product
#'  with attributes such as price.
#' - Policyholder Class: Inherits from BaseEntity, representing an individual 
#'  policyholder with attributes like phone number, email, age, sex, and 
#'  registered products.
#' - Payment Class: Inherits from BaseEntity, representing a payment made by 
#'   a policyholder for a specific product, including payment amount, due date, 
#'   and status.
#' 
#' The script includes utility functions for printing entity details and a 
#' main function to demonstrate the functionalities by creating products, 
#' generating fake policyholders,registering products, processing payments, and 
#' handling penalties. 
#' 
#' Error handling is implemented using `tryCatch()` to ensure robustness.
#'This project adheres to best practices in OOP design, error handling, and 
#'code readability, making it a scalable and maintainable solution for 
#'managing insurance-related entities and transactions.




# 2.0 INSTALL & LOAD PACKAGES ---------------------------------------


if (!require(pacman)) {
  install.packages("pacman")
}

pacman::p_load(
  R6,        # R6 package for OOP in R
  reticulate # Reticulate package to use Python libraries in R
)

# Ensure Faker is installed, if not run the next line without the #
#py_install("faker")




#' 3.0 We define a BaseEntity class -------------------------------
#' Note this class serves as a base for other classes, providing basic 
#' attributes and methods.


BaseEntity <- R6Class("BaseEntity",
                      public = list(
                        entity_id = NULL,   # Unique identifier for the entity
                        name = NULL,        # Name of the entity
                        active = TRUE,      # Status of the entity (active or suspended)
                        
                        # Initialize method to set up a new entity
                        initialize = function(entity_id, name) {
                          self$entity_id <- entity_id
                          self$name <- name
                          self$active <- TRUE
                          message(paste(class(self)[1], self$name, "(ID:", self$entity_id, ") has been created and is currently active."))
                        },
                        
                        # Method to suspend the entity
                        suspend = function() {
                          if (!self$active) {
                            stop(paste(class(self)[1], "is already suspended."))
                          }
                          self$active <- FALSE
                          message(paste(class(self)[1], self$name, "(ID:", self$entity_id, ") has been suspended."))
                        },
                        
                        # Method to reactivate the entity
                        reactivate = function() {
                          if (self$active) {
                            stop(paste(class(self)[1], "is already active."))
                          }
                          self$active <- TRUE
                          message(paste(class(self)[1], self$name, "(ID:", self$entity_id, ") has been reactivated."))
                        },
                        
                        # Method to get the details of the entity
                        get_details = function() {
                          status <- ifelse(self$active, "Active", "Suspended")
                          details <- list(
                            ID = self$entity_id,
                            Name = self$name,
                            Status = status
                          )
                          return(details)
                        }
                      )
)

#' 4.0 We Define the Product class ---------------
#' This class represents a product and inherits from BaseEntity.

Product <- R6Class("Product",
                   inherit = BaseEntity,
                   public = list(
                     price = NULL,              # Price of the product
                     product_catalog = list(),  # Catalog of products
                     
                     # Initialize method to set up a new product
                     initialize = function(product_id, name, price) {
                       super$initialize(product_id, name)
                       self$price <- price
                       self$add_to_catalog()
                     },
                     
                     # Method to add product to catalog
                     add_to_catalog = function() {
                       Product$product_catalog[[as.character(self$entity_id)]] <- self
                     },
                     
                     # Method to get a product by its ID
                     get_product_by_id = function(product_id) {
                       return(Product$product_catalog[[as.character(product_id)]])
                     },
                     
                     # Method to update product details
                     update = function(name = NULL, price = NULL) {
                       if (!is.null(name)) {
                         self$name <- name
                         message(paste("Name of Product", self$entity_id, "has been updated to", name))
                       }
                       if (!is.null(price)) {
                         self$price <- price
                         message(paste("Price of Product", self$entity_id, "has been updated to", price))
                       }
                     },
                     
                     # Method to get the details of the product
                     get_details = function() {
                       details <- super$get_details()
                       details$Price <- self$price
                       return(details)
                     }
                   )
)

#' 5.0 Define Policyholder class------------------------
#' This class represents a policyholder and inherits from BaseEntity.
 

Policyholder <- R6Class("Policyholder",
                        inherit = BaseEntity,
                        public = list(
                          phone_number = NULL,   # Phone number of the policyholder
                          email = NULL,          # Email of the policyholder
                          age = NULL,            # Age of the policyholder
                          sex = NULL,            # Sex of the policyholder
                          products = list(),     # List of products registered to the policyholder
                          
                          # Initialize method to set up a new policyholder
                          initialize = function(policyholder_id, name, phone_number, email, age, sex) {
                            super$initialize(policyholder_id, name)
                            self$phone_number <- phone_number
                            self$email <- email
                            self$age <- age
                            self$sex <- sex
                            self$products <- list()
                          },
                          
                          # Method to register a product to the policyholder
                          register_product = function(product) {
                            if (any(sapply(self$products, function(p) identical(p$entity_id, product$entity_id)))) {
                              stop(paste("Product", product$name, "is already registered."))
                            }
                            self$products[[length(self$products) + 1]] <- product
                            message(paste("Product", product$name, "has been registered to policyholder", self$name))
                          },
                          
                          # Method to get the details of the policyholder
                          get_details = function() {
                            details <- super$get_details()
                            details$`Phone Number` <- self$phone_number
                            details$Email <- self$email
                            details$Sex <- self$sex
                            details$Age <- self$age
                            details$Products <- sapply(self$products, function(p) p$name)
                            return(details)
                          }
                        )
)

#' 6.0 Define Payment class----------------------
#' This class represents a payment and inherits from BaseEntity.


Payment <- R6Class("Payment",
                   inherit = BaseEntity,
                   public = list(
                     policyholder = NULL,   # Policyholder making the payment
                     product = NULL,        # Product for which the payment is made
                     amount = NULL,         # Amount of the payment
                     due_date = NULL,       # Due date of the payment
                     paid = FALSE,          # Status of the payment (paid or not)
                     
                     # Initialize method to set up a new payment
                     initialize = function(payment_id, policyholder, product, amount, due_date) {
                       super$initialize(payment_id, paste("Payment for", policyholder$name))
                       self$policyholder <- policyholder
                       self$product <- product
                       self$amount <- amount
                       self$due_date <- due_date
                       self$paid <- FALSE
                     },
                     
                     # Method to process the payment
                     process_payment = function() {
                       if (self$paid) {
                         stop("Payment has already been processed.")
                       }
                       self$paid <- TRUE
                       message(paste("Payment", self$entity_id, "for", self$policyholder$name, "has been processed."))
                     },
                     
                     # Method to send a payment reminder
                     send_reminder = function() {
                       if (self$paid) {
                         return("Payment already made")
                       }
                       return(paste("Reminder: Payment of", self$amount, "for", self$policyholder$name, "for product", self$product$name, "is due on", self$due_date))
                     },
                     
                     # Method to apply a penalty to the payment
                     apply_penalty = function(penalty_amount) {
                       if (self$paid) {
                         stop("Cannot apply penalty to a paid payment.")
                       }
                       self$amount <- self$amount + penalty_amount
                       message(paste("Penalty of", penalty_amount, "applied to payment", self$entity_id, ". New amount:", self$amount))
                     },
                     
                     # Method to get the details of the payment
                     get_details = function() {
                       details <- super$get_details()
                       details$Policyholder <- self$policyholder$name
                       details$Product <- self$product$name
                       details$Amount <- self$amount
                       details$`Due Date` <- self$due_date
                       details$Status <- ifelse(self$paid, "Paid", "Unpaid")
                       return(details)
                     }
                   )
)

#' 7.0 Here we generate fake policyholders using faker in Python------

generate_fake_policyholders <- function(count = 400, seed = 42) {
  faker <- import("faker")
  faker$Faker$seed(seed)  # Use the class method to set the seed
  fake <- faker$Faker()
  policyholders <- list()
  
  for (i in 1:count) {
    policyholder_id <- fake$unique$random_int(min = 1, max = 10000)
    name <- fake$name()
    phone_number <- fake$phone_number()
    email <- fake$email()
    age <- fake$random_int(min = 18, max = 80)
    sex <- fake$random_element(elements = c('M', 'F'))
    policyholder <- Policyholder$new(policyholder_id, name, phone_number, email, age, sex)
    policyholders[[length(policyholders) + 1]] <- policyholder
  }
  
  return(policyholders)
}

#' 8.0 We define the main function to demonstrate the functionality--------

main <- function() {
  tryCatch({
    # Let us create some products to illustrate
    
    product1 <- Product$new(product_id = 1,
                            name = "Health Insurance",
                            price = 500)
    product2 <- Product$new(product_id = 2,
                            name = "Life Insurance",
                            price = 700)
    product3 <- Product$new(product_id = 3,
                            name = "Travel Insurance",
                            price = 300)
    
    # Generate nine fake policyholders
    policyholders <- generate_fake_policyholders(9)
    
    # Register a product to each policyholder
    policyholders[[1]]$register_product(product1)
    policyholders[[2]]$register_product(product2)
    policyholders[[3]]$register_product(product3)
    
    # Demonstrate registering, suspending, and reactivating policyholders
    policyholders[[2]]$suspend()
    policyholders[[3]]$suspend()
    policyholders[[3]]$reactivate()
    
    # Create payments and demonstrate payment processing, reminders, and penalties
    payment1 <- Payment$new(
      payment_id = 1,
      policyholder = policyholders[[4]],
      product = product1,
      amount = 500,
      due_date = "2024-08-01"
    )
    payment2 <- Payment$new(
      payment_id = 2,
      policyholder = policyholders[[5]],
      product = product2,
      amount = 700,
      due_date = "2024-08-01"
    )
    
    payment1$process_payment()
    print(payment2$send_reminder())
    payment2$apply_penalty(50)
    payment2$process_payment()
    
    # Demonstrate product creation, updating, and suspension
    new_product <- Product$new(product_id = 4,
                               name = "Home Insurance",
                               price = 400)
    new_product$update(name = "Updated Home Insurance", price = 450)
    new_product$suspend()
    
    # Selectively print policyholder details
    print("\nPolicyholder details by category:")
    
    # Registration
    print("\nRegistered Policyholder:")
    print_entity_details(policyholders[[1]])
    
    # Suspension
    print("\nSuspended Policyholder:")
    print_entity_details(policyholders[[2]])
    
    # Reactivation
    print("\nReactivated Policyholder:")
    print_entity_details(policyholders[[3]])
    
    # Payment processing
    print("\nPolicyholder with Processed Payment:")
    print_entity_details(policyholders[[4]])
    
    # Payment reminder
    print("\nPolicyholder with Payment Reminder Sent and Penalty Applied:")
    print_entity_details(policyholders[[5]])
    
    # Product details
    print("\nProduct Details:")
    print_entity_details(new_product)
    
  }, error = function(e) {
    message(paste("An error occurred:", e$message))
  })
}

#' 9.0 This is a Utility function to print entity details
#' This function prints the details of an entity in a readable format.


print_entity_details <- function(entity) {
  details <- entity$get_details()
  for (name in names(details)) {
    cat(sprintf("%s: %s\n", name, details[[name]]))
  }
}

#' 10.0  Run the main function if in interactive mode---------------
if (interactive()) {
  main()
}
