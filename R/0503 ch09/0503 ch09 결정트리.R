# 분류(Classification)
# 결정 트리(Decision Tree)
library(rpart)

head(iris)
dtc <- rpart(Species ~ . , iris)   # iris 데이터를 결정 트리로 학습.
# decision tree classifier <- model(=rpart) (y~x, data, ...)
summary(dtc)   # 결정과정을 다 설명해주넴...
dtc

par(mfrow = c(1,1), xpd = NA)     # 글자 화면 맞춤.
plot(dtc)                         # 결정 트리 틀 그리기/
text(dtc, use.n = TRUE)           # 결정 트리 플롯에 dtc에 있는 텍스트 추가.

# 예측
pred <- predict(dtc, iris, type = 'class')
table(pred, iris$Species)

#평가
# install.packages("caret")
library(caret)
confusionMatrix(pred, iris$Species)

?rpart              # rpart는 많은 옵션을 가짐. 


# 결정 트리 시각화하기
# install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(dtc, type =2)   # type 숫자를 조정해 주면 식의 위치가 조정됨.

# 훈련/테스트 셋으로 분리하여 시행
set.seed(2021)  # seed넘버를 주고 시작하면 sample 함수를 몇 번을 시행하든 같은 값이 나오게 된다.
sample(1:10, 4)

set.seed(2021)
iris_index <- sample(1:nrow(iris), 0.8*nrow(iris))
iris_train <- iris[iris_index, ]
iris_test <- iris[setdiff(1:nrow(iris), iris_index),] # iris_test <- iris[-iris_index, ] 이렇게 해도 윗줄과 같은 결과가 나옴.
dim(iris_train)
dim(iris_test)
table(iris_train$Species)
table(iris_test$Species)


# 모델링
dtc <- rpart(Species ~ . , iris_train)

# 예측
pred <- predict(dtc, iris_test, type = 'class')

# 평가
confusionMatrix(pred, iris_test$Species)

# 비율대로 훈련/테스트 데이터셋 만들기
train_index <- createDataPartition(iris$Species, p=0.8, list = F)    # matrix형태로 불러올 것이므로 list = F
# ?createDataPartition
iris_train <- iris[train_index, ]
iris_test <- iris[-train_index, ]
table(iris_train$Species)
table(iris_test$Species)

# 학습
dtc <- rpart(Species ~ . , iris_train)          # 여기에 model명 자리에 lm, rpart, randomforest, knn 등등 적용하여 만들고 싶은 모델만 바꾸어 주면 밑에 과정은 모두 동일하거나 비슷함.

# 예측
pred <- predict(dtc, iris_test, type = "class")

# 평가
confusionMatrix(pred, iris_test$Species)

# 시각화

rpart.plot(dtc)

















