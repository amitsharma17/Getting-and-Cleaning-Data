#run_analysis.R 

#Prep Step: Download the data and unzip the data into a new directory
filename <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(filename,"RawData.zip")
unzip("RawData.zip",eexdir = "./RawData")

#In the following steps we will start reading the various files. As we read the files we will also change the column labels as necessary.  

#Reading first file "Activity_labels.txt". We are also give more description column labels
activity_labels <- read.table("./RawData/UCI HAR Dataset/activity_labels.txt",col.names = c("Activity.Code","Activity.Description"))

#Reading second file "features.txt". Similar as above we are giving relevant column names.
features <- read.table("./RawData/UCI HAR Dataset/features.txt",col.names = c("feature.code","feature.description"))

#Reading training data, since x_train data has all feature data, we are going to use the feature.description to rename the column names.

x.train <- read.table("./RawData/UCI HAR Dataset/train/X_train.txt",col.names = features$feature.description)
y.train <- read.table("./RawData/UCI HAR Dataset/train/y_train.txt", col.names = "Activity.Code")
subject.train <- read.table("./RawData/UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

#Merge the various training data sets
train.data <- cbind(subject.train, y.train, x.train)
rm(x.train)
rm(y.train)
rm(subject.train)

#Reading test data, we will perform the same actions as above for test data

x.test <- read.table("./RawData/UCI HAR Dataset/test/X_test.txt",col.names = features$feature.description)
y.test <- read.table("./RawData/UCI HAR Dataset/test/y_test.txt", col.names = "Activity.Code")
subject.test <- read.table("./RawData/UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

#Merge the various test data sets

test.data <- cbind(subject.test, y.test, x.test)
rm(x.test)
rm(y.test)
rm(subject.test)


#Step 1: Merge training and test set to create on data set.  
Merge.data <- rbind(train.data, test.data)
rm(train.data)
rm(test.data)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
Merge.mean <- Merge.data[, grepl("mean", names(Merge.data))]
Merge.std <- Merge.data[, grepl("std", names(Merge.data))]
Merge.mean.std <- cbind(Merge.data$Subject, Merge.data$Activity.Code, Merge.mean, Merge.std)
names(Merge.mean.std)[1] <- "Subject"
names(Merge.mean.std)[2] <- "Activity.Code"
rm(Merge.mean)
rm(Merge.std)

#Step 3: The original file and mean|std file only has activity code, we will add activity description to the files.
Merge.data.desc <- merge(Merge.data, activity_labels, by.x = "Activity.Code", by.y = "Activity.Code", all = TRUE)
Merge.mean.std.desc <- merge(Merge.mean.std, activity_labels, by.x = "Activity.Code", by.y = "Activity.Code", all = TRUE)
i <- match("Activity.Code", names(Merge.mean.std.desc))
Merge.mean.std.desc <- Merge.mean.std.desc[,-i]

i <- match("Activity.Code", names(Merge.data.desc))
Merge.data.desc <- Merge.data.desc[,-i]

#Step 4: Appropriate labels the data set with descriptive variable names
#We have done this as we were reading and merging the files.  

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Convert the group by parameters to factor
Merge.mean.std.desc <- transform(Merge.mean.std.desc, Subject = factor(Subject))

#Creating Tidy Data
Tidy.Data <- Merge.mean.std.desc %>% group_by(Subject,Activity.Description)%>% summarize_each(funs(mean))

#Write Tidy Data to text file
write.table(Tidy.Data, ffile = "./RawData/Tidy_Data.txt", row.names = FALSE)

