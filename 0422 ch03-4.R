# 데이터 프레임
name <- c("철수", "춘향", "길동")
age <- c(22,20,25)
gender <- factor(c("M", "F", "M"))
blood_type <- factor(c("A", "O", "B"))

patients=data.frame(name, age, gender, blood_type)
patients

patients$name
typeof(patients$name)
patients[1,]      # 첫째 행 정보.
patients[,2]      # patients$age 와 동일.
patients[2,3]     # F
patients$gender[3]
patients[patients$name == '철수',]
patients[patients$name == '철수',c('age', 'gender')]     # 컬럼명은 '' 작은따옴표로 싸 주기.

attach(patients)      # 데이터 이름을 속성명으로 사용 가능. 내부적으로 각각 데이터 할당해주었을 때는 attach없이도 되나 외부에서 가져온 데이터의 경우 쓴다.
name
blood_type
gender
age

detach(patients)

head(cars)
attach(cars)
speed
distance

detach(cars)          

speed                  # 에러: 객체 'speed'를 찾을 수 업습니다. (detach 해 주었기 떄문에.)

mean(cars$speed)
max(cars$dist)
with(cars, mean(speed))

# subset
subset(cars, speed>20)
cars[cars$speed>20,]   # subset 안 써도 다른 방법으로 일부추출 가능.
subset(cars, speed>20, select=c(dist))
subset(cars, speed>20, select=-c(dist))

# 결측값(NA) 처리
head(airquality)
str(airquality)
sum(airquality$Ozone)      # 중간에 결측치가 있을 경우 전체가 결측치가 되어 버림.

# 결측치를 어떻게 처리할 것인가?
# 1. 결측치가 많은 경우: 통쨰로 날려라 / 결측치가 적은 경우 : 결측치만 제거해라.
# 2. 대표값으로 대체. (평균값, 중앙값, 최빈값)

head(na.omit(airquality))      # 결측치가 제거된 상태에서 데이터가 보임. NA데이터가 있는 행 전체를 제거한 것.

# 병합(merge)
patients
patients1 <- data.frame(name, age, gender)
patients2 <- data.frame(name, blood_type)
merge(patients1, patients2, by = 'name')       # 기준으로 삼을 공통 변수가 있어야 데이터 테이블이 유의미하게 나옴.

patients2 <- data.frame(blood_type)
merge(patients1, patients2)                    # 기준으로 삼을 공통 변수가 없는 경우. 중복 데이터가 막 생기는 것은 물론이요 데이터끼리 매치도 안 된다. 이런 데이터는 쓸 수 없음.





























































