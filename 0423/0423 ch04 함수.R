# 함수

# 팩토리얼(!) 함수
fact <- function(x) {
    prod <- 1
    for (i in 1:x) {
        prod <- prod * i
    }
    return(prod)
}

fact(5)
fact(10)

# 정수 a ~ b 의 합을 구하는 함수(range_sum)

range_sum <- function(a, b) {
    sum <- 0
    for (i in a:b) {
        sum <- sum + i
    }
    return(sum)
}

range_sum(1, 10)

# 재귀 함수

facto <- function(n) {
    if(n == 0) {
        return(1)
    }
    return(n * facto(n-1))
}

facto(10)

# 피보나치수열(앞의 두 수의 합이 바로 뒤의 수가 되는 배열.)

fibo <- function(n) {
    if (n == 0 | n == 1) {
        return(1)
    }
    return(fibo(n-1)+fibo(n-2))
}
for (i in 0:10) {
    print(paste(i, fibo(i)))
}

# peak2peak 함수

peak2peak <- function(x) {
    return(max(x) - min(x))
}

mat <- matrix(1:12, nrow = 3)
apply(mat, 1, mean)
apply(mat, 1, peak2peak)      # 행별로 최대값 - 최소값.
apply(mat, 2, peak2peak)


# 사용자 정의 함수도 다른 함수에 적용 가능하다. 위의 apply 처럼!
# 이를 통해 할 수 있는 일이 많이 확장됨!
# 졸립다. 너무 졸립다.

























