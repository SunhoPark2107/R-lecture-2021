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


# 대륙별 말고 걍 나라별로 하는거였슴... head() 로 상위 일부만 뽑아오는거였군...
x <- gapminder %>% 
    filter(year == 1952) %>% 
    select(country, pop) %>% 
    arrange(desc(pop)) %>% 
    head()

pie(as.numeric(x$pop), x$country) 
barplot(x$pop, names.arg = x$country)


# =================%>%(파이프) 뒤에는 첫번째 인자를 data frame으로 받는 애들만 들어올 수 있음.=========================

gapminder %>% 
    filter(year == 1952) %>% 
    group_by(continent) %>%
    summarise(cont_pop = sum(pop)) %>% 
    arrange(desc(cont_pop)) %>% 
    pie(as.numeric(cont_pop), continent)
# ====================================그래서 위에 코드는 에러남. ==========================================

##### 1952~2007년의 인구 구성을 for문을 이용하여 반복적으로 시각화하라.


for (i in seq(1952, 2007, 5)) {
    x <- gapminder %>% 
        filter(year == i) %>% 
        select(country, pop) %>% 
        arrange(desc(pop)) %>% 
        head()
    pie(as.numeric(x$pop), x$country)
    barplot(as.numeric(x$pop), names.arg = x$country)
    title(i)
}

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




#################################################################################
# 쌤이랑 문제 같이 풀기
#################################################################################

library(tidyr)                 # 여러 개의 변수를 하나의 변수로 묶어 주는 것.
                               # 모든 데이터를 일렬로 쫙 세워버리는것.
                               # (모든 변수들은 key 열로 들어가고, 거기에 속해있는 값들은 전부 value 열로 들어가!)

# 2-1 airquality
head(airquality)
str(airquality)
air_tidy <- gather(airquality, key = 'Measure', value = 'Value', -Day, -Month)
head(air_tidy)
tail(air_tidy)
dim(airquality)
dim(air_tidy)


air_tidy %>% 
    ggplot(aes(Day, Value, col=Measure)) +
    geom_point() +
    facet_wrap(~Month)

# 2-2 iris
iris_tidy <- gather(iris, key = 'feat', value = 'value', -Species)
head(iris_tidy)
tail(iris_tidy)

iris_tidy %>% 
    ggplot(aes(feat, value, col=Species)) + 
    geom_point(position='jitter')       # 지터Jitter는 데이터 값에 약간의 노이즈를 추가하는 방법을 말한다. 노이즈를 추가하면 데이터 값이 조금씩 움직여서 같은 값을 가지는 데이터가 그래프에 여러 번 겹쳐서 표시되는 현상을 막아준다.
                                        # 겹쳐진 데이터를 보이게 하는 다른 방법으로는 alpha = n 을 주는 방법도 있다.(투명도 조절)


# 3. ggplot2를 이용하여 Iris 데이터 셋에 대해서 다음 문제를 푸세요.
### 1) 품종별로 Sepal/Petal의 Length, Width 산점도 그리기. (총 6개)

library(gridExtra)
seto <- filter(iris, Species == 'setosa')
vers <- filter(iris, Species == 'versicolor')
virg <- filter(iris, Species == 'virginica')

seto_s <- seto %>% 
    ggplot(aes(Sepal.Length, Sepal.Width, col = Species)) +
    geom_point()

seto_p <- seto %>% 
    ggplot(aes(Petal.Length, Petal.Width, col=Species)) +
    geom_point()

vers_s <- vers %>% 
    ggplot(aes(Sepal.Length, Sepal.Width, col=Species)) +
    geom_point()

vers_p <- vers %>% 
    ggplot(aes(Petal.Length, Petal.Width, col=Species)) +
    geom_point()

virg_s <- virg %>% 
    ggplot(aes(Sepal.Length, Sepal.Width, col=Species)) +
    geom_point()

virg_p <- virg %>% 
    ggplot(aes(Petal.Length, Petal.Width, col=Species)) +
    geom_point()

grid.arrange(seto_s, seto_p, vers_s, vers_p, virg_s, virg_p, ncol = 2)


### 3-2) 품종별 Sepal/Petal의 Length/Width 평균을 비교하되
### 항목을 옆으로 늘어놓은 것(beside=T)과 위로 쌓아올린 것 2개를 그리시오.

# barplot + legend

seto_mean <- apply(iris[iris$Species == 'setosa', 1:4], 2, mean)
vers_mean <- apply(iris[iris$Species == 'versicolor', 1:4], 2, mean)
virg_mean <- apply(iris[iris$Species == 'virginica', 1:4], 2, mean)
mean_of_iris <- rbind(seto_mean, vers_mean, virg_mean)
mean_of_iris

# barplot(첫번째 데이터는 배열(matrix)형태여야 함. 위에서 mean_of_iris 는 rbind로 배열 형태가 되었음.)

barplot(mean_of_iris, beside = T, 
        main = '품종별 평균', ylim = c(0,8), col = c('red', 'green', 'blue'))

legend('topright',
       legend = c('Setosa', 'Versicolor', 'Virginica'),
       fill = c('red', 'green', 'blue'))

levels(iris$Species)

# ggplot으로 그리기

mean_of_iris     # 한 줄로 나래비를 세우기. (변수는 key열로 모여! 값은 value열로 모여!)

df <- iris %>% 
    group_by(Species) %>% 
    summarise(Sepal_length = mean(Sepal.Length), Sepal_width=mean(Sepal.Width),
              Petal_length=mean(Petal.Length), Petal_width = mean(Petal.Width))
df

df_tidy <- gather(df, key = 'Feature', value = 'Value', -Species)
df_tidy    
ggplot(df_tidy, aes(x = Feature, y = Value, fill = Species)) +           # bar 그래프에서는 col =  대신 fill = 로 사용한다.
    geom_bar(stat = 'identity')                                          # bar plot에서 stat = 'identity'는 선택사항 아닌 필수.

ggplot(df_tidy, aes(x = Feature, y = Value, fill = Species)) +
    geom_bar(stat = 'identity', position = 'dodge')


### (총 12개 항목의 데이터를 2개의 그래프에)
### 3) 박스 플롯 그리기

par(mflow=c(3, 1))    # 3행 1열의 그래프. 즉, 그래프를 세로로 3개 한 장면 안에 넣겠다는 것.

boxplot(seto$Sepal.Length, seto$Sepal.Width)


# ggplot 으로 그리기
seto_tidy <- gather(seto, key = 'Feature', value = 'Value', -Species)
head(seto_tidy)
s1 <- ggplot(seto_tidy, aes(x=Feature, y=Value, col = Feature)) +
    geom_boxplot() +
    ggtitle('Setosa')
s1
vers_tidy <- gather(vers, key = 'Feature', value = 'Value', -Species)
virg_tidy <- gather(virg, key = 'Feature', value = 'Value', -Species)

s2 <- ggplot(vers_tidy, aes(x=Feature, y=Value, col = Feature)) +
    geom_boxplot() +
    ggtitle('Versicolor')
s3 <- ggplot(virg_tidy, aes(x=Feature, y=Value, col = Feature)) +
    geom_boxplot() +
    ggtitle('Virginica')

grid.arrange(s1, s2, s3, ncol = 1)

