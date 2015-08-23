## Loading required packages
library(plyr)
library(dplyr)
library(reshape2)

## Reading in Samsung data from working directory
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

## Prepping the individual datasets
features_list <- filter(features, 1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543, 555:561) 
features_list_vector <- as.character(features_list$V2)
features_list_vector <- paste("average_", features_list_vector, sep = "")
names(subject_test) <- "Test Subject"
names(Y_test) <- "Activity"
test_data <- cbind(subject_test, X_test, Y_test)
names(subject_train) <- "Test Subject"
names(Y_train) <- "Activity"
train_data <- cbind(subject_train, X_train, Y_train)

## Merging test and training data together with appropriate labels and activity names
## and subsetting mean and stdev data
merged_data <- rbind(test_data, train_data)
complete_data <- select(merged_data, 1:7, 42:47, 82:87, 122:127, 162:167, 202:203, 215:216, 228:229, 241:242, 254:255, 267:272, 346:351, 425:430, 504:505, 517:518, 530:531, 543:544, 556:563)
names(complete_data) <- c("Subject_ID", as.character(features_list$V2), "Activity")
complete_data$Activity <- factor(complete_data$Activity, levels = c(1, 2, 3, 4, 5, 6), labels = activity_labels$V2)

## Extracting tidy data set with average of all variables for combinations of 
## Subject and Activity
datamelt <- melt(complete_data, id = c("Subject_ID", "Activity"), measure.vars = as.character(features_list$V2))
datacast <- dcast(datamelt, Subject_ID + Activity ~ variable, mean)
names(datacast) <- c("Subject_ID", "Activity", features_list_vector)

## Writing the final tidy dataset to a text file
write.table(datacast, file = "finaldataset.txt", row.names = FALSE)
