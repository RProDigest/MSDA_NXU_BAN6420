
# FashionMNIST CNN Classification Project

- Author: Mubanga Nsofu
- Course: BAN6420, Module 6
- Email: mnsofu@learner.nexford.org
- Learner ID: 149050
- Institution: Nexford University
- Lecturer: Prof. R. Wanjiku
- Date: 13th August 2024
- Task: FashionMNIST Classifier

This project uses a CNN to classify images from the FashionMNIST dataset, which contains grayscale images of fashion items categorized into ten classes.



## FashionMNIST

The Fashion MNIST dataset provides an alternative to the MNIST handwriting dataset. MNIST, which stands for the Modified National Institute of Standards and Technology database, features hand-drawn numbers. In contrast, Fashion MNIST utilizes small images of various clothing items labeled with ten categories. Although Fashion MNIST is unrelated to the National Institute of Standards and Technology, it is still known as "MNIST" due to its recognition for image processing.
## Requirements

Ensure you have the following libraries installed:

- R
- R Studio
- pacman
- Keras3
- Tidyverse
- Yardstick
- python 3.9.x or higher 

The piece of code below shows how install the R libraries assuming you already have python installed. Incase you do not have python on your system please visit the following link and follow the installation instructions: https://www.python.org/downloads/.
Keras needs a Tensorflow backend, which lives in Python.


```r
if(!require(pacman))
  install.packages("pacman") 

```

1.0 INSTALL AND LOAD THE NECESSARY R LIBRARIES

```r
pacman::p_load(tidyverse, 
               keras3, 
               gridExtra, 
               yardstick  
)

```

In case you have errors and issues you will need to debug the incompatibilities. One alternative not discussed in the readme is to use the elegant reticulate package and run your code directly in R. For details on how to do this, please conact me (refer to the contact section).


## Run the code

- Once you have installed all the necessary libraries and loaded them, you can run the code 


## Troubleshooting

For any queries with regards to troubleshooting, please contact the author via email at mnsofu@learner.nexford.org.
## Contact Author

- [@RProDigest](https://www.github.com/RProDigest)
- [@RProDigest](https://www.twitter.com/RProDigest)

