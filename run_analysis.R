## Step 1 Merge the training and the test sets
# 1.1 Read test data (X_test.txt) and test data label (Y_test.txt)
test_data <- read.table("test/X_test.txt")
test_label <- read.table("test/Y_test.txt")

# 1.2 Read train data (X_train.txt) and train data label (Y_test.txt)
train_data <- read.table("train/X_train.txt")
train_label <- read.table("train/Y_train.txt")

# 1.3 Merge the training and test data by rbind (test data comes first)
data <- rbind(test_data,train_data)

## Step 2 Extract only the needed measurements(columns)
# 2.1 Read the colum names from features.txt
cols <- read.table("features.txt",col.names=c("colNum","colName"))

# 2.2 Extract only the needed columns
colnums <- cols[grepl("mean\\(\\)|std\\(\\)",cols$colName),]$colNum # use RegExp to get only those columns with "mean()" or "std()"
data <- data[,colnums] # subset the data set

# Step 3 Name the activities with descriptive activity names
# 3.1 Read the activity ID (number representation) and activity name
act <- read.table("activity_labels.txt",col.names=c("actid","actname"))

# 3.2 Replace the number labels in test and train data with names
test_label <- as.character(act[match(test_label$V1,act$actid),2]) # Use match function to do replace
train_label <- as.character(act[match(train_label$V1,act$actid),2])

# 3.3 Combine the labels of test and train data
labels <- c(test_label,train_label)

# 3.4 Add lables to data set
data <- cbind(labels,data)

## Step 4 Label the dataset with descriptive variable names
# 4.1 Get descriptive names
# remove parenthesis and replace dash with dot, e.g. "tBodyAcc-mean()-X" becomes "tBodyAcc.mean.X"
names <- gsub("-",".",gsub("\\(\\)","",as.character(cols[grepl("mean\\(\\)|std\\(\\)",cols$colName),]$colName)))
colnames(data) <- c("Activity",names) # set variable names

## Step 5 Generate the final tidy data set
# 5.1 Attach subjests to data set
test_subject <- read.table("test/subject_test.txt")  # Read subjects for test data
train_subject <- read.table("train/subject_train.txt")  # Read subjects for train data
subjects <- rbind(test_subject,train_subject)  # combine subjects
colnames(subjects) <- "Subject" # Set column name

data <- cbind(subjects,data)  # Attach subjects to data set

# 5.2 Group and calculate average for all variables
library("dplyr")    # Load dplyr library
data.avg <- group_by(data,Subject, Activity)  # Group data by Subject and Activity
data.avg <- summarise_each(data.avg,"mean")  # Calculate Average for all variables

# 5.3 Write the new data set to file
write.table(data.avg,file="final1.txt",row.name=FALSE)