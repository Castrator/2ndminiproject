# Loading of needed libraries
library(dplyr)
library(tidyr)

# 1. MERGING of TEST and TRAIN DATA SETS

## Loading of data sets
#   read.table() reads the file specified in the path parameter
#   cbind() binds the columns of the tables

# Test Data
x_test <- read.table("./specdata/test/X_test.txt")
y_test <- read.table("./specdata/test/y_test.txt", col.names = "activity")
subject_test <- read.table("./specdata/test/subject_test.txt", col.names = "subject")

test_data <- cbind(subject_test, y_test, x_test)

#Train Data
x_train <- read.table("./specdata/train/X_train.txt")
y_train <- read.table("./specdata/train/y_train.txt", col.names = "activity")
subject_train <- read.table("./specdata/train/subject_train.txt", col.names = "subject")

train_data <- cbind(subject_train, y_train, x_train)

## MERGING
#   rbind() binds the rows of the tables

merged_data <- rbind(train_data, test_data)

# 2. EXTRACTING the MEAN and STD

## LOADING of FEATURES
#   read.table() reads the file specified in the path parameter
features <- read.table("./specdata/features.txt", col.names = c("id", "name"))

#   grepl() searches for matches of a string/pattern
filtered_features <- grepl("mean|std", features$name) & !grepl("meanFreq|Subject|Activity", features$name)

#   'extracted_data' stores the filtered data set (with mean and std only)
extracted_data <- merged_data[, filtered_features]

# 3. DESCRIPTIVE ACTIVITY NAMES

## Separating 'subject' and 'activity' from the rest of the extracted data
#   select() takes only the specified variables 
#   read.table() reads the 'activity_labels.txt' file
extracted_sub_act <- extracted_data %>% select(subject, activity)
activities <- read.table("./specdata/activity_labels.txt", col.names = c("id","label"))
#   This replaces the values in the 'activity' column to its appropriate label
extracted_sub_act$activity <- activities[extracted_sub_act$activity, 2]

# 4. DESCRIPTIVE VARIABLE NAMES 

## Separating the 'features' from the rest of the extracted data
#   select() takes only the specified variables
extracted_features <- extracted_data %>% select(-subject, -activity)

#   This stores the feature names on the 2nd column
feature_names <- features[filtered_features, 2]

## Adjusting the descriptions 
#   gsub() takes the input and substitutes it against specified values
adjusted_feature_names <- feature_names
adjusted_feature_names <- gsub("Acc", "Acceleration", adjusted_feature_names)
adjusted_feature_names <- gsub("Gyro", "Gyroscope", adjusted_feature_names)
adjusted_feature_names <- gsub("BodyBody", "Body", adjusted_feature_names)
adjusted_feature_names <- gsub("Mag", "Magnitude", adjusted_feature_names)
adjusted_feature_names <- gsub("^t", "Time", adjusted_feature_names)
adjusted_feature_names <- gsub("^f", "Frequency", adjusted_feature_names)
adjusted_feature_names <- gsub("tBody", "TimeBody", adjusted_feature_names)
adjusted_feature_names <- gsub("-mean()", "Mean", adjusted_feature_names, ignore.case = TRUE)
adjusted_feature_names <- gsub("-std()", "STD", adjusted_feature_names, ignore.case = TRUE)
adjusted_feature_names <- gsub("-freq()", "Frequency", adjusted_feature_names, ignore.case = TRUE)
adjusted_feature_names <- gsub("gravity", "Gravity", adjusted_feature_names)

names(extracted_features) <- adjusted_feature_names

#   colnames() allows for renaming of column names
colnames(extracted_sub_act) <- c("Subject", "Activity")

#   cbind() binds the columns of the separated tables back to 'extracted_data'
extracted_data <- cbind(extracted_sub_act, extracted_features)

# 5. INDEPENDENT TIDY DATA SET

##  Tidying the data
#   group_by() takes 'extracted_data' and groups it by 'subject' and 'activity'
#   summarise_all() takes the mean of each variable in each group
tidy_data <- tibble(extracted_data) %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

# View() allows you to preview the data in table form within Rstudio
View(tidy_data)
