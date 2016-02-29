
# load dplyr library if not available
# the latest released version from CRAN with
# install.packages("dplyr")
library(data.table)
library(dplyr)


#set working directory to file location
setwd("H:/datasciencecoursera/getdata-projectfiles-UCI HAR Dataset")

featureNames <- read.table("UCI HAR Dataset/features.txt")
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activitytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featurestrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activitytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featurestest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

colnames(features) <- t(featureNames[2])

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completedata <- cbind(features,activity,subject)


columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)

extractedData <- completeData[,requiredColumns]
dim(extractedData)

extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}


extractedData$Activity <- as.factor(extractedData$Activity)



names(extractedData)


# adding full names to give more context
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))



#set subject variable
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)


tidydata <- aggregate(. ~Subject + Activity, extractedData, mean)
tidydata <- tidydata[order(tidydata$Subject,tidydata$Activity),]
write.table(tidydata, file = "Tidy.txt", row.names = FALSE)










