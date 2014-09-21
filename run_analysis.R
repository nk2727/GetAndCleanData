#
# Getting and Cleaning Data Course Project
# 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of 
#   each variable for each activity and each subject.
#
#
# load required libraries
#
library(data.table)
library(dplyr)
library(reshape2)

#
# The data for this project has been downloaded and extracted locally into the basedir directory
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# download the zip file and unzip it in the current working directory
#
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
zipfile <- basename(fileUrl)
workdir <- getwd()

download.file(fileUrl, zipfile)
unzip(zipfile, exdir=workdir)

#
# The files are unzipped to here:
#
basedir <- "UCI HAR Dataset"

#
# read definition data 
# 
activity_labels <- read.table(paste0(basedir,"/activity_labels.txt"),header=FALSE, stringsAsFactors=FALSE)
features <- read.table(paste0(basedir,"/features.txt"),header=FALSE, stringsAsFactors=FALSE)

#
# read training data
#
subject_train <- read.table(paste0(basedir,"/train/subject_train.txt"),header=FALSE, stringsAsFactors=FALSE)
X_train <- read.table(paste0(basedir,"/train/X_train.txt"),header=FALSE, stringsAsFactors=FALSE)
y_train <- read.table(paste0(basedir,"/train/y_train.txt"),header=FALSE, stringsAsFactors=FALSE)

#
# create the training data frame:
# 1) create an activity label for each activity 
# 2) cbind the activity labels, subjects who performed the training activities, and training data set
#   
train_activity <- data.frame( Activity = factor(y_train$V1, labels = activity_labels$V2))
train_data <- cbind(train_activity, subject_train, X_train)

#
# read test data
#
subject_test <- read.table(paste0(basedir,"/test/subject_test.txt"),header=FALSE, stringsAsFactors=FALSE)
X_test <- read.table(paste0(basedir,"/test/X_test.txt"),header=FALSE, stringsAsFactors=FALSE)
y_test  <- read.table(paste0(basedir,"/test/y_test.txt"),header=FALSE, stringsAsFactors=FALSE)

#
# create the test data frame: 
# 1) create an activity label for each activity 
# 2) cbinding the activity labels, subjects who performed the test activities, and test data set
# 
test_activity <- data.frame( Activity = factor(y_test$V1, labels = activity_labels$V2))
test_data <- cbind(test_activity, subject_test, X_test)

#
# Merge the training and  test sets to create one data set
#
merged_data <- rbind(test_data, train_data)

#
# set the decriptive column labels on the merged data
#
names(merged_data) <- c("Activity", "Subject", features[,2])

# 
# clean up the data frames no longer needed to avoid possible confusion
#
rm(activity_labels)
rm(train_activity, subject_train, X_train, y_train,train_data)
rm(test_activity, subject_test, X_test, y_test,test_data)

#
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#
selected_measurements <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
tidy_data <- merged_data[c("Activity", "Subject", selected_measurements)]

#
# Create an independent tidy data set containing the average of each variable for each activity and each subject
# Using melt to transform the merged_data into one row per Activity-Subject-Feature-value
#> head(melt_data)
#  Activity Subject          variable     value
#1 STANDING       2 tBodyAcc-mean()-X 0.2571778
#2 STANDING       2 tBodyAcc-mean()-X 0.2860267
#3 STANDING       2 tBodyAcc-mean()-X 0.2754848
#
molten_data <-  melt(merged_data,id.vars=c("Activity", "Subject"), measured.vars=selected_measurements)

#
# use cast to calculate averages for each activity performed by each subject
#
tidy_averages <-dcast(molten_data, Activity+Subject~variable, mean)

#
# write the tidy-averages to a file
#
write.table(tidy_averages, file="tidyAverages.txt", row.names=FALSE)
