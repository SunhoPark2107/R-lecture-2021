

library(dplyr)
library(ggplot2)

galton_v <- read.table("http://www.randomservices.org/random/data/Galton.txt", sep = "", header = T)
galton_v


?mutate

g1 <- galton_v %>% 
    filter(Gender == "M") %>% 
    mutate("Height_cm" = 2.54 * Height) %>% 
    mutate("Father_cm" = 2.54 * Father) %>% 
    select(Father_cm, Height_cm)

g1 <- galton_v %>% 
    filter(Gender == "M") %>% 
    mutate("Height_cm" = 2.54 * Height, "Father_cm" = 2.54 * Father) %>% 
    select(Father_cm, Height_cm)


head(g1)

m <- lm(Height_cm~Father_cm, data = g1)

plot(g1)
abline(m, col = "purple", lwd = 3)     # g1 데이터 산점도 + 선형회귀모델 m 적용

coef(m)                                # 기울기랑 y절편. 즉 회귀식 y =  97.1776370x + 0.4477479

summary(m)                             # Father_cm    0.44775    0.04894    9.15   <2e-16 *** => p값이 0.05 이하이므로 두 변수간의 상관관계가 유의함. 그러나 Adjusted R-squared:  0.1513로 추정한 모델 m의 자료 적합도는 낮다.

fitted(m)                              # 잔차분석용...? 굳이 왜하는건지 모르겠음.

par(mfrow = c(2, 2))
plot(m)
par(mfrow = c(1,1))

deviance(m) / length(g1$Height_cm)     # 평균제곱오차


colors <- c('red', 'purple', 'dark orange', 'blue')
plot(g1)
x <- seq(150, 200, length.out = 501) 
for (i in 1:4) {
    m <- lm(Height_cm~poly(Father_cm, i), data = g1)
    assign(paste('m', i, sep = '.'), m)
    y <- predict(m, data.frame(Father_cm = x))
    lines(x, y, col = colors[i], lwd = 2)
}



anova(m.1, m.2, m.3, m.4)

summary(m.4)

summary(m.1)


