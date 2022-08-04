# Loading packages

library(dplyr)

#Downloading dataset

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Assigning data frames

features_names <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features_names$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features_names$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merging training and test data into one data set

features <- rbind(x_train, x_test)
activities <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, activities, features)

# Extracting only the mean and standard deviation for each measurement

mean_std_data <- merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Using descriptive activity names to name activities

mean_std_data$code <- activity_labels[mean_std_data$code, 2]

# Appropriately label the data set with descriptive variable names

names(mean_std_data)[2] = "activity"
names(mean_std_data)<-gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data)<-gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data)<-gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data)<-gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data)<-gsub("^t", "Time", names(mean_std_data))
names(mean_std_data)<-gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data)<-gsub("tBody", "TimeBody", names(mean_std_data))
names(mean_std_data)<-gsub("-mean()", "Mean", names(mean_std_data), ignore.case = TRUE)
names(mean_std_data)<-gsub("-std()", "STD", names(mean_std_data), ignore.case = TRUE)
names(mean_std_data)<-gsub("-freq()", "Frequency", names(mean_std_data), ignore.case = TRUE)
names(mean_std_data)<-gsub("angle", "Angle", names(mean_std_data))
names(mean_std_data)<-gsub("gravity", "Gravity", names(mean_std_data))

# Second independent data set with the average of each variable and each activity and each subject

second_data <- mean_std_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(second_data, "second_data.txt", row.name=FALSE)

# Checking data

str(second_data)
View(second_data)
View(mean_std_data)
