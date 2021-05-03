# 일반화 선형 모델
# 로지스틱 회귀 - UCLA admission data
ucla <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
str(ucla) # 데이터 분석 할 때는 범주형(admit, rank)이 int로 되어 있을 경우 factor(범주)로 바꾸어 주어야 함.

lr <- glm(admit~ . , data = ucla, family = binomial)    # . 은 gre + gpa + rank
coef(lr)

test <- data.frame(gre=c(376), gpa = c(3.6), rank = c(3))
predict(lr, test, type = 'response')  # newdata = test인데, "newdata =" 는 생략 가능.
# 결과는 0.1869631. 즉, 불합격이라는 이야기.

# model(y~x, data, hyper-parameter) => hyper-parameter는 모델의 과적합을 막기 위한 규제로, 연구자가 데이터를 연구하여 설정해 주어야 한다.

# ucla 데이터 셋 train/test data set으로 분할

train_index <- sample(1:nrow(ucla), 0.8 * nrow(ucla))       # 80퍼센트를 훈련 셋으로 설정.
test_index <- setdiff(1:nrow(ucla), train_index)
ucla_train <- ucla[train_index, ]
ucla_test <- ucla[test_index, ]
dim(ucla_train)
dim(ucla_test)

# 분할 비율은 적절한가?
table(ucla$admit)
127/400 # 31.75%
table(ucla_train$admit)
101/320 # 31.5625%

# 훈련 데이터셋으로 학습, 테스트 데이터 셋으로 예측(평가). (모델링 원칙!)
lr <- glm(admit~. , ucla_train, family = binomial)
pred <- predict(lr, ucla_test, type = 'response')
pred
ucla_test$admit



























