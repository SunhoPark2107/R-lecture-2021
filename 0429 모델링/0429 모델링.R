# 현실 세계의 모델링
X = c(3, 6, 9, 12)
Y = c(3, 4, 5.5, 6.5)

plot(X, Y)


# model 1 : y = 0.5x + 1.0
Y1 = 0.5*X + 1
Y1

# 평균 제곱 오차 : Mean Squared Error

# ( 실제 관측된 식 값  - 모델링한 식 값 )^2 / N
# (구글에 mse나 평균제곱오차 쳐 보면 식 나옴.)

(Y - Y1) ^2
sum((Y - Y1) ^2)
mse <- sum((Y-Y1)^2) / length(Y)
mse

# model 2 : y = 5/12x + 7/4

Y2 = 5 * X / 12 + 7/4
Y2

mse2 <- sum((Y-Y2)^2) / length(Y)
mse2 

# 제곱 오차의 합 : Sum Squared Error

# R의 단순 선형회귀 모델 : Linear Model(LM)
model <- lm(Y ~ X)
model

plot(X, Y)
abline(model, col = "red")
fitted(model)
mse_model <- sum((Y - fitted(model))**2) / length(Y)
mse_model

# 잔차 - Residuals (예측값과 실제값과의 차이.)
# 선형회귀 - 잔차 분석

residuals(model)

# 잔차 제곱합
deviance(model)

# 평균제곱오차(MSE)
deviance(model) / length(Y)

summary(model)

# 예측
newX <- data.frame(X = c(1.2, 2.0, 20.65))
newX
newY <- predict(model, newdata = newX)
newY


# 연습문제 1 (p. 237)
# 1번
x <- c(10, 12, 9.5, 22.2, 8)
y <- c(360.2, 420, 359.5, 679, 315.3)
m <- lm(y ~ x)
summary(m)
plot(x, y, pch=1)
abline(m, col='red')

newx <- data.frame(x=c(10.5,25.0,15.0))
newy <- predict(m, newdata=newx)
newy

plot(newx$x, newy, pch=2)
abline(m, col='red')





# 단순 선형회귀의 적용
# Cars 데이터

str(cars)
plot(cars)
car_model <- lm(dist~speed, data = cars)
coef(car_model)
#회귀식: dist = 3.9324 * speed - 17.5791
abline(car_model, col = "red")

summary(car_model)
par(mfrow = c(2, 2))
plot(car_model)

# 속도가 21.5일 때, 제동거리는?

nx1 <- data.frame(speed = c(21.5))              # 숫자값이 하나더라도 데이터 프레임으로 만들어 주어야 한다.
predict(car_model, nx1)

# 고차식(polynomial)을 적용하면 어떻게 될까?

lm2 <- lm(dist~poly(speed, 2), data = cars)
plot(cars)

# 2차식으로 그래프 그리는 방법
x <- seq(4, 25, length.out = 211)                 # 25에서 4를 빼면 21이므로 0.1단위로 올라가게 하려면 length.out = 211주면 됨.


y <- predict(lm2, data.frame(speed = x))
lines(x, y, col = 'purple', lwd = 2)
abline(car_model, col = "red", lwd = 2)

summary(lm2)

# cars 1차식부터 4차식까지

x <- seq(4, 25, length.out = 211) 
colors <- c('red', 'purple', 'dark orange', 'blue')
plot(cars)
for (i in 1:4) {
    m <- lm(dist~poly(speed, i), data = cars)
    assign(paste('m', i, sep = '.'), m)
    y <- predict(m, data.frame(speed = x))
    lines(x, y, col = colors[i], lwd = 2)
}

summary(m.4)

# 분산 분석(anova)
anova(m.1, m.2, m.3, m.4)

# Women Data
women
plot(women)
m <- lm(weight~height, data = women)
abline(m, col = "red", lwd = 2)
summary(m)

# 2차식으로 모델링

m2 <- lm(weight ~ poly(height, 2), data = women)
x <- seq(58, 72, length.out = 300)
y <- predict(m2, data.frame(height = x))
lines(x, y, col = "blue", lwd = 2)

summary(m2)
