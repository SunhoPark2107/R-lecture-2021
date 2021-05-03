# Random Forest
# https://m.blog.naver.com/PostView.nhn?blogId=tjdudwo93&logNo=221046169123&proxyReferer=https:%2F%2Fwww.google.com%2F


library(caret)
install.packages("randomForest")
library(randomForest)


set.seed(1)
train_index <- createDataPartition(iris$Species, p=0.8, list = F)
iris_train <- iris[train_index, ]
iris_test <- iris[-train_index, ]

# 학습(모델링)
rf <- randomForest(Species ~ ., iris_train)
rf

# 예측
pred <- predict(rf, iris_test, type = 'class')
pred

# 평가
confusionMatrix(pred, iris_test$Species)

# 시각화
plot(rf)

# 여기까지가, hyperparameter주기 전까지 해야 할 것들.(하이퍼 매개변수)

# hyperparameter (하이퍼 매개변수)
small_forest <- randomForest(Species ~ ., iris_train,
                             ntree = 100, nodesize = 4)
s_pred <- predict(small_forest, iris_test, type = 'class')
confusionMatrix(s_pred, iris_test$Species)

plot(small_forest)
