
# OOP Insurance Policy Management System 




This R script implements an object-oriented system  to manage policyholders, products, and payments using the R6 package. It also uses the `reticulate` package to integrate Python's `faker` library for generating fake data.
 

## Project Structure:

``` plaintext
policy_management_system/
│── insuranceManagementSystem.R
├── README.md

```

## Running the script

1. Ensure you have the required packages installed by running the following command below checks if package mamanger(pacman) is installed on your system. Pacman will manage automatic installation and loading of packages. 

```r

if (!require(pacman)) {
  install.packages("pacman")
}
```
2. install and/or load the packages below.

```r
pacman::p_load(
  R6,        # R6 package for OOP in R
  reticulate # Reticulate package to use Python libraries in R
)

- Ensure the faker package is installed in your python installation. If not you can install within R using the following line of code:

```r
# Install faker package
    py_install("faker")
```


```
3. Thereafter run the entire script and you should get the following printout if everything is fine, demonstrating the full capabilities of the system, below is a truncated snippet:

```r
Product Health Insurance (ID: 1 ) has been created and is currently active.
Product Life Insurance (ID: 2 ) has been created and is currently active.
Product Travel Insurance (ID: 3 ) has been created and is currently active.
Policyholder Donald Walker (ID: 1825 ) has been created and is currently active.
.
.

Payment 1 for William Bowman has been processed.
[1] "Reminder: Payment of 700 for Patrick Ryan for product Life Insurance is due on 2024-08-01"
Penalty of 50 applied to payment 2 . New amount: 750
.
.

Product Updated Home Insurance (ID: 4 ) has been suspended.
[1] "\nPolicyholder details by category:"

[1] "\nRegistered Policyholder:"
ID: 1825
Name: Donald Walker
Status: Active
Phone Number: 001-218-519-6001x3389
Email: lrobinson@example.com
Sex: M
Age: 69
Products: Health Insurance
[1] "\nSuspended Policyholder:"

```

## Files Description:

- base_entity.py: Contains the BaseEntity class which provides common attributes and methods for other classes.
- insurance_data_generator.py: Uses the faker library to generate fake data for policyholders.
- main.py: Demonstrates the functionality of the system by creating policyholders, registering products, processing payments, and more.
- payment.py: Contains the Payment class, which handles payment processing, sending reminders, and applying penalties.
- policyholder.py: Contains the Policyholder class, which manages policyholder registration, suspension, and reactivation.
- product.py: Contains the Product class, which manages the creation, updating, and suspension of products.



## Prerequisites:

- Python 3.12.x  or higher
- faker library 

## Installation: 

1. **Clone the resposity:**

git clone https://github.com/RProdDigest/policy_management_system.git

cd policy_management_system

2. **Install the required dependancies:**

 pip install faker 


## Example Usage:

The main function demonstrates the system by creating products, generating fake policyholders, registering products to policyholders, processing payments, sending reminders, applying penalties, and printing details.

```r
# Main function to demonstrate the functionalities
main <- function() {
  tryCatch({
    # Create some products
    product1 <- Product$new(product_id = 1, name = "Health Insurance", price = 500)
    product2 <- Product$new(product_id = 2, name = "Life Insurance", price = 700)
    product3 <- Product$new(product_id = 3, name = "Travel Insurance", price = 300)
    
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
    payment1 <- Payment$new(payment_id = 1, policyholder = policyholders[[4]], product = product1, amount = 500, due_date = "2024-08-01")
    payment2 <- Payment$new(payment_id = 2, policyholder = policyholders[[5]], product = product2, amount = 700, due_date = "2024-08-01")
    
    payment1$process_payment()
    print(payment2$send_reminder())
    payment2$apply_penalty(50)
    payment2$process_payment()
    
    # Demonstrate product creation, updating, and suspension
    new_product <- Product$new(product_id = 4, name = "Home Insurance", price = 400)
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
```


## Design Philosophy in R

The script provides an example of an object-oriented system in R using the R6 package. The main features include:

Creating and managing policyholders, products, and payments.
Using Python's faker library to generate synthetic data.
Demonstrating key OOP principles such as inheritance, encapsulation, and polymorphism.
Handling errors gracefully with tryCatch.

## Classes

### BaseEntity

- **Attributes**:
  - `entity_id`: Unique identifier for the entity.
  - `name`: Name of the entity.
  - `active`: Status of the entity (active or suspended).

