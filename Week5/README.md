
# Principal Component Analysis of Breast Cancer Data

- Author: Mubanga Nsofu
- Course: BAN6420, Module 5
- Email: mnsofu@learner.nexford.org
- Learner ID: 149050
- Institution: Nexford University
- Lecturer: Prof. R. Wanjiku
- Date: 3rd August 2024
- Task: Dimensionality Reduction of Breast Cancer Data Using PCA

This repository contains a Jupyter Notebook for the implementation of Principal Component Analysis (PCA) on a Breast Cancer dataset using the scikit-learn library. The notebook provides a step-by-step guide, starting from data loading, preprocessing, PCA application, and visualization of results.




## Requirements

Ensure you have the following libraries installed:

- pandas
- scikit-learn
- matplotlib
- seaborn
- sweetviz
- python 3.12.x 

The piece of code below shows how install the libraries assuming you already have python installed. Incase you do not have python on your system please visit the following link and follow the installation instructions: https://www.python.org/downloads/

If you have an existing  installation of python, you might need to upgrade your version of pip (package installer for python ) at the command prompt

```python
python.exe -m pip install --upgrade pip
```

1.0 INSTALL THE NECESSARY PYTHON LIBRARIES

```python
pip install pandas scikit-learn matplotlib seaborn sweetviz
```


## Import the dataset

- Load the breast cancer dataset from scikit-learn library as shown below.

```python
breast_cancer = datasets.load_breast_cancer() # This line imports the breast cancer dataset from the 'dataset' module in scikit-learn

```
- Ensure you have read and write access to the directory.


## High Level Technical Details

Exploratory Data Analysis (EDA)
EDA involves:

- Loading the breast cancer dataset from scikit-learn
- Inspecting the dataset structure and content

Data Preprocessing
Steps include:

- Separating features and target labels
- Standardizing the dataset to ensure variables have comparable scales

PCA Implementation

- Applying PCA to the standardized dataset using scikit-learn's PCA class
- Transforming the data into a new 2D space defined by the first two principal components

Visualization
- Visualizing the results using a scatter plot to illustrate the effectiveness of PCA in dimensionality reduction
## How to run the Notebook

- Open the Jupyter Notebook and run the cells sequentially to reproduce the analysis.


## Troubleshooting

For any queries with regards to troubleshooting, please contact the author via email at mnsofu@learner.nexford.org.
## Contact Author

- [@RProDigest](https://www.github.com/RProDigest)
- [@RProDigest](https://www.twitter.com/RProDigest)


## References

- Jolliffe, I. T. (2002). Principal component analysis (2nd ed.). Springer.
- Buitinck, L., et al. (2013). API design for machine learning software: Experiences from the scikit-learn project. In ECML PKDD Workshop: Languages for Data Mining and Machine Learning (pp. 108-122).