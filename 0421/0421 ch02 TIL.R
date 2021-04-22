women
plot(women)
str(cars)

# 두 줄을 선택한 후 상단에 있는 'Run' 버튼을 누르면 한꺼번에 실행됨.
a <- 2
b <- a*a

# 작업 디렉토리 지정
getwd()
setwd('/workspace/R')
getwd()

library(dplyr)
library(ggplot2)
search()

str(iris)
head(iris)          #Default는 6개 관측치. head는 앞에서부터 일부 데이터를 출력하여 준다,
head(iris,10)       #지정 가능.

tail(iris)          #head와 반대로 tail은 끝에서부터 일부 데이터를 출력하여 준다.

plot(iris)

# 두 속성의 상관 관계 length 와 width에 따른 종 산점도
plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species, pch=18, title("iris is beautiful"))

# 종이 각각 어떤 색으로 표현되어있는지 알기 위해 범례(legend) 띄워야 함.
# 너무 어려워서 다음에 하기로 한다. ㅋㅋㅋ

# 페이지 65 tips 실습

tips=read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)
head(tips)

# 요약 통계 보는 방법
summary(tips)

# ggplot2 그림 그려보기
tips %>% ggplot(aes(size))+geom_histogram()
tips %>% ggplot(aes(total_bill, tip))+geom_point()
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day))
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day, pch=sex), size=3)

# 시간대별(점심, 저녁) tip 분포.
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day, pch=time), size=3)

tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day, pch=time), size=3) + labs(title="Tips by two conditions")

