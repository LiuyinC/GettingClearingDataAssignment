## Read Training data with Y label as the first column
Training <- cbind(read.table("./UCI HAR Dataset/train/y_train.txt"),
                  read.table("./UCI HAR Dataset/train/X_train.txt"))
## Read Testing data with Y label as the first column
Testing <-cbind(read.table("./UCI HAR Dataset/test/y_test.txt"),
                read.table("./UCI HAR Dataset/test/X_test.txt"))
## Combine the training and testing data into one data frame with 
## first column being Y label.
ActDataRow <- rbind(Training, Testing)


## Figure our which feature vectors contain "mean()" and "std()"
## and generate a indicator vector MeanStdlist to extract desired
## measurements. 
features <- read.table("./UCI HAR Dataset/features.txt")
MeanStdlist <- sort(c(grep("mean()", features[1:561,2]), 
                      grep("std()", features[1:561,2]))) + 1
ActData <- ActDataRow[,c(1, MeanStdlist)]
names(ActData) <- c("ActLable", as.character(features[MeanStdlist-1,2]))


##
ActLables <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                        col.names = c("ActLable","Activity"))
NamedActData <- 


