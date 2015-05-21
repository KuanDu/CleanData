## This is the README file explains how the script works.

### The general processing it does to the raw data is:
* Read both the test and train data into data frame and merge them together
* Extract only those measurements needed (i.e. those variables whose names contain "mean()" or "std()")
* Replace the number representation of activities with names
* Give each variables (columns) with descriptive names
* Group the data by Subject and Acticity, calculate average for other variables and write the tidy data into file

### Details can be found in the comments of the R script code.