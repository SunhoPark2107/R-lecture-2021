x <- array(1:12, c(3,4))
x

apply(x, 1, sum)

x*x

apply(x*x, 1, sum)


# Matrix 문제 풀기
mat <- matrix(1:12, nrow=3)
nrow <- 3
ncol <- 4

sum1 <- 0
sum2 <- 0
sum3 <- 0
for (i in 1:nrow) {
    for (k in 1:ncol) {
        sum1 <- sum1 + mat[i, k]
        sum2 <- sum2 + mat[i, k]^2
        sum3 <- sum3 + mat[i, k]^i
    }
}
print(sum1)      
print(sum2)
print(sum3)
print(paste(sum1, sum2, sum3))


# 별 그리기 (문자 뒤에 계속 문자를 덧붙이는 것. list에 append로 데이터를 덧붙이는 것과 논리가 유사하므로 구조 잘 이해하기.)

for (i in 1:5) {
    star <- ''
    for (k in 1:i) {
        star <- paste0(star, '+')
    }
    print(star)
}

# list 만들기                # 크롤링할 때 많이 쓰이는 list. 가져온 데이터 일단 lst에 다 넣어 놓으라고 할 수 있다.
lst <- list()
lst <- append(lst, 3)
lst <- append(lst, 5)
lst <- append(lst, 7)
print(lst)
length(lst)
lst[1]
lst[2]
lst[3]



for (i in 1:5) {
    lst <- append(lst, i)
}
lst

for (element in lst) {
    print(element)
}


                      # 실제로 for loop을 쓸 때는 다음과 같이 쓰는 것이 맞음.
                      # vector, matrix, sequence 사용하여 범위 지정.
vec <- c(1,7,8)
for (element in vec) {
    print(element)
}

mat <- matrix(1:12, nrow = 3)

for (element in mat) {
    print(element)
}


# 약수의 표현 (약수 : modulo 해서 0이 되는 것.)

N = 6

for (num in 1:N) {
    if (N %% num == 0) {
        print(num)
    }
}

# 약수의 합

sum <- 0

for (num in 1:N) {
    if (N %% num == 0) {
        sum <- sum + num
    }
}
print(sum)

# Perfect Number(완전수)(자기 자신을 제외한 약수의 합이 자신과 동일한 수. 예를 들면 6)
#1에서 10000까지의 완전수를 찾으시오.

for (N in 2:10000) {
    sum <- 0
    for (num in 1:(N-1)) {
        if (N %% num == 0) {
            sum <- sum + num
        }
    }
    if (sum == N) {
        print(N)
    }
}


