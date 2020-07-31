library(dplyr)


features <- read.table("UCI HAR Dataset/features.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE,sep = "",quote = "\"'",dec = ",",numerals = c("allow.loss","warn.loss","no.loss"), col.names = "code")


#Question 1
x_train_test<-rbind(x_train, x_test)
y_train_test<-rbind(y_train, y_test)
Subject_train_test<-rbind(subject_train,subject_test)
merged_train_test<-cbind(Subject_train_test, y_train_test, x_train_test)

#Question 2

mean_standard_deviation<-merged_train_test %>% select(Subject_train_test,contains("mean"), contains("std"))

#Question 3

activities_name<-activities[activities_name,2]

#Question 4

names(mean_standard_deviation)[2] = "activity"
names(mean_standard_deviation)<-gsub("Acc", "Accelerometer",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("Gyro", "Gyroscope",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("BodyBody", "Body",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("Mag", "Magnitude",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("^t", "Time",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("^f", "Frequency",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("tBody", "TimeBody",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("-mean()", "Mean",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("-std()", "STD",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("-freq()", "Frequency",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("angle", "Angle",names(mean_standard_deviation))
names(mean_standard_deviation)<-gsub("gravity", "Gravity",names(mean_standard_deviation))


#Question 5

mean_activity_subject<-mean_standard_deviation %>% group_by(subject,activity) %>% summarise_all(funs(mean)) write.table(mean_activity_subject,"mean_activity_subject.txt",row.names = FALSE)






