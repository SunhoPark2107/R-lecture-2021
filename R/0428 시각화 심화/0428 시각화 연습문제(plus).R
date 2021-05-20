# 1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.
library(ggplot2)
library(dplyr)

dim(mpg)   # 데이터의 사이즈를 확인해 보아야 함.

ggplot(mpg, aes(cty, hwy, col = class)) +
    geom_point(position="jitter")

# 2. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 산점도를 만들어 보세요. 전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.

head(midwest)

midwest %>% 
    filter(poptotal <= 500000, popasian <= 10000) %>% 
    ggplot(aes(poptotal, popasian, col = state)) +
    geom_point(position='jitter')

# 지수 표기를 일반 표기로 변환 => options(scipen = 10)
# 그래프 상에 2e+05 이런 식으로 표현되던게 200000 로 표현됨! (2e+05 => 대충 앞자리 2에 0 5개 붙는다고 생각하면 편하다.)

# 연결해서 한번에 실행되도록, 스케일 변화

midwest %>% 
    filter(poptotal <= 500000, popasian <= 10000) %>% 
    ggplot(aes(poptotal, popasian, col = state)) +
    geom_point(position='jitter') +
    scale_x_log10() + scale_y_log10()

# 3. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. "suv" 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비가 높은 순으로 정렬하세요. 

mpg %>% 
    filter(class == "suv") %>% 
    group_by(manufacturer) %>% 
    summarise(avg_cty = mean(cty)) %>% 
    arrange(desc(avg_cty)) %>% 
    head(5) %>% 
    ggplot(aes(reorder(manufacturer, -avg_cty), avg_cty, fill = manufacturer))+
    geom_bar(stat = 'identity')

mpg %>% 
    filter(class == "suv") %>% 
    group_by(manufacturer) %>% 
    summarise(avg_cty = mean(cty)) %>% 
    arrange(desc(avg_cty)) %>% 
    head(5) %>% 
    ggplot(aes(x = reorder(manufacturer, -avg_cty), y =  avg_cty, fill = manufacturer)) +
    geom_col () +
    labs(x = 'Manufacturer', y = 'average cty')


# 4. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.

ggplot(diamonds, aes(cut))+geom_bar()

ggplot(mpg, aes(class, fill = class)) +
    geom_bar()


mpg %>% 
    group_by(class) %>% 
    summarise(count = n()) %>% 
    ggplot(aes(x = reorder(class, -count), y = count, fill = class)) +
    geom_col() +
    labs(x = 'Class')


# 5. economics 데이터를 이용해서 psavert(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.
head(economics)
library(gridExtra)

ggplot(economics, aes(date, psavert)) +
    geom_line(col = "orange", size = 1)

head(economics)


ggplot(economics) +
    geom_line(aes(date, psavert), col = "orange") +
    geom_line(aes(date, uempmed), col = "blue")

ggplot(economics) +
    geom_line(aes(date, psavert, col = psavert))   # 개인 저축률에 따라 색의 밝기를 조정하여 적용할 수도 있음.



# 6. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.

mpg %>% 
    filter(class %in% c("compact", "subcompact", "suv")) %>% 
    ggplot(aes(class, cty, fill = class)) +
    geom_boxplot()

mpg %>% 
    filter(class == c("compact", "subcompact", "suv")) %>%            # element == vector는 성립하지 않음. 
    ggplot(aes(class, cty, fill = class)) +
    geom_boxplot()

# 7. Diamonds 데이터 셋을 이용하여 다음 문제를 해결하세요.
# 단, 컬러, 제목, x축, y축 등 그래프를 예쁘게 작성하세요.

# 1) cut의 돗수를 보여주는 그래프를 작성하세요.

head(diamonds)
str(diamonds)

ggplot(diamonds, aes(cut, carat, col = cut)) +
    geom_boxplot() + ggtitle("Carat by Cut chart")

ggplot(diamonds, aes(cut, fill = cut)) +
    geom_bar()+
    scale_fill_brewer(palette="Pastel1") +
    ggtitle("Frequency by Cut Chart") + xlab("Cut style") + ylab("Frequency")


diamonds %>% 
    group_by(cut) %>% 
    summarise(avg_carat = mean(carat)) %>% 
    ggplot(aes(cut, avg_carat, fill = cut)) +
    geom_bar(stat = 'identity') +
    scale_fill_brewer(palette="Pastel1") +
    ggtitle("Average Carat by Cut Chart") + xlab("Cut Style") + ylab("Average Carat")


