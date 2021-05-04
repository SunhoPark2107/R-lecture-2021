# 10단원 연습문제
# 오늘만 지나면 노는날이다 조금만 참자...!!!!!!!

library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(class)

# 01 colon 데이터에 랜덤 포레스트를 적용하는데, k-nn 교차검증을 k = 5, 10, 15, 20으로 바꾸어 가면서 적용하라.
# 각각의 혼돈 행렬과 정확률을 제시하라.
# 필수 => colon 데이터 읽어보기!! => status가 구하고자 하는 y값이 됨.(0이 완치, 1은 재발 또는 사망.)
# install.packages("survival")
library(survival)
# p. 353의 전처리 방법 따라함.
str(colon)
clean_colon <- na.omit(colon)
clean_colon <- clean_colon[c(T, F), ]
clean_colon$status <- factor(clean_colon$status)
fomular <- status~rx+sex+age+obstruct+perfor+adhere+nodes+differ+extent+surg+node4

###################################################################

set.seed(2021)
data <- clean_colon[sample(nrow(colon)), ]

control <- trainControl(method = 'cv', number = 5)

rf05 <- train(fomular, data = clean_colon, method = 'rf')

set.seed(2021)
data <- clean_colon[sample(nrow(colon)), ]

control <- trainControl(method = 'cv', number = 10)

rf10 <- train(fomular, data = clean_colon, method = 'rf')

set.seed(2021)
data <- clean_colon[sample(nrow(colon)), ]

control <- trainControl(method = 'cv', number = 15)

rf15 <- train(fomular, data = clean_colon, method = 'rf')

set.seed(2021)

data <- clean_colon[sample(nrow(colon)), ]

control <- trainControl(method = 'cv', number = 20)

rf20 <- train(fomular, data = clean_colon, method = 'rf')  
###################################################################

set.seed(2021)
train_index <- createDataPartition(clean_colon$status, p=0.8, list = F)
colon_train <- clean_colon[train_index, ]
colon_test <- clean_colon[-train_index, ]

rf <- randomForest(fomular, colon_train)  


# 02 353~356의 과정을 ucla 데이터에 대해 수행하여라.
# 모델 선택하고 하이퍼 매개변수 최적화하기기

ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')

























