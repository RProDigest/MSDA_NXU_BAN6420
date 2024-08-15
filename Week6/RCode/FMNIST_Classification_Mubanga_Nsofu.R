################################################################################
# Name: Mubanga Nsofu                                                          #
# Institution: Nexford University (NXU)                                        #
# Date : 13th August 2024                                                      #
# Course: BAN 6420                                                             #
# Program: Master of Science Data Analytics (MSDA)                             #
# Lecturer: Professor Raphael Wanjiku                                          #
# Assignment : 6 (Classification of FMNIST using CNNs)                         #
################################################################################


# 1.0 INSTALL NECESSARY PACKAGES AND SET SEED----

# Check if package manager is installed. Package manager(pacman) is used to 
# streamline package installation and loading.

if(!require(pacman))
  install.packages("pacman") 

# Load necessary packages using pacman. 
# - tidyverse: Essential for data manipulation and visualization
# - keras3: High-level API for building and training neural networks
# - gridExtra: For arranging multiple ggplot objects in a grid
# - yardstick: Part of the TidyModels framework, useful for measuring model performance

pacman::p_load(tidyverse, 
               keras3, 
               gridExtra, 
               yardstick  
)



# Set seed for reproducibility to ensure that results are consistent across runs.
# First line is for R
# Second line is for TensorFlow via Keras

set.seed(42) 
tensorflow::tf$random$set_seed(42) 


# 2.0 LOAD THE FashionMNIST DATASET----

# Load the FashionMNIST dataset using the keras API.

fashion_mnist <- dataset_fashion_mnist()



# 3.0 CREATE THE TEST AND TRAINING SETS----

# Split the dataset into training and test sets.

c(train_images, train_labels) %<-% fashion_mnist$train # Training set 
c(test_images, test_labels) %<-% fashion_mnist$test # Test set


# 4.0 EXPLORE THE DATASET AND VIZUALIZE IT-----

# Quick exploration of the dataset structure to understand its dimensions 
# and the type of data we are working with.

train_images %>% glimpse()
test_images %>% glimpse()
train_labels %>% glimpse()
test_labels %>% glimpse()


# Check dimensions of the training and test sets to ensure they are correctly loaded.

dim(train_images)
dim(train_labels)

# View a summary of the labels to get a sense of the data distribution.
train_labels %>% 
  summary()

# Explore Test Set as well

dim(test_images)
dim(test_labels)

test_labels %>% 
  summary()

# Visualize the 20th image in the training set. This step helps us confirm the 
# data is correctly formatted and visualize what the model will be trained on.

image <- as.data.frame(train_images[20, , ]) # Lets pick the 20th image
colnames(image) <- seq_len(ncol(image))
image$y <- seq_len(nrow(image))
image <- gather(image, "x", "value", -y)
image$x <- as.integer(image$x)

