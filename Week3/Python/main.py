from product import Product
from payment import Payment
from insurance_data_generator import generate_fake_policyholders

def main():
    try:
        # Create some products
        product1 = Product(product_id=1, name="Health Insurance", price=500)
        product2 = Product(product_id=2, name="Life Insurance", price=700)
        product3 = Product(product_id=3, name="Travel Insurance", price=300)

        # Generate nine fake policyholders
        policyholders = generate_fake_policyholders(9)

        # Register a product to each policyholder
        policyholders[0].register_product(product1)  # Registration
        policyholders[1].register_product(product2)
        policyholders[2].register_product(product3)

        # Demonstrate registering, suspending, and reactivating policyholders
        policyholders[1].suspend()  # Suspension
        policyholders[2].suspend()  # Suspension
        policyholders[2].reactivate()  # Reactivation

        # Create payments and demonstrate payment processing, reminders, and penalties
        payment1 = Payment(payment_id=1, policyholder=policyholders[3], product=product1, amount=500, due_date="2024-08-01")
        payment2 = Payment(payment_id=2, policyholder=policyholders[4], product=product2, amount=700, due_date="2024-08-01")

        payment1.process_payment()  # Payment processing
        print(payment2.send_reminder())  # Payment reminder
        payment2.apply_penalty(50)  # Applying penalty
        payment2.process_payment()  # Processing after penalty

        # Demonstrate product creation, updating, and suspension
        new_product = Product(product_id=4, name="Home Insurance", price=400)
        new_product.update(name="Updated Home Insurance", price=450)  # Updating product
        new_product.suspend()  # Suspending product

        # Selectively print policyholder details
        print("\nPolicyholder details by category:")

        # Registration
        print("\nRegistered Policyholder:")
        print_policyholder_details(policyholders[0])

        # Suspension
        print("\nSuspended Policyholder:")
        print_policyholder_details(policyholders[1])

        # Reactivation
        print("\nReactivated Policyholder:")
        print_policyholder_details(policyholders[2])

        # Payment processing
        print("\nPolicyholder with Processed Payment:")
        print_policyholder_details(policyholders[3])

        # Payment reminder
        print("\nPolicyholder with Payment Reminder Sent and Penalty Applied:")
        print_policyholder_details(policyholders[4])

        # Product details
        print("\nProduct Details:")
        new_product.get_details()

    except Exception as e:
        print(f"An error occurred: {e}")

def print_policyholder_details(policyholder):
    details = policyholder.get_details()
    print(f"Policy Type: {policyholder.products[0].name if policyholder.products else 'N/A'}")
    print(f"Policy ID: {policyholder.entity_id}")
    print(f"Name: {details['Name']}")
    print(f"Sex: {details['Sex']}")
    print(f"Age: {details['Age']}")
    print(f"Email: {details['Email']}")
    print(f"Phone Number: {details['Phone Number']}")

if __name__ == "__main__":
    main()
