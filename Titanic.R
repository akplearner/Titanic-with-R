## .....IMPORTING DATA AND ANALYZING IT.....

# Import the training set: train
train_url <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv"
train <- read.csv(train_url)

# Import the testing set: test
test_url <-"http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"
test <- read.csv(test_url)

# Print train and test to the console
train
test

# Your train and test set are still loaded
str(train)
str(test)

# Survival rates in absolute numbers
table(train$Survived) 

# Survival rates in proportions 
prop.table(table(train$Survived))

# Two-way comparison: Sex and Survived
table(train$Sex, train$Survived)

# Two-way comparison: row-wise proportions
prop.table(table(train$Sex,train$Survived),1)

# Your train and test set are still loaded in
str(train)
str(test)

# Create the column child, and indicate whether child or no child
train$Child <- NA
train$Child[train$Age <18] <- 1
train$Child[train$Age >=18] <- 0



# Two-way comparison
prop.table(table(train$Child,train$Survived),1)

# Your train and test set are still loaded in
str(train)
str(test)

# Copy of test
test_one <- test

# Initialize a Survived column to 0
test_one$Survived<-0

# Set Survived to 1 if Sex equals "female"
test_one$Survived[test_one$Sex == "female"]<-1
test_one$Survived[test_one$Sex == "male"]<-0


## .....CREATING A DECISION TREE.....

# Your train and test set are still loaded in
str(train)
str(test)

# Build the decision tree
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

# Visualize the decision tree using plot() and text()
plot(my_tree_two)
text(my_tree_two)

# Load in the packages to build a fancy plot
library(rattle) #install.packages('rattle')
library(rpart.plot)#install.packages('rpart.plot')
library(RColorBrewer)


# Time to plot your fancy tree
fancyRpartPlot(my_tree_two)


## .....PREDICTING AND SETUP FOR SUBMISSION ON KAGGLE.....
# my_tree_two and test are  available in the workspace
my_tree_two
test

# Make predictions on the test set
my_prediction <- predict(my_tree_two, newdata = test, type = "class")

# Finish the data.frame() call
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Use nrow() on my_solution
nrow(my_solution)

# Finish the write.csv() call
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)
