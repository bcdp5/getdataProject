################
## GETTING & CLEANING DATA: COURSE PROJECT
## Made by: bcdp5
###############



# Load library
library(data.table)



# 1.MERGE DATASET (train+test) -----------------------------------------------

#1.1 Handle common features, i.e. variables
  variables <- read.table(file=".//UCI HAR Dataset//features.txt", stringsAsFactors = F,header = F, sep = " ")[,2]
  head(variables)
  class(variables)
  unique(variables)

#1.2 Handle the Training & set column names
  train <- as.data.table(read.table(file=".//UCI HAR Dataset//train//X_train.txt", stringsAsFactors = F,header = F))
  names(train) <- variables
  sapply(train,class)
  #Retrive training dataset of the activities
  activityTrain <- as.data.table(read.table(file=".//UCI HAR Dataset//train//y_train.txt", stringsAsFactors = F,header = F))
  unique(activityTrain)
  #Retrive training dataset of the subjects 
  subjectTrain <- as.data.table(read.table(file=".//UCI HAR Dataset//train//subject_train.txt", stringsAsFactors = F,header = F))
  unique(subjectTrain)
  #Merge all the training sets (subject,activity,train) & set column names
  finalTrain <- cbind(subjectTrain,activityTrain,train)
  finalTrain <- setNames(object = finalTrain,nm = c("subject","activity",names(train)))

#1.3 Handle the Test set
  test <- as.data.table(read.table(file=".//UCI HAR Dataset//test//X_test.txt", stringsAsFactors = F,header = F))
  names(test) <- variables
  #Retrive test dataset of the activities 
  activityTest <- as.data.table(read.table(file=".//UCI HAR Dataset//test//y_test.txt", stringsAsFactors = F,header = F))
  unique(activityTest)
  #Retrive test dataset of the subjects 
  subjectTest <- as.data.table(read.table(file=".//UCI HAR Dataset//test//subject_test.txt", stringsAsFactors = F,header = F))
  unique(subjectTest)
  #Merge all the testing set (subject,activity,train)
  finalTest <- cbind(subjectTest,activityTest,test)
  finalTest <- setNames(object = finalTest,nm = c("subject","activity",names(test)))

#1.4 Final Merge (finalTrain + finalTest)
  total.Data <- rbindlist(l = list(finalTest,finalTrain),use.names = T)
  #Check the data.table
  class(total.Data)
  names(total.Data)
  # set the keys of the data.table DT for subject and activity 
  setkeyv(total.Data,c("subject","activity"))

#1.5 Remove unused data.tables from current environment
  rm(list = c("train","test","finalTest","finalTrain",
              "subjectTrain","subjectTest","activityTrain","activityTest",
              "variables"))



# 2.EXTRACT MEAN & STD ----------------------------------------------------

#2.1 Extract all the variables which name include "mean"
  mean.val <- grep(pattern = "*Mean",x = names(total.Data),ignore.case = T)
  # Test 
  total.Data[,mean.val, with=F]

#2.2 Extract all the variables which name include "std" (i.e. Standard deviation)
  std.val <- grep(pattern = "*std",x = names(total.Data),ignore.case = T)

#2.3 Extract only subjects, activity, mean & std dev 
  total.Data <- total.Data[,c(1,2,mean.val,std.val), with =F]

#2.4 Remove unused objects 
  rm(list = c("mean.val","std.val"))



# 3.RENAME ACTIVITIES IN total.Data ---------------------------------------

#3.1 Load activities
  activities  <- as.data.table(read.table(file=".//UCI HAR Dataset//activity_labels.txt", stringsAsFactors = F,header = F))
  names(activities) <- c("activity","description")
  
#3.2 Merge 'activities' and 'total.data'
  # Set the keys for the merge operation
  setkey(activities,"activity")
  setkey(total.Data,"activity")
  # Merge the two data.tables in order to have the description of each activity, instead of its code
  total.Data <- total.Data[activities,]
  # Assign the values to the column 'activity' based on the column 'description'
  total.Data[,activity:=description]
  # Drop the column 'description'
  total.Data[,description := NULL]

#3.3 Remove unused data.table 'activities'
  rm("activities")



# 4.LABELS THE DATASET ----------------------------------------------------

# Previously handled during the step 1



# 5.COMPUTE THE AVERAGE FOR EACH SUBJECT AND ACTIVITY ---------------------------------------------------------

#5.1 Re-set the keys of the data.table 
  setkeyv(total.Data,c("subject","activity"))

#5.2 Create a new tidy data.table with the average of the mean and sd measures (point 2) for each subject and activity
  final <- total.Data[,lapply(.SD,mean), by="subject,activity"]

#5.3 Write the 'final' data.table in a text file
  write.table(final, file = "tidyData.txt",row.names=F,col.names = T)


