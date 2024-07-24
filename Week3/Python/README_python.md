
# Insurance Policy Management System




This project implements a Policy Management System for an insurance company. The system manages policyholders, products, and payments, allowing various tasks such as adding and suspending policyholders, registering new members, managing policy products, processing payments, sending reminders, and applying penalties. 

## Project Structure:

``` plaintext
policy_management_system/
│
├── base_entity.py
├── insurance_data_generator.py
├── main.py
├── payment.py
├── policyholder.py
├── product.py
└── README.md

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


## Usage:

- To run the project at the command prompt of the folder that contains the files and see the functionality by executing the main.py script as follows:

```python
python main.py # assumes you have navigated to the folder containing the python files
```


## Design Philosophy

The Insurance Policy Management System's design is based on Object-Oriented Programming (OOP) principles, with a focus on simplicity, modularity, and maintainability. The use of OOP allows for an easily extendable, testable, and understandable system. The fundamental design principles include:

1. **Encapsulation:** Encapsulation: Encapsulation is achieved by keeping the data (attributes) private and exposing only necessary methods. This protects the internal state of objects and prevents unintended interference. For example see below:

```python

class BaseEntity:
    def __init__(self, entity_id, name):
        self._entity_id = entity_id
        self._name = name
        self._active = True
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been created and is currently active.")

    def suspend(self):
        if not self._active:
            raise ValueError(f"{self.__class__.__name__} is already suspended.")
        self._active = False
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been suspended.")

    def reactivate(self):
        if self._active:
            raise ValueError(f"{self.__class__.__name__} is already active.")
        self._active = True
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been reactivated.")

    def get_details(self):
        status = "Active" if self._active else "Suspended"
        details = {
            'ID': self._entity_id,
            'Name': self._name,
            'Status': status
        }
        print(f"{self.__class__.__name__} Details: {details}")
        return details

    @property
    def entity_id(self):
        return self._entity_id

    @property
    def name(self):
        return self._name

    @property
    def active(self):
        return self._active


```

- **Private Attributes:** The attributes _entity_id, _name, and _active in BaseEntity are private, indicated by the underscore prefix. Private attributes ensure data security, prevent accidental changes, and make the system more reliable and easier to maintain, ensuring smooth application operation and robustness.

- **Public Methods:** The public methods such as suspend, reactivate, and get_details are provided to interact with the object's state in a controlled manner.

- **Property Decorators:** The @property decorator is used to define getter methods for the attributes, providing a controlled way to access these attributes from outside the class.


By encapsulating the attributes, the design ensures that the internal state of the objects is protected and can only be accessed or modified through well-defined interfaces. This helps maintain the integrity of the objects and prevents unintended side effects.

2. **Inheritance:** The use of inheritance allows us to create a base class (BaseEntity) that contains common attributes and methods, reducing code duplication and enhancing code reusability. The other classes then inherit from this base class using the super () method. For example, in the code below, payment class is inheriting from the BaseEntity class.

```python
from base_entity import BaseEntity
from product import Product
from policyholder import Policyholder

class Payment(BaseEntity):
    def __init__(self, payment_id, policyholder, product, amount, due_date):
        super().__init__(payment_id, f"Payment for {policyholder.name}")
        self._policyholder = policyholder
        self._product = product
        self._amount = amount
        self._due_date = due_date
        self._paid = False

    def process_payment(self):
        if self._paid:
            raise ValueError("Payment has already been processed.")
        self._paid = True
        print(f"Payment {self._entity_id} for {self._policyholder.name} has been processed.")

    def send_reminder(self):
        if self._paid:
            return "Payment already made"
        return f"Reminder: Payment of {self._amount} for {self._policyholder.name} for product {self._product.name} is due on {self._due_date}"

    def apply_penalty(self, penalty_amount):
        if self._paid:
            raise ValueError("Cannot apply penalty to a paid payment.")
        self._amount += penalty_amount
        print(f"Penalty of {penalty_amount} applied to payment {self._entity_id}. New amount: {self._amount}")

    def get_details(self):
        details = super().get_details()
        details.update({
            'Policyholder': self._policyholder.name,
            'Product': self._product.name,
            'Amount': self._amount,
            'Due Date': self._due_date,
            'Status': 'Paid' if self._paid else 'Unpaid'
        })
        return details

    @property
    def policyholder(self):
        return self._policyholder

    @property
    def product(self):
        return self._product

    @property
    def amount(self):
        return self._amount

    @property
    def due_date(self):
        return self._due_date

    @property
    def paid(self):
        return self._paid


```

3. **Composition:** Composition is a design principle where a class is composed of one or more objects from other classes, giving it more complex functionalities. In our policy management system, we use composition to associate products with policyholders.

In the Policyholder class, we use composition to include multiple Product objects within a Policyholder object. This is demonstrated by the _products attribute, which is a list of Product objects.

```python
from base_entity import BaseEntity
from product import Product

