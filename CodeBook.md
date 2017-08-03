========== Code Book for Tidied UCI HAR Dataset ==========

The scripts contained in this repository function on the dataset found in this zipped
file:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Further information can be found within those documents and also at
https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data was obtained through experiements with a group of 30 volunteers in an age bracket of
19-48 years. Each person performed six activities while wearing a Samsung Galaxy S II smartphone
on the waist.

Data were gathered from the accelerometer and gyroscope using 3-axial linear acceleration and
3-axial angular velocity at a constant 50Hz. These data were aggregated into 128 readings per
window to give the 10299 total datapoints in the tidy.data data frame calculated with this script.

Next, the tidied data frame is used to calculate mean values for each subject and activity. This
data is shown in the measurement.averages data frame.

========== Parameter Descriptions ==========

18 measured variables using a combination of
{
Acceleration - The subject body acceleration measured by the accelerometer
Gravity - The influence of gravity measured by the accelerometer
Gyro - The angular velocity measured by the gyroscope

X, Y, Z - The axis of measurement

mean or std - The mean or standard deviation of the given subset of measurements. That is,
              for any given 128-measurement window
}

subject - the anonymized number given to a single test subject

activity - one of: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING
           This is the activity being performed by the subject while the measurements are taken