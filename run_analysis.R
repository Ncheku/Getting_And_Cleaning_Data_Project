install.packages("downloader")
library(downloader)
library(data.table)
library(dplyr)

##  setwd("C:/Users/Pedro/Desktop")

if(!file.exists(".\\datataset\\dataset.zip")){
  fileUrl <- "https:\\d396qusza40orc.cloudfront.net\\getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download(fileUrl, dest="dataset.zip", mode="wb")
  dateDownload <- date()
  unzip ("dataset.zip", exdir = ".\\dataset")
}

##  list.dirs lists all the subsequent directories
##  list.dirs(".\\dataset")
##  list.dirs lists the files inside the directory
##  list.files(".\\dataset\\UCI HAR Dataset") 

##  loading activity labels list used to link
##  the class labels with their activity name
activity_labels <- read.table(".\\dataset\\UCI HAR Dataset\\activity_labels.txt")
##  renaming activity_labels' columns with proper headers
names(activity_labels) <- c("Act_ID", "Act_Name")
actHeaders <- names(activity_labels)
##  --------------------------------------------
##  actHeaders
##  --------------------------------------------
##  [1] "Act_ID"   "Act_Name"
##  --------------------------------------------
##  activity_labels
##  --------------------------------------------
##       Act_ID                         Act_Name
##  1         1                          WALKING
##  2         2                 WALKING_UPSTAIRS
##  3         3               WALKING_DOWNSTAIRS
##  4         4                          SITTING
##  5         5                         STANDING
##  6         6                           LAYING
##  --------------------------------------------

##  loading list of all features collected
features <- read.table(".\\dataset\\UCI HAR Dataset\\features.txt")
##  renaming features' columns with proper headers
names(features) <- c("Feat_ID", "Feat_Name")
featHeaders <- names(features)
##  --------------------------------------------
##  featHeaders
##  --------------------------------------------
##  [1] "Feat_ID"   "Feat_Name"
##  --------------------------------------------
##  head(features)
##  --------------------------------------------
##      Feat_ID                        Feat_Name
##  1         1                tBodyAcc-mean()-X
##  2         2                tBodyAcc-mean()-Y
##  3         3                tBodyAcc-mean()-Z
##  4         4                 tBodyAcc-std()-X
##  5         5                 tBodyAcc-std()-Y
##  6         6                 tBodyAcc-std()-Z
##  ---------------------------------------------
##  tail(features)
##  -------------------------------------------------
##      Feat_ID                             Feat_Name
##  556     556  angle(tBodyAccJerkMean),gravityMean)
##  557     557      angle(tBodyGyroMean,gravityMean)
##  558     558  angle(tBodyGyroJerkMean,gravityMean)
##  559     559                  angle(X,gravityMean)
##  560     560                  angle(Y,gravityMean)
##  561     561                  angle(Z,gravityMean)
##  -------------------------------------------------

##  loading train Sub_ID's for each observation
trainSub <- read.table(".\\dataset\\UCI HAR Dataset\\train\\subject_train.txt")
##  renaming trainSub's columns with proper headers
names(trainSub) <- "Sub_ID"
trainSubHeaders <- names(trainSub)
##  --------------------------------------------
##  dim(trainSub)
##  --------------------------------------------
##  [1] 7352    1
##  --------------------------------------------
##  head(trainSub)
##  --------------------------------------------
##        Sub_ID
##  1          1
##  2          1
##  3          1
##  4          1
##  5          1
##  6          1
##  --------------------------------------------
##  tail(trainSub)
##  --------------------------------------------
##        Sub_ID
##  7347      30
##  7348      30
##  7349      30
##  7350      30
##  7351      30
##  7352      30
##  --------------------------------------------

##  loading observations from subjects in train set
trainObs <- read.table(".\\dataset\\UCI HAR Dataset\\train\\X_train.txt")
##  renaming trainObs' columns with proper headers
names(trainObs) <- features[,2]
trainObsHeaders <- names(trainObs)
##  --------------------------------------------
##  dim(trainObs)
##  [1] 7352  561
##  --------------------------------------------

##  loading activity labels from subjects in train set
trainAct <- read.table(".\\dataset\\UCI HAR Dataset\\train\\Y_train.txt")
##  renaming trainAct's columns with proper headers
names(trainAct) <- actHeaders[1]
trainActHeaders <- names(trainAct)
##  --------------------------------------------
##  dim(trainAct)
##  [1] 7352    1
##  --------------------------------------------
##  head(trainAct)
##  --------------------------------------------
##        Act_ID
##  1          5
##  2          5
##  3          5
##  4          5
##  5          5
##  6          5
##  --------------------------------------------
##  tail(trainAct)
##  --------------------------------------------
##        Act_ID
##  7347       2
##  7348       2
##  7349       2
##  7350       2
##  7351       2
##  7352       2
##  --------------------------------------------

