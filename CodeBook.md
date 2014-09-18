Code Book
=========
This Code Book describes the variables, the data, and any transformations or work that performed to clean up the data 

# Data Source

The data can be found at the following url:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Dataset Description
(source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% 
the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal,
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a 
filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating 
variables from the time and frequency domain. 

# The Data files
(source: README.txt)
The dataset includes the following files:

-‘README.txt’
-‘features_info.txt’: Shows information about the variables used on the feature vector.
-‘features.txt’: List of all features or measurements recorded in the train and test data sets
-‘activity_labels.txt’: definition train and test activities
-‘train/X_train.txt’: Training measurements data set.
-‘train/y_train.txt’: Training actvitiy labels.
-‘test/X_test.txt’: Test measurements data set.
-‘test/y_test.txt’: Test activity labels.

The following files are available for the train and test data. Their descriptions are equivalent.

-‘train/subject_train.txt’: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
-‘train/Inertial Signals/total_acc_x_train.txt’: The acceleration signal from the smartphone accelerometer X axis in standard gravity units ‘g’. Every row shows a 128 element vector. The same description applies for the ‘total_acc_x_train.txt’ and ‘total_acc_z_train.txt’ files for the Y and Z axis.
-‘train/Inertial Signals/body_acc_x_train.txt’: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
-‘train/Inertial Signals/body_gyro_x_train.txt’: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

# Data Transformation 

After the data has been downloaded and unzipped, the following transformations were performed:

- Merge  the training and the test sets to create one data set.
- Extract the measurements on the mean and standard deviation for each measurement (features with mean or std as their labels)
- Use descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable (which are means and standard deviations from the second step above) for each activity and each subject.
- The resulting tidy data is written to an output file, tidyAverages.txt.

# Transformation Implementation

The script run_analysis.R is created to perform the required transformation.  The script does the following:

- downloads the project data archive from the data link givin
- unzips all the files from the archive in the current working directory
- loads required the R libraries
- reads the activity_labels.txt file and creates the activity_labels data frame
- reads the features.txt file and creates the features data frame
- reads the files in train directory and creates the train data frame
- reads the files in the test directory and creates the test data frame
- merges train and test data, and label the columns with the activity_labels and features
- extracts measurements on mean or standard deviation
- creates the tidyAverages.txt with the average of each variable (which are the features with mean and std as their labels from step above) for each activity and each subject
