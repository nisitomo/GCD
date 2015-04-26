library(reshape2)

# Merges the training and the test sets to create one data set.

activityLabels <- read.table("activity_labels.txt", sep = " ")
colnames(activityLabels) <- c("activityid", "activityname")

featurelabels <- read.table("features.txt", sep = " ")

subject_Train <- read.table("subject_train.txt", sep = " ")
colnames(subject_Train) <- c("subject")

activityType_Train <- read.table("y_train.txt")
colnames(activityType_Train) <- c("activitytype")

activity_Train <- read.table("X_train.txt")
colnames(activity_Train) <- featurelabels$V2

activity_all_Train <- data.frame(subject_Train, activityType_Train, activity_Train)
colnames(activity_all_Train) <- c(colnames(subject_Train), colnames(activityType_Train), colnames(activity_Train))

subject_Test <- read.table("subject_test.txt", sep = " ")
colnames(subject_Test) <- c("subject")

activityType_Test <- read.table("y_test.txt")
colnames(activityType_Test) <- c("activitytype")

activity_Test <- read.table("X_test.txt")
colnames(activity_Test) <- featurelabels$V2

activity_all_Test <- data.frame(subject_Test, activityType_Test, activity_Test)
colnames(activity_all_Test) <- c(colnames(subject_Test), colnames(activityType_Test), colnames(activity_Test))

activity_all <- rbind(activity_all_Train, activity_all_Test)


# Extracts only the measurements on the mean and standard deviation for each measurement. 

selectedCols <- grep("(mean\\(|std\\())", colnames(activity_all))
activity_selected <- cbind(activity_all[, c("subject", "activitytype")], activity_all[, selectedCols])

tmp1 <- melt(activity_selected, id.vars = c("subject", "activitytype"))
result <- dcast(tmp1, activity_selected$subject + activity_selected$activitytype ~ variable, mean)

write.table(result, file = "result_tidydataset.txt", row.name = FALSE)

