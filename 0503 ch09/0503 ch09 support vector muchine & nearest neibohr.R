# 서포트 벡터 머신
library(caret)
library(e1071)

set.seed(2021)
train_index <- createDataPartition(iris$Species, p=0.8, list = F)
iris_train <- iris[train_index, ]
iris_test <- iris[-train_index, ]

# 모델링
svc <- svm(Species ~ ., iris_train)

# 예측
pred <- predict(svc, iris_test, type = 'class')

# 평가
confusionMatrix(pred, iris_test$Species)
table(pred, iris_test$Species)          # 이렇게 하면 confusionmatrix에서 딱 몇개 틀리고 맞았나 테이블만 출력됨. 어차피 confusionmatrix에서도 볼것은 accuracy밖에 없으므로 이렇게 해도 딱히...

# hyper_parameter C (cost)
svc100 <- svm(Species ~ ., iris_train, cost = 100)
pred100 <- predict(svc100, iris_test, type = 'class')
table(pred100, iris_test$Species) # 일반화 능력이 오히려 떨어졌음을 알 수 있음.

svc001 <- svm(Species ~ ., iris_train, cost = 0.01)
pred001 <- predict(svc001, iris_test, type = 'class')
table(pred001, iris_test$Species)

self100 <- predict(svc100, iris_train, type = 'class')
table(self100, iris_train$Species)

selfd001 <- predict(svc001, iris_train, type = 'class')
table(selfd001, iris_train$Species)


# ↑ C 값에 따라 변화하는 훈련집합 오류율 및 테스트 집합에 대한 오류율(일반화 능력) 확인할 수 있다.


# K-NN(Nearest Neighbor)

library(class)
k <- knn(iris_train[ , 1:4], iris_test[ , 1:4], 
         iris_train$Species, k=5)
k
iris_test$Species                           # knn결과랑 원본 데이터랑 비교해보기.

confusionMatrix(k, iris_test$Species)


# train 함수로 코딩하기
library(caret)
library(randomForest)
library(svmRadial)
dt <- train(Species ~ . , data = iris, method = 'rpart')
rf <- train(Species ~ . , data = iris, method = 'randomForest')
sv <- train(Species ~ . , data = iris, method = 'svmRadial')
kn <- train(Species ~ . , data = iris, method = 'knn')

names(getModelInfo())







