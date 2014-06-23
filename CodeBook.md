Getting and Cleaning Data Project
====================

### Codebook

This is the codebook for the variables in the "tidyDataSmart.txt" representing the final tidy dataset from the manipulation of the UCI HAR Dataset files and following the scipt in the run_analysis.R code. 

The original dataset and documentation is available at:  
The UCI HAR Dataset file made available for this project through Coursera is available on line at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphone

According to a paper (Anguita, D., et al. A Public Domain Dataset for Human Activity Recognition Using Smartphones https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf) describing the dataset we are using, the experimental dataset is comprised of data collected from Smartphones that recorded aspects of "Activities of Daily Living" captured by the smartphone's accelerometer and gyroscope. Two general classes of data were collected: Time and Frequency Data.  The Time data was collected along 10 separate domains and were subsequently analyzed to produce a series of "features", many of which had separate values in three dimensions.  The mean value and standard deviation were calculated for each of these features. These values appear in the features list with names that contain "mean()" and "std()".  Additional features derived from the Frequency Data were analyzed.  While one of the series of Time features includes "mean" in the name, this is actually a determination of the weighted average of the frequency signal, and is therefore not a classical "mean".  The goal of this project was to programmatically calculate the average of the mean and standard deviation of each set of recorded variables for each activity and each subject.


#### Observational Units

- subject - coded as 1 - 30 (integers) representing one of 30 volunteers within an age bracket of 19-48 years.  Each volunteer participated in multiple runs of several activities. 

- activity - six Activities of Daily Living" coded as characters:

"walking" - Walking

"walkingUpstairs" - Walking Upstairs

"walkingDownstairs" - Walking Downstairs

"sitting" - Sitting

"standing" - Standing

"laying" - Laying


#### Variables

The variables in this dataset of the averages of the means and standard deviations for trials recording aspects of "Activities of Daily Living" captured by the smartphone's accelerometer and gyroscope. The Time Data was analyzed in this dataset.  The Time data was collected along 10 separate domains and were subsequently analyzed to produce a series of "features", many of which had separate values in three dimensions.  The mean value and standard deviation were calculated for each of these features. 

tBodyAccMeanXMean

tBodyAccMeanYMean

tBodyAccMeanZMean

tBodyAccStdXMean

tBodyAccStdYMean

tBodyAccStdZMean

tGravityAccMeanXMean

tGravityAccMeanYMean

tGravityAccMeanZMean

tGravityAccStdXMean

tGravityAccStdYMean

tGravityAccStdZMean

tBodyAccJerkMeanXMean

tBodyAccJerkMeanYMean

tBodyAccJerkMeanZMean

tBodyAccJerkStdXMean

tBodyAccJerkStdYMean

tBodyAccJerkStdZMean

tBodyGyroMeanXMean

tBodyGyroMeanYMean

tBodyGyroMeanZMean

tBodyGyroStdXMean

tBodyGyroStdYMean

tBodyGyroStdZMean

tBodyGyroJerkMeanXMean

tBodyGyroJerkMeanYMean

tBodyGyroJerkMeanZMean

tBodyGyroJerkStdXMean

tBodyGyroJerkStdYMean

tBodyGyroJerkStdZMean

tBodyAccMagMeanMean

tBodyAccMagStdMean

tGravityAccMagMeanMean

tGravityAccMagStdMean

tBodyAccJerkMagMeanMean

tBodyAccJerkMagStdMean

tBodyGyroMagMeanMean

tBodyGyroMagStdMean

tBodyGyroJerkMagMeanMean

tBodyGyroJerkMagStdMean

fBodyAccMeanXMean

fBodyAccMeanYMean

fBodyAccMeanZMean

fBodyAccStdXMean

fBodyAccStdYMean

fBodyAccStdZMean

fBodyAccJerkMeanXMean

fBodyAccJerkMeanYMean

fBodyAccJerkMeanZMean

fBodyAccJerkStdXMean

fBodyAccJerkStdYMean

fBodyAccJerkStdZMean

fBodyGyroMeanXMean

fBodyGyroMeanYMean

fBodyGyroMeanZMean

fBodyGyroStdXMean

fBodyGyroStdYMean

fBodyGyroStdZMean

fBodyAccMagMeanMean

fBodyAccMagStdMean

fBodyBodyAccJerkMagMeanMean

fBodyBodyAccJerkMagStdMean

fBodyBodyGyroMagMeanMean

fBodyBodyGyroMagStdMean

fBodyBodyGyroJerkMagMeanMean

fBodyBodyGyroJerkMagStdMean

