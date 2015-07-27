
library(caTools)

train0 <- read.csv('data/train_0.txt', header=FALSE, stringsAsFactors=FALSE)
train1 <- read.csv('data/train_1.txt', header=FALSE, stringsAsFactors=FALSE)
train2 <- read.csv('data/train_2.txt', header=FALSE, stringsAsFactors=FALSE)
train3 <- read.csv('data/train_3.txt', header=FALSE, stringsAsFactors=FALSE)
train4 <- read.csv('data/train_4.txt', header=FALSE, stringsAsFactors=FALSE)

train0$level <- rep(0, nrow(train0))
train1$level <- rep(1, nrow(train1))
train2$level <- rep(2, nrow(train2))
train3$level <- rep(3, nrow(train3))
train4$level <- rep(4, nrow(train4))

train<-rbind(train0, train1, train2, train3, train4)
train<-train[sample.int(nrow(train)),]
rm(train0, train1, train2, train3, train4)

# lets see how levels are spread after data preprocessing:
hist(train$level)

set.seed(144)
split <- sample.split(train$level, SplitRatio = 0.9)
trainData <- train[split == TRUE,]
crossValidationData <- train[split == FALSE,]

# convert_imageset expects to get path to file in
# first column
trainData$V1 <- paste("train", trainData$V1, sep="/")
crossValidationData$V1 <- paste("cv", crossValidationData$V1, sep="/")

# for Caffe we need file with image filenames
# and label separated by space
write.table(trainData, file="train.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)
write.table(crossValidationData, file="cv.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)