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
Further about efficiency I decided to adopt *data.table* object instead of *data.frame*.
  
   
####Step 1 (include 4)  

Here I start by getting all the variables names stored in the file 'features.txt'.  
In this way step 4 is included, because the descriptive variable names are adopted since the beginning.  
   
Then I handle both the Training set and the Test set and for each I build a comprehensive dataset.  
This dataset is made by the join of 3 tables:
  
  + *'X'* which include all the records of the signals
  + *'y'* which include all the activity measured
  + *'subject'* which include the list of the subjects of the experiment
 
Finally I merge the twos in order to obtain one comprehensive data.table, called **'total.Data'** (notice it altready has all the descriptive columns names).    
  
####Step 2  
 
As it's not specified in the guidelines I extract all the variables which include the terms: *"mean"*, *"std"*   in their name.  
  
     
####Step 3  
  
As the first thing I get the values from  the file 'activity_labels.txt', then I merge this with the current dataset.  
Please pay attention that I'm usign a *data.table* so the code is different as for *data.frame*, due to different syntax.  
  
  
####Step 4
  
Already handled in step 1.
  
  
####Step 5  
  
For this final step I create another tidy data set, called **'final'**, with the average of each variable for each activity and each subject from **'total.Data'**.  
Thanks to the data.table syntax it's pretty straightforward to aggregate the dataset by *'subject'*,*'activity'* and computing the mean of each column.  
  
In the end I write the **'final'** data set into a text file called "tidyData.txt".  
  

codeBook.txt
--------------

It's a self described file. 
 
Basically it stores all the information (names, meanings, type of values) about the variables of the final data set, created at step 5.
