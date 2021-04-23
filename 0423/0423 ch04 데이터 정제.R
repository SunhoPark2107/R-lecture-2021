# 데이터 정제

getwd()

score <- read.csv('data/students2.csv')
score

# 1~100 사이가 아닌 값 결측치로 바꾸어 주기.
for (i in 2:4) {
    score[, i] <- ifelse(score[, i] >100|score[,i]<0, NA, score[,i])
}
score

# 결측값 처리
str(airquality)
head(airquality)
sum(is.na(airquality))       # 44
table(is.na(airquality))     # True에 있는 것이 결측치.(변수 상관없이 결측치 개수. 행의 개수가 아니다!)

sum(is.na(airquality$temp))  # temp에는 결측치 없음.
mean(airquality$Temp)        # 결측치가 없으므로 평균 낼 수 있음.

sum(is.na(airquality$Ozone)) # Ozone에는 37개의 결측치가 있음.
mean(airquality$Ozone)       # NA값이 존재하므로 오류가 나거나 NA 반환.

mean(airquality$Ozone, na.rm=T)    # na.rm = T : na를 배제하라. / 따라서 NA값을 제외하고 평균이 나옴.

# 결측값 제거
air_narm <- na.omit(airquality)
sum(is.na(air_narm))               # 윗줄 코드에서 결측치를 제거하였으므로 결측치는 0.


# 결측값 대체 (책에 없는 부분)

options(digits=4)
airquality$Ozone <- replace(airquality$Ozone, is.na(airquality$Ozone), mean(airquality$Ozone, na.rm = T))

head(airquality)             # 5번째 행 Ozone 데이터가 원래 NA다가, 평균치로 바뀐 것을 알 수 있음.





# solar.R의 결측치를 중간값으로 대체.

airquality$Solar.R <- replace(airquality$Solar.R, is.na(airquality$Solar.R), median(airquality$Solar.R, na.rm = T))

airquality$Solar.R <- replace(airquality$Solar.R, is.na(airquality$solar.R), median(airquality$Solar.R, na.rm = T))

head(airquality)

# 이상값(Outlier) 처리
patients <- data.frame(name=c('환자1', '환자2', '환자3', '환자4', '환자5'), 
                       age = c(22, 20, 25, 30, 27), 
                       gender=factor(c('M', 'W', 'M', 'K', 'F')), 
                       blood.type=factor(c('A', 'O', 'B', 'AB', 'C')))


patients



# 성별의 이상치 제거
patients_outrm <- patients[patients$gender == "M" | patients$gender == "F", ]
patients_outrm


# 혈액형의 이상치 제거 (조건식)
patients_outrm <- patients[patients$blood.type %in% c('A','O','B','AB'), ]       # %in% 은 "포함" 연산자 함수이다. (아마 논리인듯? 포함 하나 안하나.)
patients_outrm


# 성별과 혈액형의 이상치 제거 (조건식)
patients_outrm <- patients[patients$gender %in% c('M', 'F') & patients$blood.type %in% c('A','O','B','AB'),]
patients_outrm

# 이상치를 NA로 대체
patients$gender <- ifelse(patients$gender %in% c('M', 'F'), patients$gender, NA)
patients


patients2 <- data.frame(name=c('환자1', '환자2', '환자3', '환자4', '환자5'),
                        age = c(22, 20, 25, 30, 27),
                        gender=c('M', 'W', 'M', 'K', 'F'),
                        blood.type=factor(c('A', 'O', 'B', 'AB', 'C')))
patients2

patients2$gender <- ifelse(patients2$gender %in% c('M', 'F'), patients2$gender, NA)
patients2$blood.type <- ifelse(patients2$blood.type %in% c('A', 'O', 'B', 'AB'),
                               patients2$blood.type, NA)
patients2
sum(is.na(patients2))
as.factor(patients2$gender)
as.factor(patients2$blood.type)


# 숫자의 이상치
boxplot(airquality[, c(1:4)])
airquality

boxplot(airquality[, 1])$stats
boxplot(airquality$Ozone)$stats[1]

air <- airquality
air$Ozone <- ifelse(air$Ozone<boxplot(airquality$Ozone)$stats[1] | air$Ozone >boxplot(airquality$Ozone)$stats[5], NA, air$Ozone)
# [1] 은 박스 플롯의 하단 꼬리, [5]는 박스 플롯의 상단 꼬리.
air

sum(is.na(air$Ozone))
sum(is.na(airquality$Ozone))

mean(air$Ozone, na.rm=T)
mean(airquality$Ozone, na.rm = T)
