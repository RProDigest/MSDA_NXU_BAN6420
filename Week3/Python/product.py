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
