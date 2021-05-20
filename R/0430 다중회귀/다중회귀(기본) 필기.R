# 다중 선형 회귀 (p. 247)
# 영희의 물리 실험
install.packages(scatterplot3d)
library(scatterplot3d)

x <- c(3, 6, 3, 6.)
u <- c(10, 10, 20, 20.)
y <- c(4.65, 5.9, 6.7, 8.02)
scatterplot3d(x, u, y, xlim = 2:7, ylim = 7:23, zlim = 0:10, pch = 20, type = 'h')

model <- lm(y ~ x + u)       # 독립변수로 x와 u를 쓰겠다는 이야기. 즉, y = f(x, u) 라는 이야기 이다.
coef(model)                  # y = 0.428 * x + 0.209 * u + 1.26

s <- scatterplot3d(x, u, y, 
              xlim = 2:7, ylim = 7:23, zlim = 0:10,
              pch = 20, type = 'h')

s <- scatterplot3d(x, u, y,
                   pch = 20, type = 'h')

s$plane3d(model)

# 잔차

fitted(model)       # 우리가 만든 모델이 예측한 예측값.
y                   # 실제 값과는 약간씩의 차이가 있다.
residuals(model)    # y - fitted(model) 즉, 실제 값과 예측값과의 차이 "잔차" 이다.

# 평균제곱오차(mse)

mse = deviance(model) / length(y)
mse

# 새로운 데이터에 대한 예측
nx = c(7.5, 5)
nu = c(15, 12.)
new_data <- data.frame(x=nx, u=nu)
ny = predict(model, new_data)
ny


s <- scatterplot3d(nx, nu, ny, 
                   xlim = 0:10, ylim = 7:23, zlim = 0:10,
                   pch = 20, type = 'h', color = 'purple', angle = 60)
s$plane3d(model)

summary(model)

# trees 데이터
head(trees)
dim(trees)
summary(trees)

?trees
scatterplot3d(trees$Girth, trees$Height, trees$Volume, pch = 20, type = 'h', color = 'purple')

# 모델링
tm <- lm(Volume ~ Girth + Height, data = trees)
tm
summary(tm)

# 예측
ndata <- data.frame(Girth = c(8.5, 13, 19), Height = c(72, 86, 85.))
predict(tm, ndata)      # volume의 예측값이 나온다!

# 다중회귀분석
head(state.x77)
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)

summary(fit)
par(mfrow = c(2, 2))
plot(fit)
par(mfrow = c(1, 1))

# 다중공선성: 독립변수간 강한 상관관계가 나타나는 문제.
# Correlation (0.9 이상이면 다중공선성 의심.)

states.cor <- cor(states[2:5])
states.cor

# VIF(VAriation Inflation Factor) 계산 (10 이상이면 다중공선성 의심)
library(car)
vif(fit)

# Condition Number (15 이상이면 다중공선성의 가능성이 있음)  ==> 일단 지금은 안 해도 됨. 나중에 다시 배움,
eigen.val <- eigen(states.cor)$values
sqrt(max(eigen.val)/eigen.val)

fit1 <- lm(Murder ~ ., data = states)            # . 은 전체,
summary(fit1)

fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
summary(fit2)

# AIC(Akaike Information Criterion)
AIC(fit1, fit2)             # 값이 적을수록 좋은 모델이다.


# Backward stepwise regression, Forward stepwise regression  # 컴퓨터가 반복문 통해 알아서 최적모델 찾아주는 함수(?)
# 해당 사이트 참고. https://todayisbetterthanyesterday.tistory.com/34
# 변수별로 AIC 값을 찾는 것. (전진선택법 : 하나하나 추가해 보면서 최적 변수 찾아나가는 것.)
# 후진소거법 : p-value가 큰 것 부터 하나하나 지워나가면서 AIC 점수(?)를 통해 최적 변수 찾아나가는 것.


step(fit1, direction = 'backward')

# start: 변수 몽땅 다 가져와서 시작함. 추가해보면서 step 진행될수록 별로인 변수들 쳐냄.

fit3 <- lm(Murder ~ 1, data = states)
step(fit3, direction = 'forward', 
     scope = ~ Population + Illiteracy + Income + Frost)




library(leaps)
subsets <- regsubsets(Murder ~ . , data = states, method = 'seqrep', nbest = 4)
subsets <- regsubsets(Murder ~ . , data = states, method = 'exhaustive', nbest = 4)
summary(subsets)
plot(subsets)





















