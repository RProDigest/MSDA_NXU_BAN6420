
# Netflix Data Visualisation Using R

- Author: Mubanga Nsofu
- Course: BAN6420, Module 4
- Email: mnsofu@learner.nexford.org
- Learner ID: 149050
- Institution: Nexford University
- Lecturer: Prof. R. Wanjiku
- Date: 27th July 2024
- Task: Netflix Data Visualization- Console version of script

TThis project involves data visualization of a Netflix dataset. The goal is to explore and visualize various aspects of the data using R libraries such as tidyverse, DataExplorer, magrittr, and ggtext.




## Requirements

Ensure you have the following libraries installed:

- tidyverse (a metapackage for a complete datascience workflow)
- DataExplorere
- magrittr
- ggtext
- pacman

The piece of code below automatically handles the installation and loading for you

```R
 1.0 INSTALL PACMAN IF NECESSARY PACKAGES

if (!require(pacman))
  install.packages("pacman")


2.0 LOAD THE LIBRARIES USING PACKAGE MANAGER

pacman::p_load(tidyverse, # meta package for the data analytics life cycle
               DataExplorer, # For rapid EDA
               magrittr, # additional pipe
               ggtext # powerful package for text formatting on graphs
)

```

In addition ensure you have R 4.4.0 or higher installed on your machine

## Setup Instructions

- Place the Netflix dataset (netflix_data.csv) in your R working directory.
- Ensure you have read and write access to the directory.

Note: you can check your R working directory by running the following command

```R

getwd()

```

**Running the Script:**

-Save the provided script as netflix_analysis.R in your working directory.

**Open R or RStudio.**

Source the script using the following command:

```R
source("netflix_analysis.R")

```

This will execute the script, performing exploratory data analysis and generating visualizations.

## Visualizations:

- The script generates a plot showing the distribution of ratings and saves it as ratings_plot.png.
- An exploratory data analysis report will be generated and saved as report.html.
## Troubleshooting

If you encounter any issues, ensure the following:

- The netflix_data.csv file is in the correct directory.
- You have read and write access to the directory.
- All required libraries are installed.

In case you need further support, you can contact me at the links below.
## Contact Author

- [@RProDigest](https://www.github.com/RProDigest)
- [@RProDigest](https://www.twitter.com/RProDigest)

