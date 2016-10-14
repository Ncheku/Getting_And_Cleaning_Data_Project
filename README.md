# Readme

The present repo stores the various files regarding the "Getting and Cleaning Data" couse (available @Coursera).
The main purpose of this README is to ilucidade readers how the script run_analysis.R works.
The aforementioned script main functions are:


1.  checks for the existence of the raw data file in the directory (if unexistent, downloads it!)
2.  loads activity labels list used to link the class labels with their activity name
3.  loads list of all features collected
4.  loads subjects, activities and observations (for both train and test datasets)
5.  combine subjects, activities and observations (for both train and test datasets)
6.  merges both train and test datasets
7.  subsets the dataset maintaining only the features relating to the meand and std (standard deviation)
8.  inspects the maintained features' labels to uniformize them
9.  applies the appropriate activity names insted of their unique identifier
10. sets the columns pertaining to subjects (Sub_ID) and activities (Act_ID) into factors
11. creates a new, independent, tidy dataset presenting the average value of each of the previously selected 
    features for each subject, per each activity type 
12. writes the new resulting dataset into the file "AveragePerSubjectPerActivity.txt".
