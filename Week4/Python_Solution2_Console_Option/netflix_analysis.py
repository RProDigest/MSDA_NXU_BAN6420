import pandas as pd
import sweetviz as sv  # Library for Exploratory Data Analysis (EDA)
import os  # Directory and File Manipulation
import seaborn as sns
import matplotlib.pyplot as plt

def main():
    """
    Main function to perform EDA, handle missing values, and create visualizations.
    """
    # Check working directory
    current_dir = os.getcwd()
    print(f"Current Working Directory: {current_dir}")

    # Read the Netflix dataset
    netflix_data_path = "netflix_data.csv"
    Netflix_shows_movies = pd.read_csv(netflix_data_path)

    # Perform high-level EDA using SweetViz
    perform_highlevel_eda(Netflix_shows_movies)

    # Perform EDA using pandas
    perform_pandas_eda(Netflix_shows_movies)

    # Example visualizations
    plot_ratings_distribution(Netflix_shows_movies)
    plot_release_year_distribution(Netflix_shows_movies)
    plot_most_watched_genres(Netflix_shows_movies)

    # Handle missing values with forward fill and plot director distribution
    handle_missing_values_ffill(Netflix_shows_movies)
    plot_director_distribution(Netflix_shows_movies)

    # Drop rows with missing values
    Netflix_shows_movies_cleaned = drop_missing_values(Netflix_shows_movies)

def perform_highlevel_eda(df: pd.DataFrame):
    """
    Perform high-level EDA using the SweetViz package.

    Parameters:
    df (pd.DataFrame): Input DataFrame.
    """
    report = sv.analyze(df)
    report.show_html('Netflix_Report.html')

def perform_pandas_eda(df: pd.DataFrame):
    """
    Perform EDA using pandas functions.

    Parameters:
    df (pd.DataFrame): Input DataFrame.
    """
    print("First five observations:")
    print(df.head())

    print("\nMissing values:")
    print(df.isnull().sum())

    print("\nDescriptive statistics:")
    print(df.describe())

    print("\nDataset info:")
    df.info()

def plot_ratings_distribution(df: pd.DataFrame):
    """
    Plot the distribution of ratings.

    Parameters:
    df (pd.DataFrame): Input DataFrame.
    """
    plt.figure(figsize=(10, 6))
    sns.histplot(df['rating'], kde=True, bins=20)
    plt.title('Ratings Distribution')
    plt.xlabel('Rating')
    plt.ylabel('Frequency')
    plt.show()

def plot_release_year_distribution(df: pd.DataFrame):
    """
    Plot the distribution of release years.

    Parameters:
    df (pd.DataFrame): Input DataFrame.
    """
    plt.figure(figsize=(10, 6))
    sns.histplot(df['release_year'], kde=True, bins=20)
    plt.title('Release Year Distribution')
    plt.xlabel('Year')
    plt.ylabel('Frequency')
    plt.show()

def plot_most_watched_genres(df: pd.DataFrame):
    """
    Plot the distribution of the top 10 most watched genres.

    Parameters:
    df (pd.DataFrame): Input DataFrame.
    """
    genre_counts = df['listed_in'].str.split(',').explode().value_counts().head(10).reset_index()
    genre_counts.columns = ['genre', 'count']

    plt.figure(figsize=(12, 8))
    sns.barplot(data=genre_counts, x='count', y='genre')
    plt.title('Top 10 Most Watched Genres')
    plt.xlabel('Number of Shows/Movies')
    plt.ylabel('Genre')
    plt.show()

def handle_missing_values_ffill(df: pd.DataFrame):
    """
    Handle missing values using forward fill.

    Parameters:
    df (pd.DataFrame): Input DataFrame.
    """
    df.ffill(inplace=True)
    print("\nDataset info after forward fill:")
    df.info()

def plot_director_distribution(df: pd.DataFrame):
    """
    Plot the distribution of the top 10 directors.

    Parameters:
    df (pd.DataFrame): Input DataFrame.
    """
    director_counts = df['director'].value_counts().head(10).reset_index()
    director_counts.columns = ['director', 'count']

    plt.figure(figsize=(12, 8))
    sns.barplot(data=director_counts, x='count', y='director')
    plt.title('Top 10 Directors Distribution')
    plt.xlabel('Number of Shows/Movies')
    plt.ylabel('Director')
    plt.show()

def drop_missing_values(df: pd.DataFrame) -> pd.DataFrame:
    """
    Drop rows with any missing values.

    Parameters:
    df (pd.DataFrame): Input DataFrame.

    Returns:
    pd.DataFrame: DataFrame with rows containing missing values dropped.
    """
    df_cleaned = df.dropna()
    print("\nDataset info after dropping missing values:")
    df_cleaned.info()
    return df_cleaned

if __name__ == "__main__":
    main()