- **Methods**:
  - `initialize(entity_id, name)`: Initializes a new entity.
  - `suspend()`: Suspends the entity.
  - `reactivate()`: Reactivates the entity.
  - `get_details()`: Returns the details of the entity.

### Product

- **Attributes**:
  - Inherits attributes from `BaseEntity`.
  - `price`: Price of the product.
  - `product_catalog`: Catalog of products.

- **Methods**:
  - `initialize(product_id, name, price)`: Initializes a new product.
  - `add_to_catalog()`: Adds the product to the catalog.
  - `get_product_by_id(product_id)`: Returns a product by its ID.
  - `update(name = NULL, price = NULL)`: Updates the product details.
  - `get_details()`: Returns the details of the product.

### Policyholder

- **Attributes**:
  - Inherits attributes from `BaseEntity`.
  - `phone_number`: Phone number of the policyholder.
  - `email`: Email of the policyholder.
  - `age`: Age of the policyholder.
  - `sex`: Sex of the policyholder.
  - `products`: List of products registered to the policyholder.

- **Methods**:
  - `initialize(policyholder_id, name, phone_number, email, age, sex)`: Initializes a new policyholder.
  - `register_product(product)`: Registers a product to the policyholder.
  - `get_details()`: Returns the details of the policyholder.

### Payment

- **Attributes**:
  - Inherits attributes from `BaseEntity`.
  - `policyholder`: Policyholder making the payment.
  - `product`: Product for which the payment is made.
  - `amount`: Amount of the payment.
  - `due_date`: Due date of the payment.
  - `paid`: Status of the payment (paid or not).

- **Methods**:
  - `initialize(payment_id, policyholder, product, amount, due_date)`: Initializes a new payment.
  - `process_payment()`: Processes the payment.
  - `send_reminder()`: Sends a payment reminder.
  - `apply_penalty(penalty_amount)`: Applies a penalty to the payment.
  - `get_details()`: Returns the details of the payment.





## Demonstrated Functionalities:

1. **Policyholder Actions:**
  - Registering a product to a policyholder.
  - Suspending and reactivating policyholders.

2. **Payment Handling:**
  - Processing payments.
  - Sending payment reminders.
  - Applying penalties to late payments.

3. **Product Management:**
  - Creating new products.
  - Updating product details.
  - Suspending products.

4. **Example Output:**

The script will output details for selected policyholders and products to demonstrate the specified functionalities. Each policyholder involved in different scenarios will have their details printed, including:
- policy type 
- policy ID 
- name 
- sex 
- age 
- email 
- phone number.

## Utility Functions

- `print_entity_details(entity)`: Prints the details of an entity in a readable format.

## Main Function

The `main()` function demonstrates the functionalities of the classes by:
1. Creating some products.
2. Generating fake policyholders using the `faker` library.
3. Registering products to policyholders.
4. Demonstrating registering, suspending, and reactivating policyholders.
5. Creating payments and demonstrating payment processing, reminders, and penalties.
6. Printing selectively policyholder and product details.
## Error Handling

The script uses `tryCatch()` to handle errors gracefully in the `main()` function. Any errors encountered during the execution will be printed as messages.

- Example:

``` python

main <- function() {
  tryCatch({
    # Create some products
    product1 <- Product$new(product_id = 1, name = "Health Insurance", price = 500)
    product2 <- Product$new(product_id = 2, name = "Life Insurance", price = 700)
    product3 <- Product$new(product_id = 3, name = "Travel Insurance", price = 300)
    
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
    payment1 <- Payment$new(payment_id = 1, policyholder = policyholders[[4]], product = product1, amount = 500, due_date = "2024-08-01")
    payment2 <- Payment$new(payment_id = 2, policyholder = policyholders[[5]], product = product2, amount = 700, due_date = "2024-08-01")
    
    payment1$process_payment()
    print(payment2$send_reminder())
    payment2$apply_penalty(50)
    payment2$process_payment()
    
    # Demonstrate product creation, updating, and suspension
    new_product <- Product$new(product_id = 4, name = "Home Insurance", price = 400)
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


```
## Author Details and Links

- mnsofu@learner.nexford.org
- ![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/:RProDigest)


 
## 🚀 About Me
I'm a data scientist with a backgrouund in Mobile Telecomunications  with a passion to share knowledge and solve problems


## Support

For support, email mnsofu@learner.nexford.org or RProDigest@Protonmail.com.


## License

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

This project is licensed under the MIT License. Feel free to use and modify the code as needed.
## Contributions

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.