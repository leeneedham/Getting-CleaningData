Getting and Cleaning Data Project
====================

Project for Coursera Getting and Cleaning Data class

This folder contains a file of the run_analysis.R file which contains the R script for reading in the Smartphone experimental data file and creating a new tidy data set.  

The tidy data set was uploaded as a text file on the Coursera website for this class. The "tidyDataSmart.text" file was created as a tab delimited file (sep = "\t") using the write.table function.


### Explanation of the run_analysis.R script

NOTE: The script requires the plyr package.

The UCI HAR Dataset file made available for this project through Coursera is available on line at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. (Note - both  "inertial signals" folders removed since these do not need to be processed.)

The test and the train folders in the UCI HAR Dataset file each contained 3 files related to this project:
- subject_test.txt or subject_train.txt - Each row identifies the subject who performed the activity for observation. Its range is from 1 to 30.
- X_test.txt or X_train.txt - Test or training set of experimental feature data
- y_test.txt or y_train.txt - Test or training labels of experimental feature data

From the original README file for this dataset, these separate "test" and "train" files were derived by "randomly partitioning [the original complete experimental dataset] into two sets, where 70% of the [original data] was selected for generating the training data and 30% the test data."  

Two additional files included were:
- features.txt - List of all features.
- activity_labels.txt - Links the activity class labels with their activity name

These 8 files were downloaded to the working directory and, from there, read into R using read.table:
subject_test <- read.table("subject_test.txt", quote = "\"")
X_test <- read.table("X_test.txt", quote = "\"")
y_test <- read.table("y_test.txt", quote = "\"")
subject_train <- read.table("subject_train.txt", quote = "\"")
X_train <- read.table("X_train.txt", quote = "\"")
y_train <- read.table("y_train.txt", quote = "\"")
features <- read.table("features.txt", quote = "\"", colClasses = "character")
activity_labels <- read.table("activity_labels.txt", quote = "\"", colClasses = "character")
dim(activity_labels)
# [1] 6 2
str(activity_labels)
activity_labels

####### 

# PROJECT PART 1: Merge the training and the test sets to create one data set.

# Concatenate the 3 test files together using cbind:
test1 <- cbind(subject_test, y_test)
test2 <- cbind(test1, X_test)

# Concatenate the 3 train files together using cbind:
train1 <- cbind(subject_train, y_train)
train2 <- cbind(train1, X_train)

# Concatenate the test and train files together using rbind:
complete <- rbind(test2, train2)

This resulted in a complete dataset containing 10299 observations and 563 variables.

#######

## PROJECT PART 2: Extract only the measurements on the mean and standard deviation for each measurement. 

In preparation for further processing and subsetting of the complete dataset,
the appropriate activity and column names were added to the dataset.

Apply column names
(1) Columns 1 and 2 named "subject" and "activity", respectively
(2) Columns 3:563 (the remainder of the columns, 561 columns) named using the values in the second column of the "features" dataframe:

colnames(complete)[1:2] <- c("subject", "activity")
colnames(complete)[3:563] <- features[[2]]

According to a paper (Anguita, D., et al. A Public Domain Dataset for Human Activity Recognition Using Smartphones https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf) describing the dataset we are using, the experimental dataset is comprised of data collected from Smartphones that recorded aspects of "Activities of Daily Living" captured by the smartphone's accelerometer and gyroscope. Two general classes of data were collected: Time and Frequency Data.  The Time data was collected along 10 separate domains and were subsequently analyzed to produce a series of "features", many of which had separate values in three dimensions.  The mean value and standard deviation were calculated for each of these features. These values appear in the features list with names that contain "mean()" and "std()".  Additional features derived from the Frequency Data were analyzed.  While one of the series of Time features includes "mean" in the name, this is actually a determination of the weighted average of the frequency signal, and is therefore not a classical "mean".

Therefore, using the "grepl" function, the complete activity database was subset according to whether the column name contained "mean()" or std().  Note that when using grel, the escape character "\\" needed to be used so that the regular expression "(" and ")" would be recognized:

complete_sub <- complete[, grepl("subject|activity|mean\\(\\)|std\\(\\)", names(complete))]

This resulted in a dataframe containing 10299 observations and 68 variables.

######

## PROJECT PART 3: Use descriptive activity names to name the activities in the data set 

Using the "mapvalues" function from the plyr package, I renamed the "activity" numerical codes with names according to the activity_labels dataframe, substituting lower case for upper case.

