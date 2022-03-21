## Getting and Cleaning data project

In order to complete the project, the main file "run_analysis.R" use dplyr package and perform 7 steps to get the final tidy data.

1. **Download the data set:** First, check if the file exist, if not, the data set is downloaded and saved in the folder *UCI HAR Dataset*.
2. **Load data:** Then, the data is extracted and stored in the following variables

    - featuresData: Contains the features selected for the database, and come from the accelerometer and          gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
    - activitiesData: Contains the labels with their activity name.
    - x,y,sub_train: Set, labels and subject (respectively) of the train set. 
    - x,y,sub_test: Set, labels and subject (respectively) of the test set
    
3. **Merge data:** The *cbind()* and *rbind()* functions were used to obtain a merge data in this order: subject data, x data and y data. This data is stored in *Merge_data* variable.  
4. **Choosing mean and std measurements:** In order to subset the data with the mean and std measurement the *select()* function is used, the new subset data is stored in *finalData* variable
5. **Name the data set with descriptive activities:** Using the *mutate()* function the labels from train and test sets are changed with their respective activity name, and again, this is stores in *finalData* variable
6. **Labels the data set with descriptive variable names:** Using the *names()* and *sub()* functions the variable names were changed into descriptive names
7. **Write final tidy data:** The final data contains the average of each variable for each activity and each subject from the data obtained in 4th step. That is why, using the pipeline operator, the data is summarized taking the mean required from a grouped data by Subject and Activity (using the *group_by()* function). 
<br> <br>
Note: For 4th and 5th steps the pipeline operator was used.
