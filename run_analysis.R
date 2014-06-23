## Project_GCD: run_analysis.R

subject_test <- read.table("subject_test.txt", quote = "\"")
X_test <- read.table("X_test.txt", quote = "\"")
y_test <- read.table("y_test.txt", quote = "\"")

subject_train <- read.table("subject_train.txt", quote = "\"")
X_train <- read.table("X_train.txt", quote = "\"")
y_train <- read.table("y_train.txt", quote = "\"")

features <- read.table("features.txt", quote = "\"", colClasses = "character")
activity_labels <- read.table("activity_labels.txt", quote = "\"", colClasses = "character")

test1 <- cbind(subject_test, y_test)
test2 <- cbind(test1, X_test)

train1 <- cbind(subject_train, y_train)
train2 <- cbind(train1, X_train)

complete <- rbind(test2, train2)

colnames(complete)[1:2] <- c("subject", "activity")
colnames(complete)[3:563] <- features[[2]]

complete_sub <- complete[, grepl("subject|activity|mean\\(\\)|std\\(\\)", names(complete))]

require(plyr)
complete_sub$activity <- mapvalues(complete_sub$activity, c(1:6), c("walking", "walkingUpstairs", "walkingDownstairs", "sitting", "standing", "laying"), warn_missing = TRUE)

names(complete_sub) <- chartr("mean\\(\\)", "Mean\\(\\)", names(complete_sub))
names(complete_sub) <- chartr("std\\(\\)", "Std\\(\\)", names(complete_sub))
names(complete_sub) <- gsub("-", "", names(complete_sub))
names(complete_sub) <- sub("\\(", "", names(complete_sub))
names(complete_sub) <- sub("\\)", "", names(complete_sub))
names(complete_sub)[1] <- "subject"

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