require(plyr)
complete_sub$activity <- mapvalues(complete_sub$activity, c(1:6), c("walking", "walkingUpstairs", "walkingDownstairs", "sitting", "standing", "laying"), warn_missing = TRUE)

#### Original incorrect code:
complete$activity <- mapvalues(complete$activity, c(1:6), c("walking", "walkingUpstairs", "walkingDownstairs", "sitting", "standing", "laying"), warn_missing = TRUE)
#### NOTE:  
In the uploaded "tidy" data set, the activity names were inadvertantly mapped to the older "complete" dataset as above, and therefore were not correctly mapped to the "complete_sub" dataset which was further processed and uploaded. The corrected code, and the corrected "tidyDataSmart.txt" text file, is the version on GitHub.

######

## PROJECT PART 4: Appropriately label the data set with descriptive variable names. 

# In the first step of PROJECT PART 2, I applied column names for the 561 columns of feature data (columns 3:563) using the values in the second column of the features dataframe.  (Subsequently, only the columns containing "mean()" and "std()" in the column name were retained.)  These column, or variable, names are descriptive, however, they contain the characters "-" "(", and ")" (e.g. "tBodyAcc-mean()-X"), which can interfere with the interpretation of function calls in R. Therefore, the "-", "(", and ")" characters should be removed. Several additional "style" changes to the variable names were considered. According to Rasmus Baath in "The State of Naming Conventions in R" (http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf), there are no official naming conventions for the R programming language.  Several  well known "R Style Guides" propose different naming conventions for variable names (e.g. "period.separated", "underscore_separated", "lowerCamelCase", "alllowercase").  However, the use of "lowerCamelCase" for variable names is common in the packages on Comprehensive R Archive Network (CRAN).  Therefore, variable names were be transformed as follows:
"tBodyAcc-mean()-X"   -> "tBodyAccMeanX"
"tGravityAcc-std()-Y" -> "tGravityAccStdY"
"tBodyAccJerk-mean()-Z"   -> "tBodyAccJerkMeanZ"
In order to accomplish this, mean() and std() were identified in the current variable names and the first letter of the string was changed to a Capital case using the "chartr" function.  Then "-", "(" and ")" were removed using the "gsub" and "sub" functions. 

names(complete_sub) <- chartr("mean\\(\\)", "Mean\\(\\)", names(complete_sub))
names(complete_sub) <- chartr("std\\(\\)", "Std\\(\\)", names(complete_sub))
names(complete_sub) <- gsub("-", "", names(complete_sub))
names(complete_sub) <- sub("\\(", "", names(complete_sub))
names(complete_sub) <- sub("\\)", "", names(complete_sub))
names(complete_sub)[1] <- "subject"

#####

## PROJECT PART 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.

I used ddply from the plyr Package to split the mean and std subset dataframe
observations by "activity" and by "subject", to apply the 'average' function to each of the feature columns and to return a dataframe including the subject, activity and each of the each of the averaged feature columns.

