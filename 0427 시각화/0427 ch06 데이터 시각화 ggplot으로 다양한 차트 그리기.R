# 시각화 도구
# 1. plot
library(dplyr)
library(ggplot2)
library(gapminder)

head(cars)
plot(cars, type = 'p', main='cars')          # type='p' 는 산점도, main='cars' 는 제목을 cars로 지정. 해당 그래프는 양의 상관관계에 있다고 볼 수 있음.
plot(cars, type = 'l', main='cars') 
plot(cars, type = 'b', main='cars')          # type='b' 는 both point and line
plot(cars, type = 'h', main='cars')          # h-히스토그램과 같은 막대 그래프

# pie & bar plot

x <- gapminder %>% 
    filter(year == 1952, continent == 'Asia') %>% 
    mutate(gdp = gdpPercap * pop) %>% 
    select(country, gdp) %>% 
    arrange(desc(gdp)) %>% 
    head()
x

pie(x$gdp, x$country)
barplot(x$gdp, names.arg = x$country)


x <- gapminder %>% 
    filter(year == 2007, continent == 'Asia') %>% 
    mutate(gdp = gdpPercap * pop) %>% 
    select(country, gdp) %>% 
    arrange(desc(gdp)) %>% 
    head()
x

pie(x$gdp, x$country)
barplot(x$gdp, names.arg = x$country)


# 3. matplot

matplot(iris[,1:4], type = 'l')
legend('topleft', names(iris)[1:4],
       lty=c(1:4),                             # lty 는 line type
       col=c(1:4))                             # 이거 두개 지정해 주어야 범례에 라인타입이랑 색깔도 같이 나온당

# 4. hist - 히스토그램
hist(cars$speed)
hist(iris$Sepal.Length)

# ggplot2 라이브러리
# 1. geom_histogram - stack 형태가 디폴트. (위로 쌓는 것.)
gapminder %>% 
    filter(year == 2007) %>% 
    ggplot(aes(lifeExp, col=continent)) +
    geom_histogram(position='dodge')                 # position = 'dodge' 설정해 주면 stack이 아니라 bar가 겹치지 않는 형태로 됨.

# geom_boxplot
gapminder %>% 
    filter(year == 2007) %>% 
    ggplot(aes(continent, lifeExp, col = continent)) +
    geom_boxplot()

# 3. scale_x_log10(), scale_y_log10()
ggplot(gapminder, aes(gdpPercap, lifeExp, col = continent)) +
    geom_point(alpha = 0.2)

ggplot(gapminder, aes(gdpPercap, lifeExp, col = continent)) +
    geom_point(alpha = 0.2) +
    scale_x_log10()

# 4. coord_flip() - x축 y축을 뒤집는 것.
gapminder %>% 
    filter(continent == 'Africa') %>% 
    ggplot(aes(country, lifeExp, col = country)) +
    geom_bar(stat = 'identity') +
    coord_flip()

# 5 scale_fill_brewer() - 컬러 팔레트 바꾸고 싶을 때 사용.
library(RColorBrewer)
display.brewer.all()     # R이 제공하는 컬러 팔레트 종류가 나옴.

# 기본 팔레트
gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent))

# spectral 팔레트

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'Spectral')

# Blues 팔레트

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'Blues')

# RdBu 팔레트

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(continent, n)) +
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'RdBu')

# 그래프 표시 순서

gapminder %>% 
    filter(lifeExp > 70) %>% 
    group_by(continent) %>% 
    summarise(n=n_distinct(country)) %>% 
    ggplot(aes(reorder(continent, n), n)) +                    # n 의 순서(오름차)로 정렬. 내림차로 하고 싶다면 reorder(continent, -n)으로 하면 됨.
    geom_bar(stat = 'identity', aes(fill = continent)) +
    scale_fill_brewer(palette = 'RdBu')





