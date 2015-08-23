# getcleandataproject
Course Project for Getting and Cleaning Data - Coursera

This readme file describes the run_analysis.R script uploaded in the repo towards the Getting and Cleaning Data Project.
A separate codebook is uploaded that discusses the individual variables and the final data set according to the principles set out in Hadley Wickham's paper.

Assumptions/Notes: 
The Samsung dataset is downloaded and present in the working directory in the same format as available from the weblink.
Only variables described as being the mean and standard deviation of the 24 original variables are extracted and summarized in the data. i.e. data described as XXX-freqmean() are not included while XXX-mean() is. 
In addition, data for all three axes (x, y and z) are included in the calculations.
Data in the inertial folders have not been included for this project.
The output file in in a txt format and should be read back into R with the following command
> read.table("finaldataset.txt", header = TRUE)

Segment 1: 
This section of the code loads all the required R packages into the session.

Segment 2:
This section of the code reads in all the required txt files that are required for the tidying of data.

Segment 3:
This section of the code prepares the indivdual (test and training) dataset for tidying by renaming some of the columns (variables). The Subject ID information and Activity columns are given the appropriate labels so that merging is accomplished in an easier manner at a later stage. Each observation (as described in X_test and X_train) is recorded as a separate row and bound together (using cbind) with the respective Subject ID and Activity being observed.

Segment 4:
This section of the code combines the test and training data using the rbind command. At this stage, all the data and variables recorded are included in the dataset. The next step extracts the specific variables representing the mean and standard deviations of the observations (as per assumptions mentioned). The data set is further tidied by applying appropriate descriptions for the variables (using features.txt) along with the activity names(activity_labels.txt) as factors. These descriptive variables are further detailed in the codebook.

Segment 5:
This section of the code extracts an independent tidy data set using the reshape2 package consisting of the average values of each observation, arranged by combinations of Subject ID and Activity (180 total combinations). 
The table is arranged in a wide format since it would be easier to look up the Subject ID and Activity combination first, followed by the required variable. 

Segment 6:
This section of the code writes the final tidy data set to a txt file in the working directory.
This file can be re-read into R using the command read.table("finaldataset.txt", header = TRUE)
