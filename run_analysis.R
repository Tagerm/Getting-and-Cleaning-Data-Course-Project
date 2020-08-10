##Library
library(dplyr)
library(envDocument)
library(codebook)
#File directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#Reading of Data
Testing <- read.delim("./UCI HAR Dataset/test/X_test.txt",
                      sep = "", header = F)
Training <- read.delim("./UCI HAR Dataset/train/X_train.txt", 
                       sep = "", header = F)

binded <- rbind(Testing, Training)

##Searching for the columns with the mean or std

features <- read.delim("./UCI HAR Dataset/features.txt",
           sep = "", header = F)
colsmean <- grep("mean[()]", features[, 2])
colsstd <- grep("std[()]", features[, 2])

colss <- c(colsmean, colsstd)
dataframe <- binded[1:10297, colss]

meanames <- grep("mean[()]", features[, 2], value = T)
stdnames <- grep("std[()]", features[, 2], value = T)


## Reading the activity labels & subjects docs

labeltest <- read.delim("./UCI HAR Dataset/test/Y_test.txt")
labeltrain <- read.delim("./UCI HAR Dataset/train/Y_train.txt")
labels <- rbind(labeltest, labeltrain)

subjectest <- read.delim("./UCI HAR Dataset/test/subject_test.txt")
subjectrain <- read.delim("./UCI HAR Dataset/train/subject_train.txt")
colnames(subjectest) <- "subjects"
colnames(subjectrain) <- "subjects"
subjects <- rbind(subjectest, subjectrain)

testntrain <- cbind(subjects, labels, dataframe)
data <- testntrain[order(testntrain$subjects, testntrain$X5),]
View(data)
## Column Names

names <- c("subject", "activities",meanames, stdnames)
colnames(data) <- names

## Activities names

data$activities[data$activities == 1] <- "walk"
data$activities[data$activities == 2] <- "walkupstairs"
data$activities[data$activities == 3] <- "walkdownstairs"
data$activities[data$activities == 4] <- "sit"
data$activities[data$activities == 5] <- "stand"
data$activities[data$activities == 6] <- "lay"

##CodeBook
bum <- codebook(data)