library(plyr)
tidy <- ddply(complete_sub, c("subject", "activity"), summarize, 
              tBodyAccMeanXMean             = mean(tBodyAccMeanX),
              tBodyAccMeanYMean             = mean(tBodyAccMeanY),
              tBodyAccMeanZMean             = mean(tBodyAccMeanZ),
              tBodyAccStdXMean              = mean(tBodyAccStdX),
              tBodyAccStdYMean              = mean(tBodyAccStdY),
              tBodyAccStdZMean              = mean(tBodyAccStdZ),
              tGravityAccMeanXMean          = mean(tGravityAccMeanX),
              tGravityAccMeanYMean          = mean(tGravityAccMeanY),
              tGravityAccMeanZMean          = mean(tGravityAccMeanZ),
              tGravityAccStdXMean           = mean(tGravityAccStdX),
              tGravityAccStdYMean           = mean(tGravityAccStdY),
              tGravityAccStdZMean           = mean(tGravityAccStdZ),
              tBodyAccJerkMeanXMean         = mean(tBodyAccJerkMeanX),
              tBodyAccJerkMeanYMean         = mean(tBodyAccJerkMeanY),
              tBodyAccJerkMeanZMean         = mean(tBodyAccJerkMeanZ),
              tBodyAccJerkStdXMean          = mean(tBodyAccJerkStdX),
              tBodyAccJerkStdYMean          = mean(tBodyAccJerkStdY),
              tBodyAccJerkStdZMean          = mean(tBodyAccJerkStdZ),
              tBodyGyroMeanXMean            = mean(tBodyGyroMeanX),
              tBodyGyroMeanYMean            = mean(tBodyGyroMeanY),
              tBodyGyroMeanZMean            = mean(tBodyGyroMeanZ),
              tBodyGyroStdXMean             = mean(tBodyGyroStdX),
              tBodyGyroStdYMean             = mean(tBodyGyroStdY),
              tBodyGyroStdZMean             = mean(tBodyGyroStdZ),
              tBodyGyroJerkMeanXMean        = mean(tBodyGyroJerkMeanX),
              tBodyGyroJerkMeanYMean        = mean(tBodyGyroJerkMeanY),
              tBodyGyroJerkMeanZMean        = mean(tBodyGyroJerkMeanZ),
              tBodyGyroJerkStdXMean         = mean(tBodyGyroJerkStdX),
              tBodyGyroJerkStdYMean         = mean(tBodyGyroJerkStdY),
              tBodyGyroJerkStdZMean         = mean(tBodyGyroJerkStdZ),
              tBodyAccMagMeanMean           = mean(tBodyAccMagMean),
              tBodyAccMagStdMean            = mean(tBodyAccMagStd),
              tGravityAccMagMeanMean        = mean(tGravityAccMagMean),
              tGravityAccMagStdMean         = mean(tGravityAccMagStd),
              tBodyAccJerkMagMeanMean       = mean(tBodyAccJerkMagMean),
              tBodyAccJerkMagStdMean        = mean(tBodyAccJerkMagStd),
              tBodyGyroMagMeanMean          = mean(tBodyGyroMagMean),
              tBodyGyroMagStdMean           = mean(tBodyGyroMagStd),
              tBodyGyroJerkMagMeanMean      = mean(tBodyGyroJerkMagMean),
              tBodyGyroJerkMagStdMean       = mean(tBodyGyroJerkMagStd),
              fBodyAccMeanXMean             = mean(fBodyAccMeanX),
              fBodyAccMeanYMean             = mean(fBodyAccMeanY),
              fBodyAccMeanZMean             = mean(fBodyAccMeanZ),
              fBodyAccStdXMean              = mean(fBodyAccStdX),
              fBodyAccStdYMean              = mean(fBodyAccStdY),
              fBodyAccStdZMean              = mean(fBodyAccStdZ),
              fBodyAccJerkMeanXMean         = mean(fBodyAccJerkMeanX),
              fBodyAccJerkMeanYMean         = mean(fBodyAccJerkMeanY),
              fBodyAccJerkMeanZMean         = mean(fBodyAccJerkMeanZ),
              fBodyAccJerkStdXMean          = mean(fBodyAccJerkStdX),
              fBodyAccJerkStdYMean          = mean(fBodyAccJerkStdY),
              fBodyAccJerkStdZMean          = mean(fBodyAccJerkStdZ),
              fBodyGyroMeanXMean            = mean(fBodyGyroMeanX),
              fBodyGyroMeanYMean            = mean(fBodyGyroMeanY),
              fBodyGyroMeanZMean            = mean(fBodyGyroMeanZ),
              fBodyGyroStdXMean             = mean(fBodyGyroStdX),
              fBodyGyroStdYMean             = mean(fBodyGyroStdY),
              fBodyGyroStdZMean             = mean(fBodyGyroStdZ),
              fBodyAccMagMeanMean           = mean(fBodyAccMagMean),
              fBodyAccMagStdMean            = mean(fBodyAccMagStd),
              fBodyBodyAccJerkMagMeanMean   = mean(fBodyBodyAccJerkMagMean),
              fBodyBodyAccJerkMagStdMean    = mean(fBodyBodyAccJerkMagStd),
              fBodyBodyGyroMagMeanMean      = mean(fBodyBodyGyroMagMean),
              fBodyBodyGyroMagStdMean       = mean(fBodyBodyGyroMagStd),
              fBodyBodyGyroJerkMagMeanMean  = mean(fBodyBodyGyroJerkMagMean),
              fBodyBodyGyroJerkMagStdMean   = mean(fBodyBodyGyroJerkMagStd))
                  
This resulted in a tidy dataset consisting of 180 observations and 68 variables.
# [1] 180  68
str(tidy)
