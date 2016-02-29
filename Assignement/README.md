---
title: "Getting and Cleaning Data: Course Project"
author: "AxelTray"
date: "28 février 2016"
output: html_document
---

##Introduction
This repository contains the files for the final project of the Coursera "Getting and Cleaning Data"

##Description of the script
The features (561 of them) are unlabeled and can be found in the x_test.txt. The activity labels are in the y_test.txt file. The test subjects are in the subject_test.txt file.

The same holds for the training set.

##Description of the tidy dataset
The "run_analysis.R" script has been designed to merge the training and testing sets together. This script assumes that the Dataset zip file has been previously extracted on the working directory under the name"UCI HAR Dataset".

The script reproduces the following steps :

* Step 1. Merging the training and the test sets to create one data set  
* Step 2. Extracting only the measurements on the mean and standard deviation for each measurement  
* Step 3. Appropriately labeling the data set with descriptive variable names  
* Step 4. Using descriptive activity names to name the activities in the data set  
* Step 5. From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject

##Description of the Code Book
The markdown "CodeBook.md" file describes the transformation performed in the raw data in order to obtain the resulting data and variables.


