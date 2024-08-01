################################################################################
# Name: Mubanga Nsofu                                                          #
# Institution: Nexford University (NXU)                                        #
# Date : 27th July 2024                                                        #
# Course: BAN 6420                                                             #
# Program: Master of Science Data Analytics (MSDA)                             #
# Lecturer: Professor Raphael Wanjiku                                          #
# Assignment : 4                                                               #
################################################################################

## 1.0 INSTALL PACMAN IF NECESSARY PACKAGES-----

if (!require(pacman))
  install.packages("pacman")


## 2.0 LOAD THE LIBRARIES USING PACKAGE MANAGER-----

pacman::p_load(tidyverse, # meta package for the data analytics life cycle
               DataExplorer, # For rapid EDA
               magrittr, # additional pipe
               ggtext # powerful package for text formatting on graphs
)
# Let us read in the Netflix dataset using a function from readr package
 
Netflix_shows_movies <- read_csv("netflix_data.csv")

## 3.0. EXPLORE THE DATASET USING DATA EXPLORER FUNCTIONS-----------
 
# Let us generate an exploratory data analysis report using DataExplorer

Netflix_shows_movies %>%
 DataExplorer::create_report()
 
# DataExplorer package produces a nice summary report called 'report.html'
 
## 4.0 Plot Ratings USING GGPLOT2

# Ratings is a char, we need to convert to a factor and reorder
 
Netflix_shows_movies$rating %<>% as.factor() # special pipe from magrittr

Netflix_shows_movies %>%
  group_by(rating) %>%
  drop_na(rating) %>%
  summarise(totals = n()) %>%
  mutate(rating = fct_reorder(rating, totals)) |>
  ggplot(aes(x = totals, y = rating)) +
  geom_col() +
  theme_minimal() +
  labs(subtitle = "TV-MA has the highest count of ratings",
       caption = "Plotted by M.Nsofu, NXU",
       x = "count") +
  ggtitle("**Ratings Per Genre**") +
  theme(plot.title = ggtext::element_markdown())

 # let us save the plot -------------
 ggsave("ratings_plot.png", dpi = 1040)
 