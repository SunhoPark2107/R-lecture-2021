getwd()
setwd('/workspace/R')

# 변수(Variable)
x<-1
y<-2
z<-x+y
z
# Swapping
temp <- x
x <- y
y <- temp

# 변수의 타입

typeof(x)
a <- 'string'
typeof(a)
b <- "double quote"
typeof(b)
c <- '한글'
typeof(c)

# 실수(Numeric)
x <- 5
y <- 2
x / y
# 복소수(Complex) i = 복소수(제곱하였을 때 -1이 되는 가상의 수.)
xi <- 1 + 2i
yi <- 1 - 2i
xi + yi
xi * yi

# 범주형(Category) **변수명에 .들어갈 때는 코드인식오류 가능성 있기 때문에 조심해야 함.
# 일반적인 변수명 (bloodType(Camel notation) blood_type(snake notation)) / 시작할 때 대문자로 시작하면 안됨.
# Language마다 notation 방법(대소문자 구분)이 다 다르니 주의.
blood_type = factor(c('A', 'B', 'O', 'AB'))
blood_type

# 논리형(Boolean)
TRUE
FALSE
T
F

xinf = Inf
yinf = -Inf
xinf / yinf

# 데이터형 확인 함수/ 괄호 안에 반드시 하나의 정해진 값이 아니라 식이 들어가도 된다.
class(x)       # R 객체지향 관점
typeof(x)      # R 언어자체 관점
is.integer(x) 
is.numeric(x)
is.complex(xi)
is.character(c)
is.na(xinf/yinf)  # na는 not available의 약자.

# 데이터형 변환 함수
is.integer(as.integer(x))  #데이터형 정수로 변환 후 이거 정수니? 물어보는 것.=> 결과: T
is.factor(as.factor(c))

# 산술연산자(+, -, *, /, ^, **, %%, %/%)
5 ^ 2
4 ^ (1/2)
x %% y      # 나머지
x %/% y     # 몫

# 비교 연산자
x < y
x <= y     # < 치고 나서 = 치면 <=가 됨.
'***'      # 문자 형식으로 * 세개 치면 *** 이렇게 됨.
x == y     # 등호 2번 연속 => 좌우값이 같은 값인가? 묻는 연산자.
x != y     # 느낌표+등호 는 같지 않다.

# 논리 연산자
!T
!F
x | y    # OR
x & y    # and

a <- c(F, F, T, T)
b <- c(F, T, F, T)
a | b              # element-wise OR
a || b             # 첫번째 element의 논리합
a & b
a && b

# 연산자간 우선순위 ->산술>비교>논리
2^-3-5**1/2>2      # 실행하면 false가 나온다. 연산자간 우선순위에 의해 결정
2^(-3) - 5**(1/2) >2 # 우선순위를 분명히 해 주고 싶으면 이와 같이 띄어쓰기와 괄호를 적절하게 사용하여야 한다.



















