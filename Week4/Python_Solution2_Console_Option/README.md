
# Netflix Data Visualisation

- Author: Mubanga Nsofu
- Course: BAN6420, Module 4
- Email: mnsofu@learner.nexford.org
- Learner ID: 149050
- Institution: Nexford University
- Lecturer: Prof. R. Wanjiku
- Date: 27th July 2024
- Task: Netflix Data Visualization- Console version of script

This project involves data visualization of a Netflix dataset. The goal is to explore and visualize various aspects of the data using Python libraries such as pandas, seaborn, matplotlib, and sweetviz. Prior to that it is required to consider the data quality and fix any issues(such as missingness, where appropriate).




## Requirements

Ensure you have the following libraries installed:

- pandas
- sweetviz
- seaborn
- matplotlib

You can install the necessary libraries using the following pip command:

```python

pip install pandas sweetviz seaborn matplotlib

```

In addition ensure you have python 3.12.x or higher

## Installation

- Ensure you have installed the libraries prescribed in the file section above
## Running the Script

**2.0 Running the Script:**

- Save the provided script as netflix_analysis.py in your working directory.
- Open a terminal or command prompt.
- Navigate to the directory where netflix_analysis.py is located
- Run the script using the following command:

```python
python netflix_analysis.py

```
**3. Visualizations:**
- Ratings Distribution:

```python
plt.figure(figsize=(10, 6))
sns.histplot(Netflix_shows_movies['rating'], kde=True, bins=20)
plt.title('Ratings Distribution')
plt.xlabel('Rating')
plt.ylabel('Frequency')
plt.show()
```
- Top 10 most watched genres: 

```python
genre_counts = Netflix_shows_movies['listed_in'].str.split(',').explode().value_counts().head(10).reset_index()
genre_counts.columns = ['genre', 'count']

plt.figure(figsize=(12, 8))
sns.barplot(data=genre_counts, x='count', y='genre')
plt.title('Top 10 Most Watched Genres')
plt.xlabel('Number of Shows/Movies')
plt.ylabel('Genre')
plt.show()
```

- Release Year Distribution

```python
plt.figure(figsize=(10, 6))
sns.histplot(Netflix_shows_movies['release_year'], kde=True, bins=20)
plt.title('Release Year Distribution')
plt.xlabel('Year')
plt.ylabel('Frequency')
plt.show()
```

## Script Details

**Functionality**

The notebook performs the following tasks:

1. Checks Working Directory:
Prints the current working directory to ensure the dataset is in the correct location.

2. Loads the Dataset:
Reads the netflix_data.csv file into a DataFrame named Netflix_shows_movies.

3. Performs High-Level EDA:
Uses the SweetViz library to generate a detailed HTML report of the dataset.

4. Performs EDA Using Pandas:

- Displays the first five rows of the dataset.
- Checks for missing values.
- Provides descriptive statistics for numerical columns.
- Prints information about the dataset.

5.  Plot Ratings Distribution:

- Creates a histogram to visualize the distribution of ratings.

6. Plot Release Year Distribution:

- Creates a histogram to visualize the distribution of release years.

7. Handles Missing Values Using Forward Fill:

- Fills missing values using the forward fill method and prints the dataset information after handling missing values.

8. Plots Director Distribution:

- Plots the distribution of the top 10 directors based on the number of shows/movies they have directed.

9. Drops Rows with Missing Values:

- Drops rows with any missing values and prints the dataset information after cleaning.


**Notes**
- Ensure you have the correct file paths when loading and saving the dataset.
- The SweetViz report will be saved as Netflix_Report.html in the same directory.
## Example Output

1. SweetViz Report:

A detailed HTML report named Netflix_Report.html will be generated, providing insights into the dataset.

2. Notebook Output:

- Information about the dataset before and after handling missing values will be printed to the console.

3. Visualizations:

- Ratings Distribution Histogram
- Top 10 Genres Distribution
- Movie Release year
- Top 10 Directors Distribution Bar Plot
## Troubleshooting

If you encounter any issues, ensure the following:

- The netflix_data.csv file is in the correct directory.
- You have read and write access to the directory.
- All required libraries are installed.

In case you need further support, you can contact me at the links below.
## Contact Author

- [@RProDigest](https://www.github.com/RProDigest)
- [@RProDigest](https://www.twitter.com/RProDigest)

