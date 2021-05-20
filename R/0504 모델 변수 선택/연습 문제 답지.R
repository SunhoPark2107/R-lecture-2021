# UCLA 데이터에 대해서 Cross validation을 하고
# 4가지 모델에 대해서 정확도, 정밀도, 재현율을 구하시오.
library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(class)

ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)

set.seed(2021)
data <- ucla[sample(nrow(ucla)),]
options(digits = 4)

# K-Fold CV, K=5
k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)

# 이유는 모르겠으나 ucla 데이터는 train함수로 쓰면 오류남.
# Decision Tree
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    dt <- rpart(admit~., data_train)
    pred <- predict(dt, data_test, type='class')
    t <- table(pred, data_test$admit)
    
    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}
dt_avg_acc <- accuracy / k
dt_avg_prec <- precision / k
dt_avg_rec <- recall / k

# Random Forest
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    rf <- randomForest(admit~., data_train)
    pred <- predict(rf, data_test, type='class')
    t <- table(pred, data_test$admit)
    
    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}
rf_avg_acc <- accuracy / k
rf_avg_prec <- precision / k
rf_avg_rec <- recall / k

# Support Vector Machine
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    sv <- svm(admit~., data_train)
    pred <- predict(sv, data_test, type='class')
    t <- table(pred, data_test$admit)
    
    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}
sv_avg_acc <- accuracy / k
sv_avg_prec <- precision / k
sv_avg_rec <- recall / k

# K-Nearest Neighbor
accuracy <- 0
precision <- 0
recall <- 0
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    pred <- knn(data_train[, 2:4], data_test[, 2:4], 
                data_train$admit, k=5)
    t <- table(pred, data_test$admit)
    
    accuracy <- accuracy + (t[1,1]+t[2,2])/nrow(data_test)
    precision <- precision + t[2,2]/(t[2,1]+t[2,2])
    recall <- recall + t[2,2]/(t[1,2]+t[2,2])
}
kn_avg_acc <- accuracy / k
kn_avg_prec <- precision / k
kn_avg_rec <- recall / k

sprintf('결정트리: 정확도=%f, 정밀도=%f, 재현율=%f',
        dt_avg_acc, dt_avg_prec, dt_avg_rec)
sprintf('랜덤 포레스트: 정확도=%f, 정밀도=%f, 재현율=%f',
        rf_avg_acc, rf_avg_prec, rf_avg_rec)
sprintf('SVM: 정확도=%f, 정밀도=%f, 재현율=%f',
        sv_avg_acc, sv_avg_prec, sv_avg_rec)
sprintf('K-NN: 정확도=%f, 정밀도=%f, 재현율=%f',
        kn_avg_acc, kn_avg_prec, kn_avg_rec)




###################################################################################################################
식 줄인 것

# UCLA 데이터에 대해서 Cross validation을 하고
# 4가지 모델에 대해서 정확도, 정밀도, 재현율을 구하시오.
library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(class)

ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)

set.seed(2021)
data <- ucla[sample(nrow(ucla)),]
options(digits = 4)

# K-Fold CV, K=5
k <- 5
q <- nrow(data) / k
l <- 1:nrow(data)

accuracy <- c(0,0,0,0)
precision <- c(0,0,0,0)
recall <- c(0,0,0,0)
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)
    data_test <- data[test_list,]
    data_train <- data[-test_list,]
    
    # Decision Tree
    dt <- rpart(admit~., data_train)
    pred <- predict(dt, data_test, type='class')
    t <- table(pred, data_test$admit)
    accuracy[1] <- accuracy[1] + (t[1,1]+t[2,2])/nrow(data_test)
    precision[1] <- precision[1] + t[2,2]/(t[2,1]+t[2,2])
    recall[1] <- recall[1] + t[2,2]/(t[1,2]+t[2,2])
    
    # Random Forest
    rf <- randomForest(admit~., data_train)
    pred <- predict(rf, data_test, type='class')
    t <- table(pred, data_test$admit)
    accuracy[2] <- accuracy[2] + (t[1,1]+t[2,2])/nrow(data_test)
    precision[2] <- precision[2] + t[2,2]/(t[2,1]+t[2,2])
    recall[2] <- recall[2] + t[2,2]/(t[1,2]+t[2,2])
    
    # Support Vector Machine
    sv <- svm(admit~., data_train)
    pred <- predict(sv, data_test, type='class')
    t <- table(pred, data_test$admit)
    accuracy[3] <- accuracy[3] + (t[1,1]+t[2,2])/nrow(data_test)
    precision[3] <- precision[3] + t[2,2]/(t[2,1]+t[2,2])
    recall[3] <- recall[3] + t[2,2]/(t[1,2]+t[2,2])
    
    # K-Nearest Neighbor
    pred <- knn(data_train[, 2:4], data_test[, 2:4], 
                data_train$admit, k=5)
    t <- table(pred, data_test$admit)
    accuracy[4] <- accuracy[4] + (t[1,1]+t[2,2])/nrow(data_test)
    precision[4] <- precision[4] + t[2,2]/(t[2,1]+t[2,2])
    recall[4] <- recall[4] + t[2,2]/(t[1,2]+t[2,2])
}

average_acc <- accuracy / k
average_prec <- precision / k
average_rec <- recall / k

sprintf('결정트리: 정확도=%f, 정밀도=%f, 재현율=%f',
        average_acc[1], average_prec[1], average_rec[1])
sprintf('랜덤 포레스트: 정확도=%f, 정밀도=%f, 재현율=%f',
        average_acc[2], average_prec[2], average_rec[2])
sprintf('SVM: 정확도=%f, 정밀도=%f, 재현율=%f',
        average_acc[3], average_prec[3], average_rec[3])
sprintf('K-NN: 정확도=%f, 정밀도=%f, 재현율=%f',
        average_acc[4], average_prec[4], average_rec[4])