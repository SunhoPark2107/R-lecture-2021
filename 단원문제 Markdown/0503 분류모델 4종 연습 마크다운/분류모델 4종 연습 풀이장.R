# ucla 데이터 받아오기
ucla <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
str(ucla)  # 4개의 변수, 400개의 데이터
ucla$admit <- factor(ucla$admit) # int로 되어 있는 admit 변수속성 factor로 변경하여 저장하기.

# 4가지 모델로 예측 및 평가
# 오늘 배운 모델 => rpart(결정트리), randomForest(랜덤포레스트), svm(support vector machine), knn(k-nearest neighbor)

# train_set, test_set 만들기.
set.seed(2021)
train_index <- createDataPartition(ucla$admit, p=0.8, list = F)
ucla_train <- ucla[train_index, ]
ucla_test <- ucla[-train_index, ]
table(ucla_train$admit)
table(ucla_test$admit)

library(rpart)

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
table(pred_dtu, ucla_test$admit)
confusionMatrix(pred_dtu, ucla_test$admit)    # 정확도는 69퍼(0.696)(set.seed(2021) 기준)

# 랜덤포레스트 모델 만들기
rf_u <- randomForest(admit ~ ., ucla_train)

plot(rf_u)

print(rf_u)

pred_rfu <- predict(rf_u, ucla_test, type ="class")

table(pred_rfu, ucla_test$admit)
confusionMatrix(pred_rfu, ucla_test$admit)    # 랜덤포레스트 모델 정확도는 67퍼(0.671)(set.seed(2021) 기준)

pred_rfu
pred_dtu
ucla_test$admit                            #모델 예측값과 실제 관측값 비교 - 드릅게 못맞춘 것을 확인할 수 있다.

# svm 모델
svm_u <- svm(admit ~ . , ucla_train)

pred_svmu <- predict(svm_u, ucla_test, type = "class")

confusionMatrix(pred_svmu, ucla_test$admit)      # svm 모델 정확도는 67퍼(0.671)(set.seed(2021) 기준)

# k-nn모델
knn_u <- knn(ucla_train[, 1:3], ucla_test[, 1:3], ucla_train$admit, k=10)

knn_u
ucla_test$admit

confusionMatrix(knn_u, ucla_test$admit)          # knn 모델 정확도는 63퍼(0.633)(set.seed(2021) 기준)


########################################### Wine 데이터 가져와서 가공###############################################

wine <- read.table('data/wine.data.txt', sep = ',')
head(wine)

columns <- readLines('data/wine.name.txt')
columns

names(wine)               # V1 은 얻고자 하는 결과. 따라서 2번째 열부터 columns의 변수명을 적용하여 줌.

names(wine) [2:14] <- columns
names(wine)

names(wine)[2:14] <- substr(columns, 4, nchar(columns))     # [1] V1 이런 식으로 되어 있으므로 이름만 남기기 위해서 substr함수 사용.
names(wine)
names(wine)[1] <- 'Y'
names(wine)

wine$Y <- factor(wine$Y)

# train_set = sample_frac(wine, 0.75)
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
rf_w <- randomForest(Y ~ ., wine_train)      # Error in eval(predvars, data, env) : 객체 'Malic acid'를 찾을 수 없습니다(?) => 해결: 변수명에 공백 또는 사용할 수 없는 특수문자가 들어가는 경우 돌아가지 않음!
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

# 모델의 예측값과 실제 관측값 비교하여 보기.
pred_dtw
pred_rfw
pred_svmw
knn_w
wine_test$Y

# 각 모델의 정확도 확인하여 보기.
confusionMatrix(pred_dtw, wine_test$Y)    # 0.912
confusionMatrix(pred_rfw, wine_test$Y)    # 0.971 
confusionMatrix(pred_svmw, wine_test$Y)    # 1
confusionMatrix(knn_w, wine_test$Y)    # 0.706
