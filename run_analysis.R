#Loading required packages

library(dplyr)
library(plyr)

# set the working directory to the folder of the data 
setwd("C:/Users/gehad/Desktop/getdata_projectfiles_UCIHARDataset/UCIHARDataset")

# 1- Merges the training and the test sets to create one data set.

### reading Features and ActivityLabel

features        <- read.table("./features.txt",header=FALSE)
activityLabel   <- read.table("./activity_labels.txt",header=FALSE)

### Assign col. names for ActivityLabel

colnames(activityLabel)<-c("activityId","activityType")


### Read training data
subjectTrain    <-read.table("./train/subject_train.txt", header=FALSE)
xTrain          <- read.table("./train/X_train.txt", header=FALSE)
yTrain          <- read.table("./train/y_train.txt", header=FALSE)

### Assign col. names for Training data

colnames(subjectTrain) <- "subject"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"


### Merging training Data

trainData <- cbind(yTrain,subjectTrain,xTrain)

#Reading the test Data

subjectTest    <-read.table("./test/subject_test.txt", header=FALSE)
xTest         <- read.table("./test/X_test.txt", header=FALSE)
yTest         <- read.table("./test/y_test.txt", header=FALSE)

### Assign col. names for testing data

colnames(subjectTest) <- "subject"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

### merging test Data
testData <- cbind(yTest,subjectTest,xTest)

### merging train and test data
train_test <- rbind(trainData,testData)

# 2- Extracts only the measurements on the mean and standard deviation for each measurement.

mean_std_data <-train_test[,grepl("mean|std|subject|activityId",colnames(train_test))]


# 3- Uses descriptive activity names to name the activities in the data set and remove ActivityId col.

mean_std_data <- join(mean_std_data, activityLabel, by = "activityId")
mean_std_data <-mean_std_data[,-1]

# 4- Appropriately labels the data set with descriptive variable names.

names(mean_std_data) <- gsub("Acc", "Acceleration", names(mean_std_data))
names(mean_std_data) <- gsub("^t", "Time", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data) <- gsub("mean", "Mean", names(mean_std_data))
names(mean_std_data) <- gsub("std", "Std", names(mean_std_data))
names(mean_std_data) <- gsub("Freq", "Frequency", names(mean_std_data))
names(mean_std_data) <- gsub("Mag", "Magnitude", names(mean_std_data))

# 5- creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Final_data <- mean_std_data %>% 
  group_by(subject, activityType) %>% 
  summarise_all(funs(mean))

write.table(Final_data, "Final_data.txt", row.name=FALSE)
