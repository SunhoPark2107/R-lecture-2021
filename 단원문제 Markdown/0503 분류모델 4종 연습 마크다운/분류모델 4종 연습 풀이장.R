# ucla 데이터 받아오기
ucla <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
str(ucla)  # 4개의 변수, 400개의 데이터
ucla$admit <- factor(ucla$admit) # int로 되어 있는 admit 변수속성 factor로 생성하여 저장하기.
ucla$admit <- as.factor(ucla$admit) # int로 되어 있는 admit 변수속성 factor로 변경하여 저장하기. (위아래는 별차이가 없다.)
library(class)
library(rpart)
library(caret)    # createDataPartition 포함 패키지.
library(randomForest)
library(e1071)     # svm 사용하기 위한 패키지

# 4가지 모델로 예측 및 평가
# 오늘 배운 모델 => rpart(결정트리), randomForest(랜덤포레스트), svm(support vector machine), knn(k-nearest neighbor)

# train_set, test_set 만들기.
set.seed(2021)
train_index <- createDataPartition(ucla$admit, p=0.8, list = F)
ucla_train <- ucla[train_index, ]
ucla_test <- ucla[-train_index, ]
table(ucla_train$admit)
table(ucla_test$admit)

# 결정트리모델 dt_u 생성

ucla_test
dt_u <- rpart(admit ~ ., ucla_train)

# dt_u 시각화
par(mfrow = c(1,1), xpd = NA)
plot(dt_u)
text(dt_u, use.n = TRUE)

# test셋을 통한 결정트리 예측 pred_dtu
pred_dtu <- predict(dt_u, ucla_test, type = "class")

# test셋을 통한 결정트리 모델 평가
table(pred_dtu, ucla_test$admit)              # 0, 0 => 47. 0으로 예측한 것이 실제 0인 경우의 수. 1, 1 => 7. 1로 예측한 것이 실제 1인 것.
confusionMatrix(pred_dtu, ucla_test$admit)    # 정확도는 69퍼(0.696)(set.seed(2021) 기준)

# decision tree의 정확도 체크하는 방법
t <- table(pred_dtu, ucla_test$admit) 
dt_acc <- (t[1,1] + t[2,2])/nrow(ucla_test)

# 랜덤포레스트 모델 만들기
rf_u <- randomForest(admit ~ ., ucla_train)

plot(rf_u)

print(rf_u)

pred_rfu <- predict(rf_u, ucla_test, type ="class")

table(pred_rfu, ucla_test$admit)
confusionMatrix(pred_rfu, ucla_test$admit)    # 랜덤포레스트 모델 정확도는 67퍼(0.671)(set.seed(2021) 기준)

# 랜덤포레스트 모델 정확도 평가
r <- table(pred_rfu, ucla_test$admit) 
rf_acc <- (r[1,1] + r[2,2])/nrow(ucla_test)
rf_acc


# svm 모델
svm_u <- svm(admit ~ . , ucla_train)

pred_svmu <- predict(svm_u, ucla_test, type = "class")

confusionMatrix(pred_svmu, ucla_test$admit)      # svm 모델 정확도는 67퍼(0.671)(set.seed(2021) 기준)

# svm 모델 정확도 평가
s <- table(pred_svmu, ucla_test$admit) 
sv_acc <- (s[1,1] + s[2,2])/nrow(ucla_test)
sv_acc

# k-nn모델(knn은 학습 과정이 없음. 바로 예측.)
knn_u <- knn(ucla_train[, 2:4], ucla_test[, 2:4], ucla_train$admit, k=10) # k 값은 예측값의 개수이다. knn도 voting형식이므로 k 개수가 몇개이냐에 따라 결과값이 달라질 수도 있다.

knn_u
ucla_test$admit

confusionMatrix(knn_u, ucla_test$admit)          # knn 모델 정확도는 63퍼(0.633)(set.seed(2021) 기준)

# k-nn 모델 정확도 평가
k <- table(knn_u, ucla_test$admit) 
kn_acc <- (k[1,1] + k[2,2])/nrow(ucla_test)
kn_acc

