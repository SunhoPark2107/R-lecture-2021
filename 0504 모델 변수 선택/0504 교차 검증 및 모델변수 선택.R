# 교차 검증(Cross Validation)
library(caret)
# iris 데이터를 무작위 순서로 섞기.
set.seed(2021)                   # 데이터를 무작위로 섞되, 섞인 데이터 셋은 고정.
data <- iris[sample(nrow(iris)), ]
head(data)
tail(data)

# K-Fold CV, k = 5
k = 5
q = nrow(data)/k    # 150개를 k로 나누었으니 30이 나옴.
l = 1:nrow(data)    # 1부터 150까지.

acc = 0        # for loop문을 위한 초기값 지정.
for (i in 1:k) {
    test_list <- ((i-1)*q+1) : (i*q)                        # 1:30, 31:60, 61:90, 91:120, 121:150
    data_test <- data[test_list, ]                          # 위와 같이 지정된 test_list를 data_test(테스트 셋)으로 지정. 
    data_train <- data[-test_list, ]                        # train_set을 제외한 데이터는 모두 data_train(훈련 셋)으로.
    rf <- train(Species ~ . , data_train, method = 'rf')    # 훈련 데이터를 method = "rf", 즉 랜덤 포레스트로 훈련하는 행동을 rf로 저장함. 참고로 train 함수는 caret라이브러리에 포함되어 있는 함수이다.
    pred <- predict(rf, data_test)                          # rf 학습된 모델로 예측.
    t <- table(pred, data_test$Species)                     # 예측모델 뽑기.
    acc <- acc + (t[1,1] + t[2,2] + t[3,3])/ nrow(data_test)# (예측모델의 예측 적중 수/테스트 셋 개수)는 accuracy 로 저장.
}

average_accuracy <- acc / k     # k개의 예측모델을 만들었으니 정확도도 k개로 나눔.
average_accuracy

#########################################################################
# Caret 라이브러리를 이용한 코드
#########################################################################
control <- trainControl(method = 'cv', number = 5)
new_rf <- train(Species ~ . , data=iris, method='rf',
                metric = 'Accuracy', trControl=control)
confusionMatrix(new_rf)                                        # 위에 forloop문은 원리를 알아보기 위한 것이었고, 실제 사용시에는 이 코드로 사용!

#########################################################################
# 모델 선택 => 여러 개 모델의 평가를 간편하게 하는 법!(4개 모델에 적용.)
#########################################################################
control <- trainControl(method = 'cv', number = 5)
dt <- train(Species ~ ., data = iris, method = 'rpart',
            metric = 'Accuracy', trControl=control)
rf <- train(Species ~ ., data = iris, method = 'rf',
            metric = 'Accuracy', trControl=control)
sv <- train(Species ~ ., data = iris, method = 'svmRadial',
            metric = 'Accuracy', trControl=control)
kn <- train(Species ~ ., data = iris, method = 'knn',
            metric = 'Accuracy', trControl=control)

dotplot(resample)

resample <- resamples(list(결정트리 = dt, 랜덤포레스트 = rf, SVM = sv, KNN = kn))   # resample이라는 변수에 resamples 함수로 리스트 지정해 주어 묶는다.
summary(resample)
sort(resample, decreasing = T)             # accuracy가 큰 순서대로 정렬.
