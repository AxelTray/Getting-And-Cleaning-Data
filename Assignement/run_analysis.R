#This script is designed to prepare tidy data collected from the the 
#accelerometers from the Samsung Galaxy S smartphone, that can be used for later
#analysis in the JHU Data Science Coursera programm.

#The script reproduces the following steps :
#       Step 1. Merging the training and the test sets to create one data set
#       Step 2. Extracting only the measurements on the mean and standard
#               deviation for each measurement
#       Step 3. Appropriately labeling the data set with descriptive variable
#               names
#       Step 4. Using descriptive activity names to name the activities in the
#               data set
#       Step 5. From the data set in step 4, creating a second, independent tidy
#               data set with the average of each variable for each activity and
#               each subject

#This script assumes that the Dataset zip file has been previously extracted on
#the working directory under the name"UCI HAR Dataset".

library(dplyr) #dplyr package is used to better tidy raw data


##Step 0. Reading data from the Data Set
testing_set <- read.table("UCI HAR Dataset/test/X_test.txt")
testing_set_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
testing_set_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
training_set <- read.table("UCI HAR Dataset/train/X_train.txt")
training_set_activity <-read.table("UCI HAR Dataset/train/y_train.txt")
training_set_subject <-read.table("UCI HAR Dataset/train/subject_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#Step 1. Merging the training and the test sets to create one data set
merged_data <- rbind(testing_set,training_set)

#Step 2. Extracting only the measurements on the mean and standard deviation
#for each measurement
features <- as.character(features$V2)
mean_pos <- grep("mean[:(:][:):]",t(features))
std_pos <- grep("std[:(:][:):]",t(features))
kept_pos <- sort(c(mean_pos,std_pos))
merged_data_means_std <- select(merged_data,kept_pos)

#Step 3. Appropriately labeling the data set with descriptive variable names
features_means_std <- features[kept_pos]
features_means_std <- gsub("-","_",features_means_std)
features_means_std <- gsub("[()]","",features_means_std)
names(merged_data_means_std) <- features_means_std

#Step 4. Using descriptive activity names to name the activities in the data set
names(activity_labels) <- c("ref","name")
findActivity <- function(num) {
        #The function will return the name of the activity based on its ref. nb
        as.character(activity_labels$name[grepl(num,activity_labels$ref)])
}
activity<- rbind(testing_set_activity,training_set_activity)
activity_retreated <- data.frame(unlist(lapply(activity$V1,findActivity)))
names(activity_retreated) <- "activity"
tidy_data <- cbind(merged_data_means_std,activity_retreated)


#Step 5. From the data set in step 4, creating a second, independent tidy data
#set with the average of each variable for each activity and each subject
subject <- rbind(testing_set_subject,training_set_subject)
names(subject) <- "subject"

meanVariableBySubject <- split(merged_data_means_std,subject)
meanVariableBySubject <- lapply(meanVariableBySubject, colMeans)

meanVariableByActivity <- split(merged_data_means_std,activity_retreated)
meanVariableByActivity <- lapply(meanVariableByActivity, colMeans)

write.csv(tidy_data,"tidy_data.csv")
write.csv(meanVariableBySubject,"meanVariableBySubject.csv")
write.csv(meanVariableByActivity,"meanVariableByActivity.csv")
