## Read Training data with Y label as the first column, subject lable as second column
Training <- cbind(read.table("./UCI HAR Dataset/train/y_train.txt"),
                  read.table("./UCI HAR Dataset/train/subject_train.txt"),
                  read.table("./UCI HAR Dataset/train/X_train.txt"))
## Read Testing data with Y label as the first column, subject lable as second column
Testing <-cbind(read.table("./UCI HAR Dataset/test/y_test.txt"),
                read.table("./UCI HAR Dataset/test/subject_test.txt"),
                read.table("./UCI HAR Dataset/test/X_test.txt"))
## Combine the training and testing data into one data frame with 
## first column being Y label.
ActDataRow <- rbind(Training, Testing)


## Figure our which feature vectors contain "mean()" and "std()"
## and generate a indicator vector MeanStdlist to extract desired
## measurements. 
features <- read.table("./UCI HAR Dataset/features.txt")
MeanStdlist <- sort(c(grep("mean()", features[1:561,2]), 
                      grep("std()", features[1:561,2]))) + 2
ActData <- ActDataRow[,c(1,2, MeanStdlist)]
names(ActData) <- c("ActLable", "Subject", as.character(features[MeanStdlist-2,2]))


## Replace the activity lables by their description.
ActLables <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                        col.names = c("ActLable","Activity"))
NamedActData <- merge(ActData,ActLables, by.x = "ActLable", by.y = "ActLable")
NamedActData <- NamedActData[,c(82, 2:81)] 

## Create a tidy data with avergae of each variable for each activity and each subject.
library(plyr)
AveData <- ddply(NamedActData, .(Activity, Subject), numcolwise(mean))
write.csv(AveData, "./Average_Activity.csv", row.names = F)


