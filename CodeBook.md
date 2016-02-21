Cleaning Data Project CodeBook
=================================================
The purpose of this project is to demonstrate collection and cleaning of a data set. The goal is to prepare tidy data that can be used for later analysis. 

* The oroginal source site for data:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

* The run_analysis.R script performs the following steps to clean the data:   

1. It reads the Observed data, Subject Data, and Activity Label data for both the "TEST" and "TRAIN"" data sample.
2. It merges the "TEST" and "TRAIN" Observation data , Subject data and Activity Data respectively.
3. The merged data is subsetted to only the mean and standard deviation columns.
4. The merged "Subject" and "Activity" datasets are added as two new columns to the merged observation data from (3) above.
5. The variable names are tidy-ied -> made more descriptive
6. The final merged dataset is downloaded to *tidy_data.txt*
7. A second dataset is created by grouping the subject and activity and calculation the mean for every column.
8. This second data set is downloaded as *second_dataset_with_averages.txt*
