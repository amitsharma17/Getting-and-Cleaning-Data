#README

##Introduction
This is Course Project for Getting and Cleaning Data. The goal of this project is to collect, work with and clean data. The data used in this project is from an experiment data published in "Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012".  
  
This repo contains four files:   
1. README.md   
2. CodeBook.md   
3. run_analysis.R   
4. tidy_data.txt   
   
###CodeBook.md  
The CodeBook describes the variables, the data, and any transformations or work that you performed to clean up the data. This is also a requirement for creating tidy data from raw data.  

###run_analysis.R   
This file has detailed steps on how the analysis was performed. There are inline comments explaining the steps performed to complete the following steps and also creating the tidy data.  

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.    
3. Uses descriptive activity names to name the activities in the data set   
4. Appropriately labels the data set with descriptive variable names.    
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.   

###tidy_data.txt  
This is the tidy data created in the run_analysis.R. The tidy data priciples from the first week are following that were followed in the creation of the file:  

- Each variable you measure should be in one column  
- Each different observation of that variable should be in a different row  
- There should be one table for each "kind" of variable  
- If you have multiple tables, they should include a column in the table that allows them to be linked  
*Additional details are included in the CodeBook.md*  
