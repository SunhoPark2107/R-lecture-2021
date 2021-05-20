# Anscombe's Quartet
head(anscombe)

# 평균
apply(anscombe, 2, mean)
# 분산
apply(anscombe, 2, var)

# 상관관계
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)

for(i in 1:4) {
    ans_cor <- cor(anscombe[, i], anscombe[, i+4])
    print(ans_cor)
}

# 요약
summary(anscombe)

# 여러 개의 그래프 하나의 코드로 그리기

library(ggplot2)
library(gridExtra) 


# 산점도랑 선 그래프 한 그래프 안에 포함시켜 그릴 수 있다.

p1 <- ggplot(anscombe) + 
    geom_point(aes(x1, y1), color = 'darkorange' , size = 3) +
    scale_x_continuous(breaks = seq(2, 20, 2 )) +                     # scale_x_continuous(breaks = seq(2, 20, 2)) => 축 간격 설정.
    scale_y_continuous(breaks = seq(2, 14, 2)) +
    xlim(2, 20) +                                                     # x, y축 범위 설정.
    ylim(2, 14)+
    geom_abline(slope = 0.5, intercept = 3,
                color = 'cornflowerblue', size = 1) + 
    labs(title = 'Dataset Ⅰ')


p2 <- ggplot(anscombe) + 
    geom_point(aes(x2, y2), color = 'darkorange' , size = 3) +
    scale_x_continuous(breaks = seq(2, 20, 2 )) + 
    scale_y_continuous(breaks = seq(2, 14, 2)) +
    xlim(2, 20) +
    ylim(2, 14)+
    geom_abline(slope = 0.5, intercept = 3,
                color = 'cornflowerblue', size = 1) + 
    labs(title = 'Dataset Ⅱ')

p3 <- ggplot(anscombe) + 
    geom_point(aes(x3, y3), color = 'darkorange' , size = 3) +
    scale_x_continuous(breaks = seq(2, 20, 2 )) + 
    scale_y_continuous(breaks = seq(2, 14, 2)) +
    xlim(2, 20) +
    ylim(2, 14)+
    geom_abline(slope = 0.5, intercept = 3,
                color = 'cornflowerblue', size = 1) + 
    labs(title = 'Dataset Ⅲ')


p4 <- ggplot(anscombe) + 
    geom_point(aes(x4, y4), color = 'darkorange' , size = 3) +
    scale_x_continuous(breaks = seq(2, 20, 2 )) + 
    scale_y_continuous(breaks = seq(2, 14, 2)) +
    xlim(2, 20) +
    ylim(2, 14)+
    geom_abline(slope = 0.5, intercept = 3,
                color = 'cornflowerblue', size = 1) + 
    labs(title = 'Dataset Ⅳ')

library(gridExtra)                                                            # gridExtra 패키지를 설치해야 함.
grid.arrange(p1, p2, p3, p4, ncol = 2, top = "Anscombe's Quartet")            # ggplot으로 그래프 여러 개를 한 그래프 안에 그리는 것.

# Refactoring (동일한 코드 반복시 하나의 코드로 합치는 것.)

figures <- list()
figures <- append(figures, p1)
figures <- append(figures, p2)
figures <- append(figures, p3)
figures <- append(figures, p4)
figures[1]

# Source Refactoring
x <- ggplot(anscombe) + 
    geom_point(aes(x1, y1), color = 'darkorange' , size = 3)

m1 <- x

assign(paste('m', 1, sep = '.'), x)       # 사용자가 임의의 변수 설정하는 함수. assign for loop을 사용하기 위한 전처리.


for (i in 1:4) {
    x <- ggplot(anscombe) + 
        geom_point(aes(anscombe[, i], anscombe[, 4+i]), color = 'darkorange' , size = 3) + # x1 열 값 전체, y1 열 값 전체. (열 = 변수, 행 = element)
        scale_x_continuous(breaks = seq(2, 20, 2)) +                     # scale_x_continuous(breaks = seq(2, 20, 2)) => 축 간격 설정.
        scale_y_continuous(breaks = seq(2, 14, 2)) +
        xlim(2, 20) +                                                     # x, y축 범위 설정.
        ylim(2, 14)+
        geom_abline(intercept = 3, slope = 0.5,
                    color = 'cornflowerblue', size = 1) + 
        labs(title = paste0('Dataset ', i),
             x = paste0('x', i), y = paste0('x', i))
    assign(paste('m', i, sep = '.'), x)
}

grid.arrange(m.1, m.2, m.3, m.4, ncol=2, top = "Anscombe Quartet")


anscombe

# 마지막으로 한 애 에러남... dataset 4 그래프만 4개 출력됨 헝헝 ㅠ

# 오늘 필기한게 어쩌다 보니 좀 개더러움... ㅠㅠㅠㅠㅠㅠㅠㅠㅠ 우짤수없...















p1 <- ggplot(anscombe) + 
    geom_point(aes(x1, y1), color = 'darkorange' , size = 3) +
    scale_x_continuous(breaks = seq(2, 20, 2 )) +
    scale_y_continuous(breaks = seq(2, 14, 2)) +
    xlim(2, 20) +
    ylim(2, 14) +
    geom_abline(intercept = 3, slope = 0.5)

# 회귀 그래프
# 회귀식 : y = 0.5x + 3
# 직선 그리는 식: y = ax + b (a는 기울기, b는 y절편(?맞나))





