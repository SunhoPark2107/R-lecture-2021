# 단원문제

library(dplyr)
library(ggplot2)
library(gapminder)

# 1번 문제
##### 전체 관측 기간 (1952년~2007년) 중 1952년도의 인구 구성을 추출한 후 [그림 6-25]와 같이 시각화하라.


x <- gapminder %>% 
    filter(year == 1952) %>% 
    group_by(continent) %>%
    summarise(cont_pop = sum(pop)) %>% 
    arrange(desc(cont_pop))

pie(as.numeric(x$cont_pop), x$continent)   # as.numeric 해 주어야 하는 이유: R에서의 정수 범위는 -2^31에서 2^31-1 까지 이기 때문에
                                           # 21억이 넘어가면 정수로 인식하지 않는다.(overflow 에러 나는 이유.)
barplot(x$cont_pop, names.arg = x$continent)

# =================%>%(파이프) 뒤에는 첫번째 인자를 data frame으로 받는 애들만 들어올 수 있음.=========================

gapminder %>% 
    filter(year == 1952) %>% 
    group_by(continent) %>%
    summarise(cont_pop = sum(pop)) %>% 
    arrange(desc(cont_pop)) %>% 
    pie(as.numeric(cont_pop), continent)
# ====================================그래서 위에 코드는 에러남. ==========================================

##### 1952~2007년의 인구 구성을 for문을 이용하여 반복적으로 시각화하라.


gapminder %>% group_by(year) %>% summarise(cnt = n())



for (i in seq(1952, 2007, by = 5)) {
    x <- gapminder %>% 
        filter(year == i) %>% 
        group_by(continent) %>%
        summarise(cont_pop = sum(pop)) %>% 
        arrange(desc(cont_pop))
    
    print(x)
    
    pie(as.numeric(x$cont_pop), x$continent, main = paste(i, "Population Pie Chart"))
    barplot(x$cont_pop, names.arg = x$continent, main = paste(i, "Population Bar Chart"))
}


# - 1952년부터 아시아의 인구 수는 항상 1위였고, 2007년까지 아시아 인구의 비중은 지속적으로 증가하는 추세를 보임.
# - 이와 반대로 오세아니아의 인구 수는 항상 적었으며, 시간이 지날수록 인구 비중이 줄어듦.
# - 유럽의 인구 비중은 지속적으로 감소하였으며, 감소세가 모든 대륙 중 가장 뚜렷함.
# - 아프리카 대륙의 인구 비중은 지속적으로 증가하였음
# - 미국 인구 비중의 경우, 1952년부터 1972년까지는 꾸준히 증가하였으나, 이후로는 인구 증가세가 꺾여 2007년에는 아프리카보다 인구 비중이 적게 되었음.


# 3. ggplot2를 이용하여 Iris 데이터 셋에 대해서 다음 문제를 푸세요.
### 1) 품종별로 Sepal/Petal의 Length, Width 산점도 그리기. (총 6개)

a <- iris

# ggplot col , pch  설정
# => "변수"로 지정할 거면 aes에 포함하고,
# "고정값" 으로 줄 거면 geom_ () 에 포함시켜야 함. 왜이따구로 만들었어 프로그램 ㅡㅡ


iris %>%
    filter(Species == "setosa") %>% 
    ggplot(aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point(col = "Purple")

iris %>%
    filter(Species == "versicolor") %>% 
    ggplot(aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point(col = "Red")

iris %>%
    filter(Species == "virginica") %>% 
    ggplot(aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point(col = "Dark blue")
    
iris %>%
    filter(Species == "setosa") %>% 
    ggplot(aes(x = Petal.Length, y = Petal.Width)) +
    geom_point(col = "Purple")

iris %>%
    filter(Species == "versicolor") %>% 
    ggplot(aes(x = Petal.Length, y = Petal.Width)) +
    geom_point(col = "Red")

iris %>%
    filter(Species == "virginica") %>% 
    ggplot(aes(x = Petal.Length, y = Petal.Width)) +
    geom_point(col = "Dark blue")


    
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species, pch = Species))+
    geom_point()

ggplot(iris, aes(x = Petal.Length, y = Petal.Width, col = Species, pch = Species))+
    geom_point()


### 2) 품종별 Sepal/Petal의 Length/Width 평균을 비교하되
### 항목을 옆으로 늘어놓은 것(beside=T)과 위로 쌓아올린 것 2개를 그리시오.

iris %>% 
    group_by(Species) %>% 
    summarise(avg_slen = mean(Sepal.Length), avg_swid = mean(Sepal.Width)) %>% 
    ggplot(aes(x = avg_slen, y = avg_swid)) + geom_bar(stat = "identity")

### (총 12개 항목의 데이터를 2개의 그래프에)
### 3) 박스 플롯 그리기

