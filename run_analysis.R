    
      ## Loading the packages and files
library(dplyr)

# We need to check if the file exists
filedataName<- "Final_Data.zip"
if (!file.exists(filedataName)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", filedataName, method="curl")
}  

# And now, we need to checking if the folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filedataName) 
}

     ## LOADING DATA
featuresData= read.table("UCI HAR Dataset/features.txt",col.names = c("nf","functions"))
activitiesData=read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
# Training data
x_train= read.table("UCI HAR Dataset/train/X_train.txt");names(x_train)<-featuresData$functions
y_train=read.table("UCI HAR Dataset/train/y_train.txt",col.names = "result")
sub_train=read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")
# Test data
x_test=read.table("UCI HAR Dataset/test/X_test.txt");names(x_test)<-featuresData$functions
y_test=read.table("UCI HAR Dataset/test/y_test.txt",col.names = "result")
sub_test=read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "Subject")

       ## MERGE TRAIN AND TEST DATA
# I commented these variables because I merge the data directly, but just in case I let them writed
    #X_data<- rbind(x_train,x_test)
    #Y_data<-rbind(y_train,y_test)
    #sub_data<- rbind(sub_train,sub_test)
Merge_data<-cbind(rbind(sub_train,sub_test),rbind(x_train,x_test),rbind(y_train,y_test))

      ## I decided to write one-line code for the mean and std activity and naming the data set

   #Choosing mean and std measurements
finalData <- Merge_data %>% select(Subject, result, contains("mean"), contains("std")) %>%
            mutate(result=activitiesData[result, 2])   # Naming the data set with descriptive activities

      ## Labels the data set with descriptive variable names
names(finalData)<-sub("result","Activity",names(finalData))
names(finalData)<-sub("Acc", "Accelerometer", names(finalData))
names(finalData)<-sub("Gyro", "Gyroscope", names(finalData))
names(finalData)<-sub("BodyBody", "Body", names(finalData))
names(finalData)<-sub("Mag", "Magnitude", names(finalData))
names(finalData)<-gsub("angle", "Angle", names(finalData))
names(finalData)<-sub("^t", "Time", names(finalData))
names(finalData)<-sub("^f", "Frequency", names(finalData))

      ## Writing the final tidy data      
final_TidyData<- finalData %>%  group_by(Subject, Activity) %>%  summarize_all(list(mean))
write.table(final_TidyData, "FinalTidy_Data.txt", row.name=FALSE)

