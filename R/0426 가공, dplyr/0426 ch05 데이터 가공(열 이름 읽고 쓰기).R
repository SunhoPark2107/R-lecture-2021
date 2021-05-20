# 모델링을 위한 가공
library(dplyr)

# Wine 데이터
wine <- read.table('data/wine.data.txt', sep = ',')
head(wine)

columns <- readLines('data/wine.name.txt')
columns

# Wine data의 column 명
names(wine)               # V1 은 얻고자 하는 결과. 따라서 2번째 열부터 columns의 변수명을 적용하여 줌.

names(wine) [2:14] <- columns
names(wine)

# substr(substring) 함수
a <- 'A quick brown fox jumps over the lazy dog.'
length(a)           # 데이터의 개수 세어 줌.(몇 개의 element로 이루어져 있는지)
nchar(a)            # 문자열의 개수 세어 줌.(몇 글자인지)
substr(a, 3, 7)
substr(a, nchar(a)-3, nchar(a)-1)

names(wine)[2:14] <- substr(columns, 4, nchar(columns))     # [1] V1 이런 식으로 되어 있으므로 이름만 남기기 위해서 substr함수 사용.
names(wine)
names(wine)[1] <- 'Y'
names(wine)

# 데이터 셋 분할하기
train_set = sample_frac(wine, 0.75)
str(train_set)
table(wine$Y)
table(train_set$Y)
test_set = setdiff(wine, train_set)
table(test_set$Y)


















