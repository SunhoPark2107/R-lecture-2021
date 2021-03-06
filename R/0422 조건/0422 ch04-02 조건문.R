# 조건문
# 1. []에 행/열 조건 명시
test <- c(15, 20, 30, NA, 45)
test[test<40]                       # NA를 포함하는 결과.
test[test<40 & !is.na(test)]        # NA 제외한 결과.
test[test%%3 == 0 & !is.na(test)]   # 3의 배수.

df <- data.frame(name = c('길동', '춘향', '철수'), age = c(30, 16, 21), gender = factor(c('M', 'F', 'M')))

df
# 여성인 행 추출
df[df$gender == 'F',]
# 25세 이상이고 남성인 행 추출.
df[df$gender == 'M' & df$age > 25,]

# 2. if문          # indentation 주의할 것! 코드의 가독성도 있지만, 다른 언어에서는 indentation으로 if문 시작/끝 결정됨.
x <- 5
if (x%%2 == 0) {
    print('짝수입니다')
} else {
    print('홀수입니다')
}

x <- 5
if (x>0) {                    # x>0 대신 x>1e-10으로 표현하는 게 더 낫다. (0.0000000001) (이유는...?)
    print('양수')
} else if (x>0) {
    print('음수')
} else {
    print('Zero')
}

# 3. ifelse 문
score <- 50
pass <- ifelse(score>=60, '합격', '불합격')
pass

getwd()
students <- read.csv('data/students.csv')     # 교수님은 euc-kr로 인코딩하심
students
options(digits=4)                             # 전체 자리 유효 숫자 지정 가능. (R 소수점 자리 지정 구글링해보기.)
apply(students[,2:4],1,mean)
students['평균'] = apply(students[,2:4],1,mean)    # 데이터프레임에서 변수(열) 추가하는건 원래 이런 식으로 한다고 한다... 난 몰랐지 ㅠㅠ
students
students$'평균'                               # 한글도 변수명으로 사용 가능하다.
students['학점'] = ifelse(students$평균 >=90, 'A', 
                        ifelse(students$평균 >= 80, 'B',
                               ifelse(students$평균 >= 70, 'C', 'D')))      # 여러 개의 범주로 나누어 주는 조건을 걸고 싶을 때는
                                                                            #ifelse를 사용하는 것이 가장 편하고 한줄로 조건 설정 할 수 있다.

students









