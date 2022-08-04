The run_analysis.R script prepares the data and executes the 5 steps required by the course project.

# Download the dataset

Dataset downloaded from URL and extracted from the folder called UCI HAR Dataset

# Assigned data frames

features_names <- features.txt : 561 rows, 2 columns
List of all features.

activity_labels <- activity_labels.txt : 6 rows, 2 columns
Links the class labels with their activity name.

subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9 out of 30 volunteer test subjects being observed

x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data

y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’ code labels

subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21 out of 30 volunteer subjects being observed

x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data

y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’ code labels

# Merged the training and the test sets to create one data set

features (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
activities (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
merged_data (10299 rows, 563 column) is created by merging subject, activities and features using cbind() function

# Extracted only the measurements on the mean and standard deviation for each measurement

mean_std_data (10299 rows, 88 columns) is created by subsetting merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation for each measurement

# Used descriptive activity names to name the activities in the data set

Entire numbers in code column of the mean_std_data replaced with corresponding activity taken from second column of the activity_labels variable

# Appropriately labels the data set with descriptive variable names

code column in mean_std_data renamed into "activity"

Every instance of "Acc" in column’s name replaced by "Accelerometer"

Every instance of "Gyro" in column’s name replaced by "Gyroscope"

Every instance of "BodyBody" in column’s name replaced by "Body"

Every instance of "Mag" in column’s name replaced by "Magnitude"

Every instance that starts with character "t" in column’s name replaced by "Time"

Every instance that starts with character "f" in column’s name replaced by "Frequency"

Every instance of "tBody" in column’s name replaced by "TimeBody"

Every instance of "-mean" in column’s name replaced by "Mean"

Every instance of "-std" in column’s name replaced by "STD"

Every instance of "-freq" in column’s name replaced by "Frequency"

Every instance of "angle" in column’s name replaced by "Angle"

Every instance of "gravity" in column’s name replaced by "Gravity"


# From the data set in step 4, creates a second, independent data set with the average of each variable for each activity and each subject

second_Data (180 rows, 88 columns) is created by sumarizing mean_std_data taking the means of each variable for each activity and each subject, and is grouped by subject and activity.

# Export second_Data into second_Data.txt file.