# 로지스틱 회귀
lr <- glm(admit ~ . , ucla_train, family = binomial)
lr_pred <- predict(lr, ucla_test, type = 'response')
lr_pred
lr_pred <- ifelse(lr_pred > 0.5, 1, 0)
t <- table(lr_pred, ucla_test$admit)
lr_acc <- (t[1,1] + t[2,2]) / nrow(ucla_test)
lr_acc

print(paste(dt_acc, rf_acc, sv_acc, kn_acc, lr_acc))


########################################### Wine 데이터 가져와서 가공###############################################
getwd()
setwd("C:/workspace/R")
wine <- read.table('data/wine.data.txt', sep = ',')
head(wine)

columns <- readLines('data/wine.name2.txt')
columns

names(wine)               # V1 은 얻고자 하는 결과. 따라서 2번째 열부터 columns의 변수명을 적용하여 줌.

names(wine) [2:14] <- columns
names(wine)

names(wine)[2:14] <- substr(columns, 4, nchar(columns))     # [1] V1 이런 식으로 되어 있으므로 이름만 남기기 위해서 substr함수 사용.
names(wine)
names(wine)[1] <- 'Y'
names(wine)

wine$Y <- factor(wine$Y)

# train_set = sample_frac(wine, 0.75)   # sample보다 caret 라이브러리의 creatDataPartition 이 더 정확하게 비율을 나눠 데이터 셋을 만들어 준다.
# str(train_set)
# table(wine$Y)
# table(train_set$Y)
# test_set = setdiff(wine, train_set)
# table(test_set$Y)

################################################################################################################
set.seed(2021)
trainW_index <- createDataPartition(wine$Y, p = 0.8, list = F)
wine_train <- wine[trainW_index, ]
wine_test <- wine[-trainW_index, ]

# 모델 4종 생성
dt_w <- rpart(Y ~ . , wine_train)
rf_w <- randomForest(Y ~ ., wine_train)      # Error in eval(predvars, data, env) : 객체 'Malic acid'를 찾을 수 없습니다(?) => 해결: 변수명에 공백 또는 사용할 수 없는 특수문자(. _ 제외하고 거의 대부분)가 들어가는 경우 돌아가지 않음!
svm_w <- svm(Y ~ ., wine_train)
knn_w <- knn(wine_train[, 2:14], wine_test[, 2:14], wine_train$Y, k=5)
knn_w


# 와인 결정트리 & randomForest시각화
par(mfrow = c(1,1), xpd = NA)
plot(dt_w)
text(dt_w, use.n = TRUE)

plot(rf_w)


# 모델 3종 예측모델 만들기
pred_dtw <- predict(dt_w, wine_test, type = "class")
pred_rfw <- predict(rf_w, wine_test, type = "class")
pred_svmw <- predict(svm_w, wine_test, type = "class")


# 로지스틱 회귀
lrw <- glm(Y ~ . , wine_train, family = binomial)
lrw_pred <- predict(lr, wine_test, type = 'response')
lrw_pred
lrw_pred <- ifelse(lrw_pred > 0.5, 1, 0)
tw <- table(lrw_pred, wine_test$Y)
lrw_acc <- (t[1,1] + t[2,2]) / nrow(wine_test)
lrw_acc

# 각 모델의 정확도 확인하여 보기.

tw <- table(pred_dtw, wine_test$Y) 
dtw_acc <- (tw[1,1] + tw[2,2])/nrow(wine_test)
rw <- table(pred_rfw, wine_test$Y)
rfw_acc <- (rw[1,1] + rw[2,2])/nrow(wine_test)
sw <- table(pred_svmw, wine_test$Y)
sw_acc <- (sw[1,1] + sw[2,2])/nrow(wine_test)
kw <- table(knn_w, wine_test$Y)
kw_acc <- (kw[1,1] + kw[2,2])/nrow(wine_test)

print(paste(dtw_acc, rfw_acc, sw_acc, kw_acc, lrw_acc))

confusionMatrix(pred_dtw, wine_test$Y)    # 0.912
confusionMatrix(pred_rfw, wine_test$Y)    # 0.971 
confusionMatrix(pred_svmw, wine_test$Y)    # 1
confusionMatrix(knn_w, wine_test$Y)    # 0.706
