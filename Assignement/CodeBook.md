---
title: "CodeBook"
author: "AxelTray"
date: "28 février 2016"
output: html_document
---

#Study design

##Source of the data

The dataset has its origins from the "Human Activity Recognition Using Smartphones Data Set".

The raw data is available on the following website :  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The description from the authors of the dataset can be find on the following website :  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


##Experimental study design used
        
The R script "run_analysis.R"" performs the following transformations to tidy up the dataset:

* Step 1. Merging the training and the test sets to create one data set  
The temporary variable **merged_data** contains both the testing and training data.

* Step 2. Extracting only the measurements on the mean and standard deviation for each measurement 
The temporary variable **features** first contains the name of the variable studied in the raw datasets. Since the guidelines are to only focus on the mean and standard deviation of each measurements, the grep function is used to only extract the namess containing the strings "mean()" or "std()". A second temporary variable containing both the testing and training data, but focusing on the mean and standard deviation of each measurement is created : **merged_data_means_std**.


* Step 3. Appropriately labeling the data set with descriptive variable names
In order to create acceptable column names for the data, **features** is slightly modified. First of all, out-of-scope variables are left behind. Then, special characters are excluded : "-" are replaced by "_" and "()" are simply deleted.
The transformed **features** variable, **features_means_std** is used as a vector of column names for the **merged_data_means_std** data set.


* Step 4. Using descriptive activity names to name the activities in the data set
In order to link the observations with an activity, the first step is to create a link between the activity Id and its signification. A function *findActivity* is created : its input is the activity Id and it looks in the **activity_labels** table for a match to convert it into an activity name.  
The function is applied on all the training and testing activity Ids and the results are saved into the variable **activity_retreated**.  
The final **tidy_data** variable is created combining the **merged_data_means_std** data set and the **activity_retreated** labels.

* Step 5. From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject  
Subjects from both training and testing sets are merged in the **subject** variable.  
The function splits is used to split the observations either by subject or by activity. The variables **meanVariableBySubject** and **meanVariableByActivity** are lists that contains the mean of the studied measurements either by subject or by activity.


Finally, the variables are written into the workind directory.



#Code Book

You may refer to the README.txt file in this repository and the features.txt file in the original dataset to understand more precisely the variable selection fot the resulting dataset.

The variables selected come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

Following the Coursera guidelines, I have selected the data dealing with mean or std of these variables :

* tBodyAcc-XYZ  
* tGravityAcc-XYZ  
* tBodyAccJerk-XYZ  
* tBodyGyro-XYZ  
* tBodyGyroJerk-XYZ  
* tBodyAccMag  
* tGravityAccMag  
* tBodyAccJerkMag  
* tBodyGyroMag  
* tBodyGyroJerkMag  
* fBodyAcc-XYZ  
* fBodyAccJerk-XYZ  
* fBodyGyro-XYZ  
* fBodyAccMag  
* fBodyAccJerkMag  
* fBodyGyroMag  
* fBodyGyroJerkMag  