# 데이터 시각화
library(gapminder)
library(dplyr)

y <- gapminder %>%
    group_by(year, continent) %>%
    summarise(c_pop=sum(pop))
head(y, 10)

# 그래프 그리기 전에는 어떻게 그릴 것인지 먼저 생각하기. (어떻게 그리는게 예쁜지)

# 1 단계 => 대충 그래프
# plot 기본은 산점도.
plot(y$year, y$c_pop)

# 2단계 - 마커에 색상을 대륙별로 부여.
plot(y$year, y$c_pop, col=y$continent, pch = 20)

# 3단계 - 마커의 모양을 대륙별로 다르게 지정.
plot(y$year, y$c_pop, col=y$continent, pch = c(1:5))

plot(y$year, y$c_pop, col=y$continent, pch = c(1:length(levels(y$continent))))   # 엔터 쳐봤을때 아래에 indentation되면 괄호가 어디 들닫힌거임!

#충주사과~~~~~~~~~~~~~

# R 스튜디오 괄호
# global option에서 code / display / rainbow 어쩌고 체크 하면 됨!

# 4단계 - 범례 표시
# legend('그래프 안에서 범례가 들어갈 위치 어디?', legend = 범례 몇개냐?, 모양, 컬러 범례 개수만큼. )
legend('topleft', legend = levels(y$continent),
       pch = c(1:length(levels(y$continent))),
       col = c(1:length(levels(y$continent))))

# 대륙별 인당 GDP, 기댓명
plot(gapminder$gdpPercap, gapminder$lifeExp,
     pch=c(1:length(levels(gapminder$continent))),
     col=gapminder$continent)

legend('bottomright',
       legend=levels(gapminder$continent),
       pch=c(1:length(levels(gapminder$continent))),
       col=c(1:length(levels(gapminder$continent))))

# 로그 스케일 적용
plot(log10(gapminder$gdpPercap), gapminder$lifeExp,
     pch=c(1:length(levels(gapminder$continent))),
     col=gapminder$continent)

legend('bottomright',
       legend=levels(gapminder$continent),
       pch=c(1:length(levels(gapminder$continent))),
       col=c(1:length(levels(gapminder$continent))))

# ggplot 을 이용하여 그리기
library(ggplot2)                                                              # aes는 aesthetic의 약자(심미적인)/ 디자인 함수 모음 이정도 뜻인듯
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent, size = pop)) +   # ggplot은 dplyr에서 %>% 이용하는 것 처럼 + 를 사용하여 이음.
    geom_point(alpha = 0.5) +                                                 # size = pop 이거는 인구수별로 크기를 다르게 지정해 준 것.
    scale_x_log10()                                                           # alpha = 투명도

# ggplot => 레전드 따로 지정 안 해 줘도 알아서 해 주고, 훨 깔끔하게 나옴. 컬러 세팅하는것도 훨씬 간편.
# 점 사이즈를 숫자로 일괄 조정할수도, 데이터 사이즈에 따라 달라지게 할 수도 있는 등 다양한 기능이 있다.

# 2007년도 자료만 보기 - dplyr 과 ggplot 연동하기.

gapminder %>%                        # ctrl+shift+M 누르면 파이프 단축키.
    filter(year == 2007) %>% 
    ggplot(aes(x=gdpPercap, y=lifeExp, col=continent, size = pop)) + 
    geom_point(alpha = 0.5) +                                                 
    scale_x_log10()

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent, size = pop)) + 
    geom_point(alpha = 0.5) +                                                 
    scale_x_log10() +
    facet_wrap(~year)


# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
# 또는 ggplot demo
# 다양한 ggplot 그래프 형태 및 코드 제시. 여기에서 골라서 코드 가져와서 쓰면 됨.
# 다 외울 필요 없어용~ 그래프 공부나 하세용~ 내가 뭔 그래프 써야하는지는 머리에 있어야 한다!

# 시각화 기본기능
# 1. 비교/순위

gapminder %>% 
    filter(continent == "Asia" & year == 1952) %>% 
    ggplot(aes(reorder(country, pop),pop)) +            # reorder로 pop 내림차순으로 정렬 가능.
    geom_bar(stat = 'identity') +
    coord_flip()                                        # x, y 축 반전

# 비교/순위 - 로그 스케일
gapminder %>% 
    filter(continent == "Asia" & year == 1952) %>% 
    ggplot(aes(reorder(country, pop),pop)) + 
    geom_bar(stat = 'identity') +
    scale_y_log10() +                                   # 데이터 y축 단위 변경.
    coord_flip()                                        # 축 반전

# 3. 변화 추세 점+선 그래프
gapminder %>% 
    filter(country == "Korea, Rep.") %>% 
    ggplot(aes(year, lifeExp)) +                       # 변수별로 색을 주고 싶다면 여기에 col = 변수명 을
    geom_point(col = "lightblue") +                    # 변수에 상관없잉 그래프에 색을 주고 싶다면 여기에 col = "color name" 을 추가.
    geom_line(col = "blue")

# 4. 여러 데이터의 변화 추세
ggplot(gapminder, aes(year, lifeExp, col = continent)) +
    geom_point(alpha = 0.2) +
    geom_smooth()                                           # 가로로 쭉 이어진 선 근처에 있는 회색 구간 => 신뢰구간! (95%) 표본수가 많을수록 넓다!

# 5. 분포 (히스토그램으로 나타낼 수 있다.)
x <- filter(gapminder, year == 1952)
hist(x$lifeExp, main='Histogram of lifeExp in 1952')    # 10등분으로 나뉘는 것이 디폴트이며 지정된 변수의 구간별 표본의 개수가 몇개인지(빈도) 나타내어 주는 것.

x %>% 
    ggplot(aes(lifeExp)) +
    geom_histogram()

# 6. 대륙별로 세분화된 분포 특성 (box plot)
x %>% 
    ggplot(aes(continent, lifeExp)) +
    geom_boxplot()

# 7. 상관 관계
plot(log10(gapminder$gdpPercap), gapminder$lifeExp)            # 양의 상관관계에 있다. (정비례 관계에 가깝다.)






