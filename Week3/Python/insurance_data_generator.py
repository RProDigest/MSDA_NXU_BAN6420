# pip install faker

from faker import Faker
from policyholder import Policyholder

def generate_fake_policyholders(count=400, seed=42):
    """
    Generate a list of fake policyholders.

    Args:
        count (int): The number of fake policyholders to generate.
        seed (int): The seed value for the random number generator.

    Returns:
        list: A list of Policyholder objects.
    """
    fake = Faker()
    Faker.seed(seed)  # Set the seed for reproducibility
    policyholders = []

    for _ in range(count):
        policyholder_id = fake.unique.random_int(min=1, max=10000)
        name = fake.name()
        phone_number = fake.phone_number()
        email = fake.email()
        age = fake.random_int(min=18, max=80)
        sex = fake.random_element(elements=('M', 'F'))
        policyholder = Policyholder(policyholder_id, name, phone_number, email, age, sex)
        policyholders.append(policyholder)

    return policyholders