class Policyholder(BaseEntity):
    def __init__(self, policyholder_id, name, phone_number, email, age, sex):
        super().__init__(policyholder_id, name)
        self._phone_number = phone_number
        self._email = email
        self._age = age
        self._sex = sex
        self._products = []

    def register_product(self, product):
        if product in self._products:
            raise ValueError(f"Product {product.name} is already registered.")
        self._products.append(product)
        print(f"Product {product.name} has been registered to policyholder {self._name}.")

    def get_details(self):
        details = super().get_details()
        details.update({
            'Phone Number': self._phone_number,
            'Email': self._email,
            'Sex': self._sex,
            'Age': self._age,
            'Products': [product.name for product in self._products]
        })
        return details

    @property
    def phone_number(self):
        return self._phone_number

    @property
    def email(self):
        return self._email

    @property
    def age(self):
        return self._age

    @property
    def sex(self):
        return self._sex

    @property
    def products(self):
        return self._products

```

4. **Polymorphism:** Allows objects of different classes to be treated as objects of a common superclass, enabling more generic and flexible code to be written. In our policy management system context, we have demonstrated polymorphism by having a method that operates on instances of the BaseEntity class and its subclasses (such as Product, Policyholder, and Payment). Polymorphism allows for more flexible code.


```python
class BaseEntity:
    def __init__(self, entity_id, name):
        self._entity_id = entity_id
        self._name = name
        self._active = True
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been created and is currently active.")

    def suspend(self):
        if not self._active:
            raise ValueError(f"{self.__class__.__name__} is already suspended.")
        self._active = False
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been suspended.")

    def reactivate(self):
        if self._active:
            raise ValueError(f"{self.__class__.__name__} is already active.")
        self._active = True
        print(f"{self.__class__.__name__} {self._name} (ID: {self._entity_id}) has been reactivated.")

    def get_details(self):
        status = "Active" if self._active else "Suspended"
        details = {
            'ID': self._entity_id,
            'Name': self._name,
            'Status': status
        }
        print(f"{self.__class__.__name__} Details: {details}")
        return details

    @property
    def entity_id(self):
        return self._entity_id

    @property
    def name(self):
        return self._name

    @property
    def active(self):
        return self._active




```

```python
from base_entity import BaseEntity

class Product(BaseEntity):
    product_catalog = {}

    def __init__(self, product_id, name, price):
        super().__init__(product_id, name)
        self._price = price
        Product.product_catalog[product_id] = self

    @staticmethod
    def get_product_by_id(product_id):
        return Product.product_catalog.get(product_id)

    def update(self, name=None, price=None):
        if name:
            self._name = name
            print(f"Name of Product {self._entity_id} has been updated to '{name}'")
        if price:
            self._price = price
            print(f"Price of Product {self._entity_id} has been updated to {price}")

    def get_details(self):
        details = super().get_details()
        details.update({'Price': self._price})
        return details

    @property
    def price(self):
        return self._price

```

Polymorphism is demonstrated by the display_entity_details function, which accepts a list of BaseEntity objects (or any of its subclasses) and calls the get_details method on each. This allows the function to handle different types of objects (Product, Policyholder, and Payment) uniformly, illustrating the power and flexibility of polymorphism in object-oriented design.

5. **Separation of Concerns:** Each class is responsible for a specific aspect of the system, such as managing policyholders, products, or payments. This separation of concerns makes the system easier to maintain and extend and are implemented as classes.

- **BaseEntry Class:** Provides common attributes and methods for all entities
- **Product Class:** Manages product-specific attributes and behaviors.
- **Policyholder Class:** Manages policyholder-specific attributes and behaviors.
- **Payment Class:** Manages payment-specific attributes and behaviors.
- **Insurance Data Generation:** Generates fake policyholder data using the faker library.
- **Main Script:** Demonstrates the functionality and coordinates interactions between classes.


By adhering steadfastly to these principles, we have crafted a Policy Management System that is robust, scalable, and easy to understand. This design philosophy not only makes our system suitable for real-world applications but also paves the way for seamless future enhancements, ensuring its longevity and relevance in the ever-evolving technological landscape.
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
## Error Handling

The system includes comprehensive error handling to ensure robustness and reliability. Key aspects of error handling include:

ValueError Exceptions: The code raises ValueError exceptions to handle invalid operations, such as attempting to suspend an already suspended policyholder or process an already processed payment.

Try-Except Blocks: The main.py script uses try-except blocks to catch and handle exceptions gracefully, providing informative error messages without crashing the program.

Input Validation: Methods validate inputs to ensure only valid data is processed, preventing potential errors and maintaining data integrity.

- Example:

``` python

def process_payment(self):
    if self._paid:
        raise ValueError("Payment has already been processed.")
    self._paid = True
    print(f"Payment {self._entity_id} for {self._policyholder.name} has been processed.")

```

In main.py:

```python

try:
    # Example code execution
except Exception as e:
    print(f"An error occurred: {e}")


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