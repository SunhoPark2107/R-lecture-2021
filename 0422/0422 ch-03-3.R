# 배열(array 함수)
x <- array(1:8, c(2,4))   # 할당(1~8 값을, 만들어라(2*4영역)) = 1~8 값을 2*4 영역에 할당하여 생성.
x
y  <- array(1:5, c(2,4))
y
z <- array (1:24, c(4,3,2))   # 3차원 이해 안감...
z
z[3,2,2]   # 19
z[4,3,1]   # 12

# Matrix(2차원 배열)
matrix(1:12, nrow=3)    # array(1:12, c(3,4)) 과 동일.
matrix(1:12, nrow=3, byrow=T)      # byrow 로 원래는 열 기준으로 데이터가 1,2,3,... 배열되던 것이 행 기준으로 1,2,3,... 쌓임.

# vector를 묶어 배열 생성
v1 = 1:4
v2 = 5:8
v3 = 9:12
cbind(v1, v2, v3)     # 열 단위로 묶어 배열(table) 생성.
rbind(v1, v2, v3)     # 행 단위로 묶어 배열(table) 생성.

cbind(x,y)            # 그냥 x배열 옆에 y 배열이 들어가넹
rbind(x,y)            # 얜 반대로 x배열 아래에 y배열이 들어가고

# 행렬 연산
x <- matrix(1:4, nrow=2)
y <- matrix(5:8, ncol=2)
x
y
x + y       # 같은 위치의 행렬 요소끼리 단순 합.
x - y
x * y
# 수학적인 행렬 곱(dot product)
x %*% y
# 전치 행렬(transpose)
t(x)
t(y)
# 역행렬, 자기와 행렬 곱을 하면 단위행렬(I, identity)이 됨.
solve(x)
x %*% solve(x)
# 행렬식(determinant)
det(x)

# 배열 연산에 사용되는 함수
apply(x, 1, mean)     # 1: 행 별로 적용   -----> 행 방향으로.
apply(x, 2, mean)     # 2: 열 별로 적용   ↓아래쪽 열 방향으로.
apply(x, 1, sum)
sum(x)
dim(x)

# 샘플링
a <- array(1:12, c(3,4))
sample(a)                 # sample => 무작위 추출(순서가 없이 추출됨.) array뿐 아니라 vector에서도 가능.
sample(a, 4)
sample(a, 4, prob = c(1:12)/24) # sample에서 뽑힐 확률을 다르게 정해주는 방법. 즉, 샘플 element에 확률 가중치를 주는 것.
#*주의점: sample의 개수만큼 가중치 확률을 지정해 주어야 한다. 총 확률의 합은 1이 되지 않아도 된다. 말 그대로 가중치이기 때문.
#*#/24는 확률처럼 보이기 위해 지정해 준 것일 뿐 없어도 상관 없다.
c(1:12)/24     # 여기에서 나온 결과값을 가중치로 준다는 의미.
c(1:12)        # 이렇게 가중치를 줘도 상관은 없다. 말 그대로 가중치일 뿐이기 때문.