image %>% 
ggplot( aes(x,y, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "black", na.value = NA) +
  scale_y_reverse() +
  theme_minimal() +
  theme(panel.grid = element_blank())   +
  theme(aspect.ratio = 1) +
  xlab("") +
  ylab("")


# Note: The plot shows pixel values. To use these images in a CNN, they need to be scaled.

# 5.0 SCALE THE DATA -----

# Scale the image data to normalize pixel values between 0 and 1, 
# which is essential for effective training of neural networks.
# 255 is used because this is the maximum pixel value

train_images_scaled <- train_images / 255
test_images_scaled <- test_images / 255


# 6.0 STORE THE LABELS INTO A VECTOR AND VISUALIZE THE FIRST TEN IMAGES----

# Define class names corresponding to each label in the data set.

class_names = c('T-shirt/top',
                'Trouser',
                'Pullover',
                'Dress',
                'Coat',
                'Sandal',
                'Shirt',
                'Sneaker',
                'Bag',
                'Ankle boot')




# Function to plot a single image. This function will be used to visualize images
# from the data set, with corresponding labels.


plot_image <- function(img, label) {
  # Convert the image matrix to a data frame
  img_df <- as.data.frame(as.table(img))
  colnames(img_df) <- c("x", "y", "value")
  
  # Plot the image using ggplot2, with the label as the title.
  
  p <- ggplot(img_df, aes(x,y, fill = value)) +
       geom_tile() +
       scale_fill_gradient(low = "white", high = "black") +
       coord_fixed() +
       theme_void() +
       ggtitle(label)+
       theme(legend.position = "none")
  
  return(p)
}

# Generate and arrange plots for the first 10 images in a 5x2 grid.
# This helps in visually verifying that the data is correctly processed.

plots <- list()
for (i in 1:10) {
  img <- train_images_scaled[i, , ]
  img <- t(apply(img, 2, rev))
  label <- class_names[train_labels[i] + 1]
  plots[[i]] <- plot_image(img, label)
}

grid.arrange(grobs = plots, ncol = 5, nrow = 2)



# 7.0 BUILD THE CNN MODEL----------- 


# Define the CNN model using the Sequential API from Keras.

cnn_model <- keras_model_sequential() %>%
  
# First convolutional layer with 32 filters, 3x3 kernel, ReLU activation function.
# The input shape is specified as 28x28 with 1 channel (grayscale image)
 
  layer_conv_2d(filters = 32, kernel_size = c(3, 3), activation = 'relu', input_shape = c(28, 28, 1)) %>%
  
# MaxPooling layer to downsample the feature map by a factor of 2, reducing complexity.
  
  layer_max_pooling_2d(pool_size = c(2, 2)) %>%
  
# Second convolutional layer with 64 filters and a 3x3 kernel to learn more complex features.
  
  layer_conv_2d(filters = 64, kernel_size = c(3, 3), activation = 'relu') %>%
  
# Another MaxPooling layer to further downsample the feature map.
  
  layer_max_pooling_2d(pool_size = c(2, 2)) %>%
  
# Third convolutional layer with 64 filters and a 3x3 kernel to learn even deeper features.
  
  layer_conv_2d(filters = 64, kernel_size = c(3, 3), activation = 'relu') %>%
  
# Flatten the feature map to convert the 2D matrix into a 1D vector for the dense layers to then consider.
  
  layer_flatten() %>%
  
# Fully connected dense layer with 64 units, using ReLU activation for non-linearity(because the world is non-linear).
  
  layer_dense(units = 64, activation = 'relu') %>%
  
# Output layer with 10 units (one for each class), using softmax activation to output probabilities.
  
  layer_dense(units = 10, activation = 'softmax')

# Print the model summary to verify the architecture

summary(cnn_model)




# 8.0 COMPILE THE CNN MODEL------------

# Compile the CNN model with the Adam optimizer, sparse categorical cross entropy 
# loss function (appropriate for multi-class classification), and accuracy as a metric.
# Adam is a good optimizer (Adaptive Moment Estimation, is based on stochastic gradient descent).

cnn_model %>% compile(
  optimizer = 'adam',
  loss = 'sparse_categorical_crossentropy',
  metrics = c('accuracy')
)

# 9.0 TRAIN THE CNN MODEL------------

# Train the model on the training data set for 10 epochs with a batch size of 64.
# The training accuracy and loss are tracked to monitor the model's learning progress.

cnn_model %>% fit(train_images_scaled,
                  train_labels,
                  epochs = 10,
                  batch_size = 64,
                  shuffle = FALSE
                  )

# THE TRAINING ACCURACY IS: 94.1%, WITH A LOSS OF  16.3%
# Note: the Accuracy measures the correct overall classifications by the models for 
# both positive and negative examples.
# Thus: Accuracy = (True Positives + True Negatives)/(Positive + Negative)  

# 10.0 EVALUATE THE CNN MODEL----

# Evaluate the model on the test set to determine how well it generalizes to unseen data.

score <- cnn_model %>% evaluate(test_images_scaled, test_labels)

score %>% 
  view()

# The score on the test sample is 89.6% with a loss of 36%. 

# 11.0 MAKE PREDICTIONS FOR TEN IMAGES AND VISUALIZE THEM----

# Make predictions on the entire test set using the trained model

predictions <- cnn_model %>% predict(test_images_scaled)


# Extract the predicted class labels for the first 10 images.

predicted_labels <- apply(predictions[1:10, ], 1, which.max) - 1

# Create a data frame to compare the true labels with the predicted labels for the first 10 images.

df <- tibble(
  image_id = 1:10,
  true_label = test_labels[1:10],
  predicted_label = predicted_labels,
  correct = ifelse(predicted_labels == test_labels[1:10], "Correct", "Incorrect")
)

# Function to plot a single image with its true and predicted labels, highlighting correctness.

plot_image <- function(img, label, predicted, correct) {
  img_df <- as.data.frame(as.table(img))
  colnames(img_df) <- c("x", "y", "value")
  
  img_df %>% 
  ggplot(aes(as.numeric(x),as.numeric(y), fill = value)) +
    geom_tile() +
    scale_fill_gradient(low = "white", high = "black") +
    coord_fixed() +
    theme_void() +
    ggtitle(paste("True:", label, "| Pred:", predicted, "|", correct)) +
    theme(legend.position = "none", 
          plot.title = element_text(color = ifelse(correct == "Correct", "darkgreen", "darkred")))
}

# Plot the first 10 images with correct/incorrect predictions highlighted
plots <- map(1:10, function(i) {
  img <- test_images_scaled[i, , ]
  img <- t(apply(img, 2, rev))
  label <- class_names[test_labels[i] + 1]
  predicted <- class_names[predicted_labels[i] + 1]
  correct <- df$correct[i]
  plot_image(img, label, predicted, correct)
})

# Arrange the plots in a 5x2 grid to visualize the predictions.

grid.arrange(grobs = plots, ncol = 5, nrow = 2)


# 12.0 CHECKING ADDITIONAL METRICS ----------

# Calculate additional metrics such as precision, recall, and F1-score 
# to get a more comprehensive view of the model's performance.

# Predict on the entire test set

predicted_labels <- apply(predictions[, ], 1, which.max) - 1


# Create a data frame with the true and predicted labels
results <- tibble(
  truth = factor(test_labels, levels = 0:9),
  prediction = factor(predicted_labels, levels = 0:9)
)


# Create a data frame with the true and predicted labelscs


precision_score <- precision(results, truth, prediction)

recall_score <- recall(results, truth, prediction)

f1_score <- f_meas(results, truth, prediction)

# Print the results to summarize the model's performance across different metrics.

print(precision_score)
print(recall_score)
print(f1_score)


# 13.0 SUMMARY----

# With a Precision of 0.900: My  model is highly accurate in its positive predictions. i.e. 
# 90% of the predicted positives are actually positives

# With a Recall (also known as sensitivity) of 0.896: My model is also highly 
# effective at identifying actual positives.It is the predictive power of positive cases.

# With an F1-Score of 0.896: My model maintains a good balance between precision and recall, 
# indicating it performs well overall in classifying the test set. It is actually a harmonic mean

# Overall, these metrics indicate that the model performs well on the FashionMNIST dataset, 
# achieving strong classification results that balance precision and recall effectively.

# 14.0 Recommendations----

# To improve model accuracy I could consider the following
# a) Increase the model complexity by for example adding more convolutional layers 
# to capture additional patterns from the images 

# b) Consider an ensemble approach to see if different CNN models can work together
# C) Adjust and experiment with hyperparameters

