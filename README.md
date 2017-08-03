# Tidying the UCI HAR Dataset

## Source Material

Data from the an experiement using smartphones to measure linear and gyroscopic acceleration can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

This zip file contains a README and other informational text. For more information, see [this page](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Tidying

The data as given is untidy. The data labels are given in separate structures from the data itself. Some data is obscured as numbered keys to string data. To solve this, the run_analysis.R script in this repository compiles the data that is scattered and relabels it in a systematic way. It results in two R data frames, which can then be output to arbitrary file formats by the user.

The first data frame is tidy.data, which is a tidied version of the original data. The second data frame is measurement_averages, which collapses the tidied data into a simpler table. See the code book for details.

## Use

To use this script, download or copy run_analysis.R to the same parent folder as the unzipped UCI HAR Dataset folder. The script does not dictate an output format, so within an R session, simply use `source("run_analysis.R")` where the current working directory is the aforementioned parent folder.

The user may then export the data frame as she sees fit.
