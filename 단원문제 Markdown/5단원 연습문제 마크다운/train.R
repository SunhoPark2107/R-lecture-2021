##############################
#                            #
# 1. 연습용 데이터 셋 만들기 #
#                            #
##############################


#load packs 
library(dplyr)



#step.01 연습용 데이터 셋을 만드는 사용자 정의 함수 선언 -----
create_tmp = function() {
  
  #step.02 만들고 싶은 행개수를 사용자에게 직접 입력받음 -----
  nrow = as.numeric(readline('원하는 행 개수 입력 : ')) ## 입력받은 값을 numeric으로 변환

  
  #step.03 create data pool : df의 각 컬럼이 될 data 생성 -----
  name_list = c('소연','환희','서연','서윤','서현','지우','민서','하은','하윤','윤서','지민','채원','지유','지윤','은서',
                '예은','다은','수아','수빈','예원','지원','소율','지아','예린','소윤','유진','시은','서영','가은','민지',
                '채은','민준','서준','예준','도윤','주원','시우','지후','준서','지호','하준','현우','준우','지훈','도현',
                '건우','우진','현준','민재','선우','서진','준혁','승현','유준','승우','지환','승민','민성','시윤')
  gender_list = c('F','M')
  major_list = c('사회학과','행정학과','자치행정학과','정치학과','사회복지학과','문헌정보학과','언론정보학과')
  grade_list = c('1','2','3','4')
  score_list =c(4.5,4.0,3.5,3.0,2.5,2.0,1.5,1.0,0)
  
  
  
  #step.04 create columns : 앞서 지정한 nrow 길이를 가진 데이터 생성
  name = sample(name_list,nrow,replace = TRUE)
  gender = sample(gender_list,nrow,replace = TRUE)
  major = sample(major_list,nrow,replace = TRUE)
  grade = sample(grade_list,nrow,replace = TRUE)
  score = sample(score_list,nrow,replace = TRUE)
  
  
  
  
  #step.05 create table : 데이터 프레임 생성
  tmp = data.frame(name,gender,major,grade,score)
  
  
  
  
  #step.06 create rank column : 기존 컬럼을 참고하여, 새로운 컬럼 생성
  tmp = tmp %>% dplyr::mutate(rank = ifelse(score >= 4.0,'A',
                                        ifelse((score < 4.0) & (score >= 3.0),'B',
                                               ifelse((score < 3.0) & (score >= 2.0),'C',
                                                      ifelse((score < 2.0) & (score >= 1.0),'D','E')))))
  
  #step.07 함수 실행을 통해 만들어진 결과 테이블 반환
  return(tmp) ## 반환하지 않을 시 실행 후 결과 테이블이 생성되지 않음
}


tmp = create_tmp() #위에서 정의한 사용자 함수를 실행한 후 return된 결과물을 tmp라고 선언함










##1) 연습문제 -----

#주어진 데이터 셋에서 전체 평균학점을 구하시오. (1점)





##2) 연습문제 -----

#주어진 데이터 셋에서 전공별 평균학점을 구하시오. (2점)





##3) 연습문제 -----

#주어진 데이터 셋에서 전공별 과탑의 이름과 학점을 구하고, 전공별 '학점' 내림차순으로 정렬하시오. (3점)





##4) 연습문제 -----

#주어진 데이터 셋에서 전공별로 남자와 여자의 평균 학점과 rank의 최빈값을 구하시오. (3점)





##5) 연습문제 -----

#주어진 데이터 셋에 'rank_new' 컬럼을 만들고, 학점(score)의 소숫점 첫번째 자리가 '0.5'인 경우, 
#기존 rank 뒤에 '+'를 붙여 새로운 학점을 부여하시오. (4점)





##############################
#                            #
# 2. 별그리기                #
#                            #
##############################


#load packs 
library(dplyr)




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







####################################################
#                                                  #
# 3. 문제야 문제~ 온 세상 속에 똑같은 사랑 노래가~ #
#                                                  #
####################################################


library(dplyr)


#Q_1. -----
mpg %>% 
  dplyr::mutate(gbn = ifelse(displ <= 4,'A','B')) %>% 
  dplyr::group_by(gbn) %>% 
  dplyr::summarise(avg_hwy = mean(hwy))


#Q_2. -----
mpg %>% 
  dplyr::filter(manufacturer %in% c('audi','toyota')) %>% 
  dplyr::group_by(manufacturer) %>% 
  dplyr::summarise(avg_cty = mean(cty))


#Q_3. -----
mpg %>% 
  dplyr::filter(manufacturer %in% c('chevrolet','ford','honda')) %>% 
  dplyr::summarise(avg_hwy = mean(hwy))


#Q_4. -----
mpg %>% 
  dplyr::select(class,cty) %>%
  head()


#Q_5. -----
mpg %>% 
  dplyr::select(class,cty) %>%
  dplyr::filter(class %in% c('suv','compact')) %>% 
  dplyr::group_by(class) %>% 
  dplyr::summarise(avg_cty = mean(cty))


#Q_6. -----
mpg %>% 
  dplyr::arrange(desc(hwy)) %>%
  head(5) %>% 
  dplyr::filter(manufacturer == 'audi')


#Q_7. -----
##7-1)
mpg_copy = mpg %>% dplyr::mutate(HwCty = (hwy + cty))
##7-2)
mpg_copy = mpg_copy %>% dplyr::mutate(avg_HwCty = HwCty/2)
##7-3)
mpg_copy %>% 
  dplyr::arrange(desc(avg_HwCty)) %>% 
  head(3)
##7-4)
mpg %>% 
  dplyr::mutate(HwCty = (hwy + cty),avg_HwCty = HwCty/2) %>%
  dplyr::arrange(desc(avg_HwCty)) %>% 
  head(3)


#Q_8. -----
mpg %>% 
  dplyr::group_by(class) %>%
  dplyr::summarise(avg_cty = mean(cty))


#Q_9. -----
mpg %>% 
  dplyr::group_by(class) %>%
  dplyr::summarise(avg_cty = mean(cty)) %>% 
  dplyr::arrange(desc(avg_cty))


#Q_10. -----
mpg %>% 
  dplyr::group_by(manufacturer) %>%
  dplyr::summarise(avg_hwy = mean(hwy)) %>%
  dplyr::arrange(desc(avg_hwy))


#Q_11. -----
mpg %>% 
  dplyr::filter(class == 'compact') %>% 
  dplyr::group_by(manufacturer) %>% 
  dplyr::summarise(cnt = n()) %>% 
  dplyr::arrange(desc(cnt))


