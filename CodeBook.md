#CodeBook

This is CodeBook for the tidy_data.txt created using the analysis performed in run_analysis.R  

There are three sections in this document.  

* Transformation - This section provides details on how the raw data is transformed into tidy data.
* The Data - This section gives a brief overview of the data in the tidy_data.txt dataset
* Variables - This last section includes all the variable included in the tidy_data.txt


##Transformation  
This is a summary of run_analysis.R in which we transformed the raw data into tidy data.

* First step is to download the data

```{r, echo=FALSE}
filename <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(filename,"RawData.zip")
unzip("RawData.zip",eexdir = "./RawData")
```

* Read all the files and assigne appropriate names
```{r, echo = FALSE}
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
```

* Merging the training and test data

```{r, echo=FALSE}
Merge.data <- rbind(train.data, test.data)
rm(train.data)
rm(test.data)
```
  
* Extracts only the measurements on the mean and standard deviation for each measurement

```{r, echo=FALSE}
Merge.mean <- Merge.data[, grepl("mean", names(Merge.data))]
Merge.std <- Merge.data[, grepl("std", names(Merge.data))]
Merge.mean.std <- cbind(Merge.data$Subject, Merge.data$Activity.Code, Merge.mean, Merge.std)
names(Merge.mean.std)[1] <- "Subject"
names(Merge.mean.std)[2] <- "Activity.Code"
rm(Merge.mean)
rm(Merge.std)
```

* Adding activity descriptions

```{r, echo=FALSE}
Merge.data.desc <- merge(Merge.data, activity_labels, by.x = "Activity.Code", by.y = "Activity.Code", all = TRUE)
Merge.mean.std.desc <- merge(Merge.mean.std, activity_labels, by.x = "Activity.Code", by.y = "Activity.Code", all = TRUE)
i <- match("Activity.Code", names(Merge.mean.std.desc))
Merge.mean.std.desc <- Merge.mean.std.desc[,-i]

i <- match("Activity.Code", names(Merge.data.desc))
Merge.data.desc <- Merge.data.desc[,-i]
```

* Since we have all the columns labeled, we will prepare the summary data and write it to table

```{r, echo=FALSE}
Merge.mean.std.desc <- transform(Merge.mean.std.desc, Subject = factor(Subject))

Tidy.Data <- Merge.mean.std.desc %>% group_by(Subject,Activity.Description)%>% summarize_each(funs(mean))

write.table(Tidy.Data, ffile = "./RawData/Tidy_Data.txt", row.names = FALSE)
```


##The Data  

The final data is is mean and standard deviation for all variables by Subject and Activity Code is available in Tidy_Data.txt file.


##Variables 

The final summary of variables in the Tidy_Data file is below.

```{r}
str(Tidy.Data)
```


