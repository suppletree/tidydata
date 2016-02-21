Data Cleaning Project
========================================
This file explains the run_analysis.R script.

* The source datatset file is unzipped from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder as "cleandata".

* The folder "data" and the run_analysis.R script must be in the current working directory.
* Use source("run_analysis.R") command to run the script. 
* The script downloads two files to the current working directory:
  - tidy_data.txt -> it contains the cleaned up version of the merged source 'test' and 'train' datasets.
  - second_dataset_with_averages.txt -> it contains the averages of all variables for all subject + activity combinations.