.# 2) cut에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
# 여기도 geom_bar를 쓸 필요가 없는거지 왜냐면 x, y를 둘 다 지정해 줘야 하는데, 그러면 geom_col()만 쓰면 되니까.
# geom_bar를 쓰려면 아래와 같이 (stat = "identity") 를 지정해 줘야 한다.

diamonds %>% 
    group_by(cut) %>% 
    summarise(avg_price = mean(price)) %>% 
    ggplot(aes(cut, avg_price, fill = cut)) +
    geom_bar(stat = "identity") +
    scale_fill_brewer(palette="Pastel2") +
    ggtitle("Average Price by Cut Chart") + xlab("Cut Style") + ylab("Average Price")

# 만약에 color에 따른 가격의 변화를 구하고자 한다면

diamonds %>% 
    group_by(color) %>% 
    summarise(avg_price = mean(price)) %>% 
    ggplot(aes(color, avg_price, fill = color)) +
    geom_bar(stat = "identity") +
    scale_fill_brewer(palette="Pastel2") +
    ggtitle("Average Price by Cut Chart") + xlab("Cut Style") + ylab("Average Price")



# 3) cut과 color에 따른 가격의 변화를 보여주는 그래프를 작성하세요.

# cut, color에 따른 도수 분포를 그린다면
ggplot(diamonds, aes(x = price)) +
    geom_histogram(bins = 10) +
    facet_wrap(~cut + color)

glimpse(diamonds)

# 노가다시작

library(RColorBrewer)
display.brewer.all()


# theme(plot. title=element_text(face = "", size = , vjust = , color = "") 을 통해서 제목 등의 서식 디자인 가능.


diamonds %>% 
    group_by(cut, color) %>% 
    summarise(avg_cutprice = mean(price))

# 간단하게 한번에 그리는 방법도 있었군용...!

diamonds %>% 
    group_by(cut, color) %>% 
    summarise(avg_cutprice = mean(price)) %>% 
    ggplot(aes(cut, avg_cutprice, fill = color)) +
    geom_bar(stat = "identity", position = 'dodge')


d1 <- diamonds %>% 
    filter(cut == "Fair") %>% 
    group_by(color) %>% 
    summarise(avg_cutprice = mean(price)) %>% 
    ggplot(aes(color, avg_cutprice, fill = color)) +
    geom_bar(stat = "identity") +
    ggtitle('Cut = Fair')+
    theme(plot.title=element_text(face = "bold", size = 16, vjust=1, color = "red"))
d1


d1 <- diamonds %>% 
    filter(cut == "Fair") %>% 
    group_by(color) %>% 
    summarise(avg_cutprice = mean(price)) %>% 
    ggplot(aes(color, avg_cutprice, fill = color)) +
    geom_bar(stat = "identity") +
    ggtitle("Cut_Fair") + scale_fill_brewer(palette="Set1")
    
d2 <- diamonds %>% 
    filter(cut == "Good") %>% 
    group_by(color) %>% 
    summarise(avg_cutprice = mean(price)) %>% 
    ggplot(aes(color, avg_cutprice, fill = color)) +
    geom_bar(stat = "identity") +
    ggtitle("Cut_Good") + scale_fill_brewer(palette="Set2")

d3 <- diamonds %>% 
    filter(cut == "Very Good") %>% 
    group_by(color) %>% 
    summarise(avg_cutprice = mean(price)) %>% 
    ggplot(aes(color, avg_cutprice, fill = color)) +
    geom_bar(stat = "identity") +
    ggtitle("Cut_Very Good") + scale_fill_brewer(palette="Set3")

d4 <- diamonds %>% 
    filter(cut == "Premium") %>% 
    group_by(color) %>% 
    summarise(avg_cutprice = mean(price)) %>% 
    ggplot(aes(color, avg_cutprice, fill = color)) +
    geom_bar(stat = "identity") +
    ggtitle("Cut_Premium") + scale_fill_brewer(palette="Pastel1")

d5 <- diamonds %>% 
    filter(cut == "Ideal") %>% 
    group_by(color) %>% 
    summarise(avg_cutprice = mean(price)) %>% 
    ggplot(aes(color, avg_cutprice, fill = color)) +
    geom_bar(stat = "identity") +
    ggtitle("Cut_Ideal") + scale_fill_brewer(palette="Pastel2")

grid.arrange(d1, d2, d3, d4, d5, nrow = 2, ncol = 3)



