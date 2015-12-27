#CodeBook

This is CodeBook for the tidy_data.txt created using the analysis performed in run_analysis.R  

There are three sections in this document.  

* Transformation - This section provides details on how the raw data is transformed into tidy data.
* The Data - This section gives a brief overview of the data in the tidy_data.txt dataset
* Variables - This last section includes all the variable included in the tidy_data.txt


##Transformation  
This is a summary of run_analysis.R in which we transformed the raw data into tidy data.

* First step is to download the data

* Read all the files and assigne appropriate names

* Merging the training and test data

* Extracts only the measurements on the mean and standard deviation for each measurement

* Adding activity descriptions

* Since we have all the columns labeled, we will prepare the summary data and write it to table


##The Data  

The Raw data comes from following 8 files:

1. Activity_Labels
2. Features
3. Train Data  
  3a. Measurements  
  3b. Labels  
  3c. Subjects  
4. Test Data  
  4a. Measurements  
  4b. Labels  
  4c. Subjects  

The process outlined in Transformation section is used to convert the raw data into tidy data.

##Variables 

The final tidy data is a summary of mean and standard deviation for all variables by subject and activity codes. The variables in the list are following: ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions)

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag


