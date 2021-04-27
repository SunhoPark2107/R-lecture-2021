
library(ggplot2)
library(dplyr)


# 연습문제 1. 배기량에 따른 고속도로 연비. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.

mpg %>%
    filter(displ %in% c('<=4', '>=5')) %>%
    group_by(displ) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))


asia_pop <- gapminder %>%
    filter(continent == 'Asia')

dis4 <- c(mpg$displ >= 4)
dis5 <- c(mpg$displ >= 5)

mpg %>%
    filter(displ %in% c(dis4, dis5)) %>%
    group_by(displ) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))

# ========================실패작 절취선=============================

mpg_finddispl <- mpg %>%
    mutate(displgrade2 = ifelse(mpg$displ <= 4, 'A', 'B'))

mpg_finddispl %>%
    group_by(displgrade2) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))


# ============= 위에서 나온 거 한 줄로 나오게 합쳐도 됨.=====================   범주형이 나오면 mutate 활용할 생각을 하자!
mpg %>%
    mutate(displ45=ifelse(dspl <= 4, 'dspl4', 'dspl5')) %>%
    group_by(displ45) %>%
    summarise(avg_hwy = mean(hwy)) %>%
    arrange(desc(avg_hwy))



# 연습문제 2 자동차 제조 회사에 따라, audi, toyota 두 자동차 제조업체의 cty연비의 평균을 비교.
# 식: audi, toyota만 추출한 뒤 두개를 그룹으로 묶어 cty평균으로 요약하여 출력.

mpg %>%
    filter(manufacturer %in% c('audi', 'toyota')) %>%
    group_by(manufacturer) %>%
    summarise(avg_cty=mean(cty)) %>%
    arrange(desc(avg_cty))                               # 큰거부터 정렬하기. (상위 ~)

# 연습문제 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다.
# 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요.

mpg %>%
    filter(manufacturer %in% c('chevrolet', 'ford', 'honda')) %>%
    group_by(manufacturer) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))

# 전체 평균을 구하여라...? 제조사별로 비교하는게 아닌가?
mpg %>%
    filter(manufacturer %in% c('chevrolet', 'ford', 'honda')) %>%
    summarise(avg_hwy=mean(hwy))

# 연습문제 4. mpg 데이터는 11개 변수로 구성되어 있습니다. 이 중 일부만 추출해서 분석에 활용하려고 합니다.
# mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 새로운 데이터를 만드세요.
# 새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요.

class_cty <- mpg %>%
    select(class, cty)                     # 변수(열) 추출은 select

head(class_cty)

# 5. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다.
# 앞에서 추출한 데이터를 이용해서 class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중
# 어떤 자동차의 cty(도시 연비)가 더 높은지 알아보세요.

class_cty %>%
    filter(class %in% c('suv', 'compact')) %>%
    group_by(class) %>%
    summarise(avg_cty = mean(cty))%>%
    arrange(desc(avg_cty))


# 연습문제 6. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다.
# "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.

audimpg <- mpg %>% 
    filter(manufacturer == "audi") %>%
    arrange(desc(hwy))

head(audimpg, 5)           # audi 자동차들을 hwy 높은 순으로 배열시킨 다음 이 배열에서 5개만 출력.

audimpg[1:5, "model"]      # "model" 열만 :뽑고 싶다면 head 대신.



# 7. mpg 데이터는 연비를 나타내는 변수가
# hwy(고속도로 연비), cty(도시 연비) 두 종류로 분리되어 있습니다.
# 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 분석하려고 합니다.
# 1) mpg 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.
# 2) 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요.
# 3) '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
# 4) 1)~3)번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 데이터는 복사본 대신 mpg 원본을 이용하세요.

mpg_copy <- mpg %>% 
    mutate(mer_FE = cty + hwy) %>%      # 1) 합산연비변수 mer_FE
    mutate(avg_FE = mer_FE / 2)         # 2) 평균연비변수 avg_FE

head(arrange(mpg_copy, desc(avg_FE)),3) # 3) 평균 연비 변수가 가장 높은 자동차 3종의 데이터 전체.
arrange(mpg_copy, desc(avg_FE))[1:3, ]  # 인덱싱도 됨.
# 혹시 "model" 만 출력하는 거라고 한다면

arrange(mpg_copy, desc(avg_FE)) %>%
    select(model) %>%
    head(3)

arrange(mpg_copy, desc(avg_FE))[1:3, "model"]


# 4) 번 문제
mpg %>%
    mutate(mer_FE = (cty + hwy), avg_FE = (mer_FE / 2)) %>%
    arrange(desc(avg_FE)) %>%
    head(3)


# 8. mpg 데이터의 class는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다.
# 어떤 차종의 연비가 높은지 비교해보려고 합니다. class별 cty 평균을 구해보세요.


mpg %>%
    group_by(class) %>%
    summarise(avg_cty = mean(cty))



# 연습문제 9. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다.
# 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력하세요.

mpg %>%
    group_by(class) %>%
    summarise(avg_cty = mean(cty)) %>%
    arrange(desc(avg_cty))

# 연습문제 10. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다. hwy 평균이 가장 높은 회사 세 곳을 출력하세요.

mpg %>%
    group_by(manufacturer) %>%
    summarise(avg_hwy = mean(hwy)) %>%
    arrange(desc(avg_hwy)) %>%
    head(3)


# 11. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다.
# 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

mpg %>%
    filter(class=="compact") %>%
    group_by(manufacturer) %>%
    tally() %>%
    arrange(desc(n))

mpg %>%
    filter(class == 'compact') %>%
    group_by(manufacturer) %>%
    summarise(number_mpg = n()) %>%                      # n_distinct / 중복된 행을 제외하고 행을 세어 주는 것.
    arrange(desc(number_mpg))                            # n / 행의 개수를 세어 주는 것.

    

# (1)  dataframe %>% group_by(factor) %>% summarise(n = n())

# (3) dataframe %>% group_by(factor) %>% tally()

# 출처: https://rfriend.tistory.com/240 [R, Python 분석과 프로그래밍의 친구 (by R Friend)]


mpg %>% 
    mutate(HwCty = (hwy + cty),avg_HwCty = HwCty/2) %>%
    arrange(desc(avg_HwCty)) %>% 
    head(3)




