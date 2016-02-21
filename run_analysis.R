
# setwd("~/cleandata")

# Read "Train" dataset and Labels
trainData <- read.table("./train/X_train.txt")
trainLabel <- read.table("./train/y_train.txt")
trainSubject <- read.table("./train/subject_train.txt")

# Read "Test" dataset and Labels
testData <- read.table("./test/X_test.txt")
testLabel <- read.table("./test/y_test.txt") 
testSubject <- read.table("./test/subject_test.txt")

# merged "Test" & "Train" Data & Label Sets
mergedData <- rbind(trainData, testData)
mergedLabel <- rbind(trainLabel, testLabel)
mergedSubject <- rbind(trainSubject, testSubject)

# Remove 'Train' and 'Test' datasets from workspace memory (We don't need them anymore)
rm(list = ls(pattern = "^test"))
rm(list = ls(pattern = "^train"))

# Extracts only measurements for mean and standard deviation 
features <- read.table("./features.txt")
meanAndStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])

# Extract only Mean and Standard Deviation Columns from the merged data
mergedData <- mergedData[, meanAndStdIndices]

# Name the columns after tidying the name labels
names(mergedData) <- gsub("\\(\\)", "", features[meanAndStdIndices, 2]) # remove "()"
names(mergedData) <- gsub("mean", "Mean", names(mergedData)) # capitalize M
names(mergedData) <- gsub("std", "Std", names(mergedData)) # capitalize S
names(mergedData) <- gsub("-", "", names(mergedData)) # remove "-" in column names 


# Use descriptive activity names for activities in the data set
activity <- read.table("./activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[mergedLabel[, 1], 2]
mergedLabel[, 1] <- activityLabel
names(mergedLabel) <- "activity"

# Attach the Subjects and Activity Labels to the merged data
names(mergedSubject) <- "subject"
tidyData <- cbind(mergedSubject, mergedLabel, mergedData)
write.table(tidyData, "tidy_data.txt") 

# Create the 2nd dataset with averages for all Subject + Activity combination
subjectLen <- length(table(mergedSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(tidyData)[2]
dataset2 <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
dataset2 <- as.data.frame(dataset2)
colnames(dataset2) <- colnames(tidyData)

row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        dataset2[row, 1] <- sort(unique(mergedSubject)[, 1])[i]
        dataset2[row, 2] <- activity[j, 2]
        bool1 <- i == tidyData$subject
        bool2 <- activity[j, 2] == tidyData$activity
        dataset2[row, 3:columnLen] <- colMeans(tidyData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
write.table(dataset2, "second_dataset_with_averages.txt") 

rm("tidyData", "activity","activityLabel", "dataset2","bool1","bool2", "features","mergedData","mergedLabel","mergedSubject")
