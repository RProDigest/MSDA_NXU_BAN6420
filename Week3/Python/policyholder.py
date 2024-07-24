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
