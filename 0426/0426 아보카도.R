# Avocado 사례

avocado <- read.csv("C:/workspace/R/data/avocado.csv")
str(avocado)
glimpse(avocado)

# 총 판매량과 평균 가격 속성을 지역별로 구분하여 요약(summarise, group_by)

avocado %>%
    group_by(region) %>%
    summarise(avg_price=mean(AveragePrice), sum_volume=sum(Total.Volume))

# 연도별 평균 판매량과 가격

avocado %>%
    group_by(region, year, type) %>%
    summarise(P_avg=mean(AveragePrice), V_avg=mean(Total.Volume))



# 그룹 단위 통계를 시각화
library(ggplot2)

avocado %>%
    group_by(region, year, type) %>%
    summarise(P_avg=mean(AveragePrice), V_avg=mean(Total.Volume)) %>%
    filter(region != 'TotalUS') %>%
    ggplot(aes(year, V_avg, col=type)) +
    geom_line() +
    facet_wrap(~region)

x_avg <- avocado %>%
    group_by(region, year, type) %>%
    summarise(P_avg=mean(AveragePrice),V_avg=mean(Total.Volume))
x_avg <- x_avg %>%
    filter(region != 'TotalUS')

# 데이터 명, col/row 명은 안 싸줘도 되지만 요소명은 꼭! 따옴표로 싸 주는 것 잊지 말기!
    
x_avg <- filter(x_avg, region != 'TotalUS')


arrange(x_avg, desc(V_avg)) %>% head(10)

avocado %>%
    filter(region == 'California' & year == 2018) %>%
    select(region, Date, AveragePrice, Total.Volume, type)

# 위에서 구한 2018 캘리포니아 데이터 월별 집계로 변경.

library(lubridate)   # lubridate : 날짜를 매끄럽게 다루기 위한 패키지. year, month, day, wday(weekday) 등의 함수를 포함한다. 문자형 데이터라도 날짜로 인식해 줌.(as.Date 쓸 필요 없다.)
ls(package:lubridate)

m_avg <- avocado %>%
    group_by(region, year, month(Date), type) %>%
    summarise(P_avg=mean(AveragePrice),V_avg=mean(Total.Volume))

head(m_avg)

avocado %>%
    filter(region == 'California' & year == 2018) %>%
    select(region, Date, AveragePrice, Total.Volume, type)