##  loading test Sub_ID's for each observation
testSub <- read.table(".\\dataset\\UCI HAR Dataset\\test\\subject_test.txt")
##  renaming testSub's columns with proper headers
names(testSub) <- "Sub_ID"
testSubHeaders <- names(testSub)
##  --------------------------------------------
##  dim(testSub)
##  --------------------------------------------
##  [1] 2947    1
##  --------------------------------------------
##  head(testSub)
##  --------------------------------------------
##        Sub_ID
##  1          2
##  2          2
##  3          2
##  4          2
##  5          2
##  6          2
##  --------------------------------------------
##  tail(testSub)
##  --------------------------------------------
##        Sub_ID
##  2942      24
##  2943      24
##  2944      24
##  2945      24
##  2946      24
##  2947      24
##  --------------------------------------------

##  loading observations from subjects in test set
testObs <- read.table(".\\dataset\\UCI HAR Dataset\\test\\X_test.txt")
##  renaming testObs' columns with proper headers
names(testObs) <- features[,2]
testObsHeaders <- names(testObs)
##  --------------------------------------------
##  dim(testObs)
##  [1] 2947  561
##  --------------------------------------------

##  loading activity labels from subjects in test set
testAct <- read.table(".\\dataset\\UCI HAR Dataset\\test\\Y_test.txt")
##  renaming testAct's columns with proper headers
names(testAct) <- actHeaders[1]
testActHeaders <- names(testAct)
##  --------------------------------------------
##  dim(testAct)
##  [1] 2947    1
##  --------------------------------------------
##  head(testAct)
##  --------------------------------------------
##        Act_ID
##  1          5
##  2          5
##  3          5
##  4          5
##  5          5
##  6          5
##  --------------------------------------------
##  tail(testAct)
##  --------------------------------------------
##        Act_ID
##  2942       2
##  2943       2
##  2944       2
##  2945       2
##  2946       2
##  2947       2
##  --------------------------------------------

##  combining {trainSub ; trainAct ; trainObs}
trainSet <- cbind(trainSub, trainAct, trainObs)
##  assigning column names to trainSet
names(trainSet) <- c(trainSubHeaders, trainActHeaders, trainObsHeaders)
##  --------------------------------------------
##  dim(trainSet)
##  --------------------------------------------
##  [1] 7352  563
##  --------------------------------------------

##  combining {testSub ; testAct ; testObs}
testSet <- cbind(testSub, testAct, testObs)
##  assigning column names
names(testSet) <- c(testSubHeaders, testActHeaders, testObsHeaders)
##  --------------------------------------------
##  dim(testSet)
##  --------------------------------------------
##  [1] 2947  563
##  --------------------------------------------

##  merging train and test sets
fullDataset <- rbind(trainSet,testSet)
##  --------------------------------------------
##  dim(fullDataset)
##  --------------------------------------------
##  [1] 10299  563
##  --------------------------------------------

##  defining the patern to ispect for "mean" or "std"
pattern.MeanStd <- "[[:lower:]]ean|[[:lower:]]td"

##  subsetting dataset for mean and std
##  (note: lower\upper cases!)
##  source: https:\\\\www.stat.auckland.ac.nz\\~paul\\ItDT\\HTML\\node84.html
##  --------------------------------------------
##  1) condition that identifies only columns for mean or std
mean.std.condition <- grep(pattern.MeanStd,
                           colnames(fullDataset),
                           ignore.case = TRUE,
                           value = TRUE)
##  --------------------------------------------
##  head(mean.std.condition)
##  --------------------------------------------
##  [1] "tBodyAcc-mean()-X"
##  [2] "tBodyAcc-mean()-Y"
##  [3] "tBodyAcc-mean()-Z"
##  [4] "tBodyAcc-std()-X" 
##  [5] "tBodyAcc-std()-Y" 
##  [6] "tBodyAcc-std()-Z" 
##  --------------------------------------------
##  tail(mean.std.condition)
##  --------------------------------------------
##  [1] "angle(tBodyAccJerkMean),gravityMean)"
##  [2] "angle(tBodyGyroMean,gravityMean)"    
##  [3] "angle(tBodyGyroJerkMean,gravityMean)"
##  [4] "angle(X,gravityMean)"                
##  [5] "angle(Y,gravityMean)"                
##  [6] "angle(Z,gravityMean)" 
##  --------------------------------------------
##  2) applying the condition for the columns
##     where the condition it is valid
mean.std.subSet <- cbind(fullDataset[,1:2],
                     fullDataset[, mean.std.condition])
##  --------------------------------------------
##  dim(mean.std.subSet)
##  --------------------------------------------
##  [1] 10299    88
##  --------------------------------------------

