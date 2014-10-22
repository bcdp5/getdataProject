GETTING &amp; CLEANING DATA: COURSE PROJECT
==============

run_analysis.R
--------------

The following steps are performed by the script 'run_analysis.R' :

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Please notice that step 1 and 4 are handled at the same time, because I found that it is more efficient. 

codeBook.txt
--------------

It's a self described file. 
Basically it stores all the information about the variables of the final data set, created at step 5.
