# dplyr 라이브러리를 이용한 데이터 가공
# 우리가 알아야 할 dplyr 함수들
# filter, select, arrange, summarize(group_by) , mutate
# 행 추출, 열 추출, 정렬(오름차(ascending, default값), 내림차(descending)), 데이터를 변수별로 묶어서 연산값을 출력 , 데이터를 새로운 열로 생성.
# %>% (함수를 가독성 있고 편하게 쓰기 위한 것. 다른 함수와 이어 줄 수 있어 직관적으로 코드를 짤 수 있다.)

library(dplyr)
library(gapminder)

# 1. select - 원하는 열을 추출.
select(gapminder, country, year, lifeExp)
select(gapminder, country, year, lifeExp) %>% head()
select(gapminder, country, year, lifeExp) %>% head(10)

# filter - 원하는 행을 추출.
filter(gapminder, country == 'Croatia')
filter(gapminder, country == 'Croatia' & year >= 2000)
filter(gapminder, continent == 'Europe' & year == 2007)

# 3. arrange - 정렬, 디폴트는 오름차순.(asc)
europe_pop <- filter(gapminder, continent == 'Europe' & year == 2007)
arrange(europe_pop, lifeExp)
arrange(europe_pop, desc(lifeExp))
# 아프리카 대륙에서 2007년 평균 수명 상위 5개국을 구하여라.
africa_pop <- filter(gapminder, continent == 'Africa' & year == 2007)
arrange(africa_pop, desc(lifeExp)) %>% head(5)

# 파이프로 따로 변수지정 안 하고, 한 줄로 줄일 수 있음.
filter(gapminder, continent == 'Africa' & year == 2007) %>% arrange(desc(lifeExp)) %>% head(5)
gapminder %>% filter(continent == 'Africa' & year == 2007) %>% arrange(desc(lifeExp)) %>% head(5) # 가장 많이 쓰는 패턴.

# 4. group_by 와 summarize
summarize(africa_pop, pop_avg=mean(pop))                        # 2007년 아프리카 국가별 평균 인구 수 
summarize(group_by(gapminder, continent), pop_avg=mean(pop))    # 대륙별 인구평균(*얘는 연도 지정은 안 된 것!)
summarize(group_by(gapminder, country), life_avg=mean(lifeExp)) # 나라별 평균 기대수명

asia_pop <- gapminder %>%
    filter(continent == 'Asia')
summarize(group_by(asia_pop, country), life_avg=mean(lifeExp)) %>%
    arrange(desc(life_avg))%>%
    head(5)

#연습(책에 안 나온 부분)
#mag(mile-per-gallon) 데이터, ggplot2 라이브러리 사용.

library(ggplot2)
head(mpg)
?mpg

glimpse(mpg)               # 데이터 훑어보기
summary(mpg)               # 요약 통계량
str(mpg)                   

# 통합 연비 변수 컬럼 추가.
mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)
mpg$total
summary(mpg$total)
hist(mpg$total)

# 평균연비가 20 이상이면 합격, 아니면 불합격
mpg$test <- ifelse(mpg$total >= 20, 'pass', 'fail')
table(mpg$test)
head(mpg)
qplot(mpg$test)

# 평균연비가 30 이상이면 A등급, 20이상이면 B등급, 아니면 C등급.
mpg$grade <- ifelse(mpg$total >= 30, 'A', 
                    ifelse(mpg$total >= 20, 'B', 'C'))

table(mpg$grade)
mpg

# mutate
mpg %>%
    mutate(grade2 = ifelse(mpg$total >= 30, 'A', 
                           ifelse(mpg$total >= 20, 'B', 'C')))

table(mpg$grade2)       # 결과 나오지 않음. 왜냐면 grade2는 mpg라는 데이터 세트에 저장되어있지 않기 때문.

# 일시적으로 grade2라는 변수를 생성.
# 영구적으로 grade2라는 변수를 만들고 싶다면 데이터에 mutate결과를 저장.
mpg <- mpg %>%
    mutate(grade2 = ifelse(mpg$total >= 30, 'A', 
                           ifelse(mpg$total >= 20, 'B', 'C')))

table(mpg$grade2)
