#' Tidying the UCI HAR Dataset
#' 
#' You can use run_analysis when the UCI HAR Dataset folder is
#' present in the current working directory. The zip file is 
#' available at 
#' https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#' It also must be unzipped.
#' 
#' The script requires no other parameters, though it could be extended
#' to allow the user to point at the UCI HAR Dataset folder, which would
#' allow for a more flexible use. This extension is left for future users.

#' If the dataset is not present, the script will fail. The assumption
#' is made that the folder hasn't changed names and that the files haven't been
#' altered.
if(!dir.exists("UCI HAR Dataset")) {
    stop("run_analysis requires the UCI HAR Dataset 
         in the current working directory")
}

#' dplyr is required for data frame management
library(dplyr)

#' get_set does the heavy lifting of bringing in the data and cleaning it up.
#' 
#' Using the given names: x is the dataset of derived data from the raw data 
#' within the Inertial Signals folders. The x data is then labelled with the 
#' labels available from features.txt. Several names are duplicated which are 
#' subsequently filtered out. Since we are only interested in the means and
#' standard deviations of the measured data, that gives us three measurements
#' (body acceleration, gravity acceleration, and gyroscopic acceleration), 
#' three axes (X, Y, Z), and two measurements (mean and standard deviation).
#' These eighteen columns are extracted from the dataset. Then they are renamed
#' with names that match R column naming conventions. Next, subjects are matched
#' to their tests by appending a column from the appropriate subject_file. 
#' Finally, activity labels are appended by matching the numeric labels given in
#' the y_file to the character labels given in activity_labels.txt.
get_set <- function(test_or_train) {
    
    x_file <- paste("X_", test_or_train, ".txt", sep="")
    x <- read.table(file.path("UCI HAR Dataset", test_or_train, x_file))
    
    features <- read.table(file.path("UCI HAR Dataset","features.txt"))
    names(x) <- make.names(features$V2)
    
    x <- x[, !duplicated(colnames(x))]
    
    regex <- "^t(Body|Gravity)(Gyro|Acc).(mean|std)...[XYZ]"
    x <- select(x, matches(regex))
    
    names(x) <- c("acceleration.x.mean","acceleration.y.mean","acceleration.z.mean",
                  "acceleration.x.std","acceleration.y.std","acceleration.z.std",
                  "gravity.x.mean","gravity.y.mean","gravity.z.mean",
                  "gravity.x.std","gravity.y.std","gravity.z.std",
                  "gyro.x.mean","gyro.y.mean","gyro.z.mean",
                  "gyro.x.std","gyro.y.std","gyro.z.std")
    
    subject_file <- paste("subject_", test_or_train, ".txt", sep="")
    subjects <- read.table(file.path("UCI HAR Dataset", test_or_train, subject_file))
    x <- mutate(x, subject = subjects$V1)
    
    activity_labels <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"))
    y_file <- paste("y_", test_or_train, ".txt", sep="")
    y <- read.table(file.path("UCI HAR Dataset", test_or_train, y_file))
    activities <- sapply(y, function(y_row){activity_labels[y_row,2]})
    mutate(x, activity = activities)
}

test <- get_set("test")
train <- get_set("train")

#' After processing the test and train data independently, they are merged into
#' a single data set. Extra variables are removed from the environment so that
#' the script cleans up after itself.
tidy_data <- merge(test, train, all=TRUE)

remove(test)
remove(train)
remove(get_set)