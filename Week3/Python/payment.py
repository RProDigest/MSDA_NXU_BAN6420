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
