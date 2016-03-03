Intent of Program is creating a "tidy data set" of wearable computing data from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files include in this repo:

README.md -- Overview of the process used
CodeBook.md -- codebook describing the variables, data and transformations made (to the data)
run_analysis.R -- actual R code to provide the following:

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It should run in a folder of the Samsung data (the zip had this folder: UCI HAR Dataset) The script assumes it has in it's working directory the following files and folders:

activity_labels.txt
features.txt
test/
train/
The output is created in working directory with the name of tidy2.txt

Note: the R script requires the following libaries:  "data.table","dplyr","knitr".

The steps of the program are:

Step 1:
Read in all the test and training files: y_test.txt, subject_test.txt and X_test.txt.
Combine the files to a data frame in the form of subjects, labels, the rest of the data.

Step 2:
Read the features from features.txt and apply filter to leave features that are either means ("mean()") or standard deviations ("std()"). 

A new data frame is then created that includes subjects, labels and the described features.

Step 3:
Read the activity labels from activity_labels.txt and replace the numbers with the text.

Step 4:
Make a column list (includig "subjects" and "label" at the start)
Clean up the list by removing all non-alphanumeric characters and converting the result to lowercase.
Apply the new and cleaned up names to the data frame.

Step 5:
Create a new data frame by finding the mean for each combination of subject and label. It's done by aggregate() function

Final step:
Write the new tidy set into a text file called tidy2.txt, formatted with the structure of the original files.
