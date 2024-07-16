
# Employee Details Retrieval and Compression

This README provides detailed instructions and explanations for using the Python code, making it easy for users to understand and implement the functionality.

This Jupyter notebook provides functionality to:

- Retrieve details for a given employee by name.
- Save the retrieved details to a CSV file.
- Compress the CSV file into a ZIP file.


## Prerequisites

- Python 3.12 or higher
- pandas 
- zipfile module (part of the Python Standard Library)
- os module (part of the Python Standard Library)
- ydata_profiling 
## Installation 

The Jupyter note book has cells with that installation any missing libraries or modules 
On macOS and Linux:

To Install manually in your notebook run the following commands in a cell
```sh
%pip install ydata-profiling[notebook]
% pip install pandas
```


## Author Details and Links

- mnsofu@learner.nexford.org
- ![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/:RProDigest)


 
## Features

- Retrieve details for a given employee by name.
- Save the retrieved details to a CSV file.
- Compress the CSV file into a ZIP file.
- Error handling logic using try exception blocks
- Exploratory Data Analysis (EDA) using Profile library


## Documentation


1. Run the Jupyter NoteBook(ipynb file) from the first cell. Note if you do not have pandas installed on your system please run the following command in the notebook cell

```sh
%pip install pandas
```

2. Check your working directory and ensure the dataset is in your working directory

```sh
# get the current working directory
current_working_directory = os.getcwd()

# print output and then replace directory_location with the output of where the file lives
print(current_working_directory)
```
3. Once you know your working directory copy the dataset into that directory and set the filepath

```sh
# Example : file_path = "Your/Path/Total.csv"
```
Please note the dataset can be found here https://www.kaggle.com/code/itshorus/sf-salary/input 


## Usage and Examples

Once the preceeding instructions are completed, usage is as follows:

- ***Retrieving Employee Details***

Use the employee_details function to retrieve details for a given employee by name.

Employee Function Details Definition

``` sh

def employee_details(employee_name):
    """
    This function retrieves details for a given employee by name.

    The function searches for an employee in the employee_df DataFrame
    by matching the provided employee_name. If a match is found, it 
    returns the employee's details as a dictionary. If no match is found,
    it returns a message indicating that no details were found. The function
    also includes error handling to manage any potential issues gracefully.

    Parameters:
    employee_name (str): The name of the employee to search for.

    Returns:
    dict or str: A dictionary containing the employee's details if found, 
                 otherwise a string message indicating that no details were found.
                 If an error occurs, a string message with the error details is returned.

    Example:
    employee_details("thomas")
    """
    try:
        # I search for the employee by name in the pandas DataFrame
        # I use the str.contains method for case-insensitive matching because the dataframe has upper case and lower case characters

        employee = employee_df[employee_df['EmployeeName'].str.contains(employee_name, case=False)]
        
        if not employee.empty:
            # I convert the employee's details to a dictionary and return if the employee is found in the dataframe
            return employee.iloc[0].to_dict()
        else:
            # I return the message below if no employee is found in the pandas DataFrame
            return f"No details found for employee: {employee_name}"
    except Exception as e:
        # I handle any exceptions that occur and return an error message
        return f"An error occurred: {str(e)}"

```

*Example number 1: Employee name in the data frame*

```sh
print(employee_details("thomas")) # function is case insensitive

# result you should expect

{'EmployeeName': 'THOMAS ABBOTT',
 'JobTitle': 'BATTALION CHIEF, (FIRE DEPARTMENT)',
 'BasePay': 168692.63,
 'OvertimePay': 59760.9,
 'OtherPay': 21954.96,
 'Benefits': 'Not Provided',
 'TotalPay': 250408.49,
 'TotalPayBenefits': 250408.49,
 'Year': 2011}
```

*Example number 2: Employee name not in the data frame*

```sh
employee_details('Joe Doe')

# result you should expect

No details found for employee: Joe Doe

```

- ***Saving Employee Details to a ZIP File***
Use the save_employee_details_to_zip function to save the retrieved employee details to a CSV file and compress it into a ZIP file. Run the function then call it as shown in the example further below.

Function Definition

```sh
def save_employee_details_to_zip(employee_name, output_zip_file):
    """
    Retrieve details for a given employee by name and save them to a CSV file,
    which is then zipped into a specified output file.

    This function uses the employee_details function to get the employee's details,
    writes the details to a CSV file, and then compresses the CSV file into a ZIP file.

    Parameters:
    employee_name (str): The name of the employee to search for.
    output_zip_file (str): The path to the output ZIP file.

    Returns:
    str: A message indicating whether the process was successful or if an error occurred.

    Example:
    save_employee_details_to_zip("thomas", "employee_details.zip")
    """
    try:
        # I get employee details using the employee_details function defined previously
        details = employee_details(employee_name)
        
        if isinstance(details, dict):
            # If the details are found and returned as a dictionary then,
            # Create a DataFrame from the employee details dictionary
            df = pd.DataFrame([details])
            csv_file = "employee_details.csv"
            
            # Then save the DataFrame to a CSV file
            df.to_csv(csv_file, index=False)
            
            # And then create a ZIP file and add the CSV file to it as requested 
            with zipfile.ZipFile(output_zip_file, 'w', zipfile.ZIP_DEFLATED) as zipf:
                zipf.write(csv_file)
            
            # I then clean up the CSV file by removing it after zipping
            os.remove(csv_file)
             # Return a success message after the operation
            return f"Employee details saved and zipped successfully as {output_zip_file}."
        else:
            # If details are not found, return the message from the employee_details function
            return details 
    except Exception as e:
        # I handle any exceptions that occur and return an error message
        return f"An error occurred: {str(e)}"


```

How to use the save_employee_details_to_zip function

*Example number 1:*

```sh
# Let us call the function and pass an employee name

print(save_employee_details_to_zip("thomas", "Employee Profile.zip"))

# result you should see

Employee details saved and zipped successfully as Employee Profile.zip.
```

*Example number 2:*

```sh
# Let us call the function and pass a non existent employee name

print(save_employee_details_to_zip("joe doe", "Employee Profile.zip"))

# result you should see

No details found for employee: joe doe
```


## Error Handling

Both functions include error handling to manage potential issues gracefully:

The employee_details function returns a message if no details are found or if an error occurs.
The save_employee_details_to_zip function handles exceptions and returns an appropriate error message.
## 🚀 About Me
I'm a data scientist with a backgrouund in Mobile Telecomunications  with a passion to share knowledge and solve problems


## Support

For support, email mnsofu@learner.nexford.org or RProDigest@Protonmail.com.


## License

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

This project is licensed under the MIT License. Feel free to use and modify the code as needed.