#step.01 별로 그림 그리는 사용자 정의 함수 선언 -----
starDrawing = function(nrow) {
  
  #step.02 그리고 싶은 그림의 행개수를 사용자에게 직접 입력받음 -----
  cnt = 0 ## while 문 실행을 위한 기준값 (아래에 while 문은 cnt값이 0인 동안 계속 돌아감)
  while (cnt == 0) {
    nrow = as.numeric(readline('원하는 행 개수 입력 : ')) ## 입력받은 값을 numeric으로 변환
    if (nrow %% 2 != 0) cnt = cnt + 1 ## 입력받은 개수가 홀수일 경우 cnt에 1을 더함 (즉, cnt != 0 이므로, while문 종료)
  }
  
  
  #step.03 입력받은 행개수대로 별그림을 그림
  n = median(1:nrow) ## 대칭의 기준점이 되는 정가운데 행번호를 구함(중앙값)
  
  for (i in 1:nrow){
    if (i != n) {
      for (j in 1:abs(i-n)){
        cat(" ")
      }
      for (j in 1:(nrow-abs(i-n)*2)){
        cat("*")
      }
      cat("\n")    
    }
    else {
      for (j in 1:(nrow-abs(i-n)*2)){
        cat("*")
      }
      cat("\n")    
    }
  }
  
}


starDrawing() #위에서 선언한 함수 실행
