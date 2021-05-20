# 반복문
# 1. repeat
i <- 1
sum <- 0             # 초기화 하는 것(초기값 지정). sum은 함수가 아니라 지금 변수임.
repeat{
    if(i > 10) {                 # 반복문을 벗어나는 조건.
        break                    # 반복문을 벗어나는 것.(break)
    }
    sum <- sum + i
    i <- i + 1
}
print(sum)

# while
i <- 1
sum <- 0   
while(i <= 10) {                # 반복문이 실행될 조건범위.
    sum <- sum + i
    i <- i + 1
}
print(sum)

# for
sum <- 0                        # 변수의 초기값은 어떤 반복문이든 다 지정해 주어야 한다. 단, for문의 경우 조건이 아니라 범위 in(1:10)의 형식으로 지정되므로 i초기값이 필요 없다.
for (i in 1:10) {                 # for 문 범위가 반드시 숫자일 필요는 없음. 벡터여도 되고 리스트여도 됨.
    sum <- sum + i
}
print(sum)

# repeat문 10! (1*2*3*4*5*6*7*8*9*10)
i <- 1
product <- 1
repeat{
    if(i > 10) {
        break
    }
    product <- product * i
    i <- i + 1
}
print(product)

# while문 10! (1*2*3*4*5*6*7*8*9*10)
i <- 1
product <- 1   
while(i <= 10) {
    product <- product * i
    i <- i + 1
}
print(product)


# for문 10! (1*2*3*4*5*6*7*8*9*10)
product <- 1
for (i in 1:10) {
    product <- product * i
}
print(product)

# for 문 1부터 100까지 범위에서 홀수만을 모두 더함.
sum <- 0
for (i in 1:100) {
    if(i%%2 == 1) {
    sum <- sum + i
    }
}
print(sum)

# while 문 1부터 100까지 범위에서 홀수만을 모두 더함.
i <- 1
sum <- 0
while (i <= 100) {
    if (i%%2 == 1) {
        sum <- sum + i
    }
}
print(sum)

#for문 다시 연습
odd_sum <- 0
for (i in 1:100) {
    if (i %% 2 == 1) {
        odd_sum <- odd_sum + i
    }
}
print(odd_sum)

odd_sum <- 0
for (i in seq(1, 100, by = 2)) {
    odd_sum <- odd_sum + i
}
print(odd_sum)

# for 문으로 구구단 만들기.
for (k in 1:9) {
    print(paste('2', 'x', k, '=', 2*k))
}

for (i in 2:9) {
    print(paste0(i, ' 단 ===================================='))
    for (k in 1:9) {
        print(paste(i, 'x', k, '=', i*k))
    }
}















