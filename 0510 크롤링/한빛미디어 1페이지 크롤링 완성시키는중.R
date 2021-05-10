# 한빛미디어 사이트로 웹 크롤링 연습하기

library(rvest)
library(stringr)
library(dplyr)

# 웹 사이트 읽기
base_url <- "https://www.hanbit.co.kr"
sub_url <- "/store/books/new_book_list.html"
url <- paste(base_url, sub_url, sep = '/')
url
html <- read_html(url)     # url에 저장된 홈페이지의 html을 읽어옴.
html

container <- html_node(html, '#container')   
container <- html %>% html_node('#container')               # id = "container"
book_list <- html_node(container, '.new_book_list_wrap')
sub_book_list <- html_node(book_list, '.sub_book_list_area')
lis <- html_nodes(sub_book_list, 'li')    

title_vector <- c()        # 데이터 프레임 만들기
writer_vector <- c()


for (li in lis) {
    info <- html_node(li, '.info')
    title <- info %>% 
        html_node('.book_tit') %>% 
        html_text()
    writer <- info %>% 
        html_node('.book_writer') %>% 
        html_text()
    title_vector <- c(title_vector, title)
    writer_vector <- c(writer_vector, writer)
}

new_books <- data.frame(
    title = title_vector,
    writer = writer_vector
)

View(new_books)