## storing headers for the subseted data set
mean.std.subsetHeaders <- names(mean.std.subSet)
##  --------------------------------------------
##  head(mean.std.subsetHeaders)
##  ---------------------------------------------------------------
##  [1] "Sub_ID"           
##  [2] "Act_ID"           
##  [3] "tBodyAcc-mean()-X"
##  [4] "tBodyAcc-mean()-Y"
##  [5] "tBodyAcc-mean()-Z"
##  [6] "tBodyAcc-std()-X" 
##  ---------------------------------------------------------------
##  tail(mean.std.subsetHeaders)
##  ---------------------------------------------------------------
##  [1] "angle(tBodyAccJerkMean),gravityMean)"
##  [2] "angle(tBodyGyroMean,gravityMean)"    
##  [3] "angle(tBodyGyroJerkMean,gravityMean)"
##  [4] "angle(X,gravityMean)"                
##  [5] "angle(Y,gravityMean)"                
##  [6] "angle(Z,gravityMean)"
##  ---------------------------------------------------------------
##  substituting strings to uniform cases (hereby: "Mean" and "Std")
##  source: http://rfunction.com/archives/2354
mean.std.subsetHeaders <- gsub("mean", "Mean", mean.std.subsetHeaders)
mean.std.subsetHeaders <- gsub("std", "Std", mean.std.subsetHeaders)
mean.std.subsetHeaders <- gsub('-','', mean.std.subsetHeaders)
mean.std.subsetHeaders <- gsub('[(])','', mean.std.subsetHeaders)
##  --------------------------------------------
##  head(mean.std.subsetHeaders)
##  ---------------------------------------------------------------
##  [1] "Sub_ID"       
##  [2] "Act_ID"       
##  [3] "tBodyAccMeanX"
##  [4] "tBodyAccMeanY"
##  [5] "tBodyAccMeanZ"
##  [6] "tBodyAccStdX"
##  ---------------------------------------------------------------
##  tail(mean.std.subsetHeaders)
##  ---------------------------------------------------------------
##  [1] "angle(tBodyAccJerkMean),gravityMean)"
##  [2] "angle(tBodyGyroMean,gravityMean)"    
##  [3] "angle(tBodyGyroJerkMean,gravityMean)"
##  [4] "angle(X,gravityMean)"                
##  [5] "angle(Y,gravityMean)"                
##  [6] "angle(Z,gravityMean)"
##  ---------------------------------------------------------------
##  appplying headers to subsetetd data set
names(mean.std.subSet) <- mean.std.subsetHeaders

##  substituting Act_ID by the appropriate Act_Name
mean.std.subSet$Act_ID <- factor(mean.std.subSet$Act_ID,
                                 levels = activity_labels[,1],
                                 labels = activity_labels[,2])
##  storing Sub_ID as a factor
mean.std.subSet$Sub_ID <- as.factor(mean.std.subSet$Sub_ID)

##  melting the dataset to obtain the mean per subject per activity 
AveragePerSubjectPerActivity<- melt(mean.
                                    std.subSet,
                                    id=c("Sub_ID", "Act_ID"))
##  ---------------------------------------------------------------
##  head(AveragePerSubjectPerActivity)
##  ---------------------------------------------------------------
##          Sub_ID   Act_ID                    variable     value
##        1      1 STANDING               tBodyAccMeanX 0.2885845
##        2      1 STANDING               tBodyAccMeanX 0.2784188
##        3      1 STANDING               tBodyAccMeanX 0.2796531
##        4      1 STANDING               tBodyAccMeanX 0.2791739
##        5      1 STANDING               tBodyAccMeanX 0.2766288
##        6      1 STANDING               tBodyAccMeanX 0.2771988
##  ---------------------------------------------------------------
##  tail(AveragePerSubjectPerActivity)
##  ---------------------------------------------------------------
##         Sub_ID           Act_ID             variable     value
##  885709     24 WALKING_UPSTAIRS angle(Z,gravityMean) 0.1811516
##  885710     24 WALKING_UPSTAIRS angle(Z,gravityMean) 0.1847843
##  885711     24 WALKING_UPSTAIRS angle(Z,gravityMean) 0.1824121
##  885712     24 WALKING_UPSTAIRS angle(Z,gravityMean) 0.1811835
##  885713     24 WALKING_UPSTAIRS angle(Z,gravityMean) 0.1875629
##  885714     24 WALKING_UPSTAIRS angle(Z,gravityMean) 0.1881034
##  ---------------------------------------------------------------
##  dim(AveragePerSubjectPerActivity)
##  ---------------------------------------------------------------
##  [1] 885714      4
##  ---------------------------------------------------------------

##  storing the resulting dataset in a new .txt file
write.table(AveragePerSubjectPerActivity,
            "AveragePerSubjectPerActivity.txt",
            row.name=FALSE)
##  ---------------------------------------------------------------
