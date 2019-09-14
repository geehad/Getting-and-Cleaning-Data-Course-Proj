The variables in the Final_data.txt are :
    1- subject
    2- only the measurements on the mean and standard deviation for each measurement
    3- ActivityType
    
    
The transformation I made : 
    1- Merges the training and the test sets to create one data set.
    2- Extracts only the measurements on the mean and standard deviation for each measurement.
    3- Uses descriptive activity names to name the activities in the data set so I join the data with activityLabel by the activityId and remove the activityId column
    4- Appropriately labels the data set with descriptive variable names , as I replace as follows :
           "Acc" ->  "Acceleration"
           "^t"  ->  "Time"
           "^f"  -> "Frequency"
           "BodyBody" -> "Body"
           "mean" ->  "Mean"
           "std" -> "Std"
           "Freq" -> "Frequency"
           "Mag" -> "Magnitude"
        
    
