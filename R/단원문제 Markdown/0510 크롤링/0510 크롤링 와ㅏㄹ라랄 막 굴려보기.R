# 과제
# 1. 한빛미디어 새로나온 책 목록 25페이지 전체 크롤링해서 .csv 형식으로 저장하기.\

library(rvest)
library(stringr)
library(dplyr)

# 웹 사이트 읽기
base_url <- 'https://www.hanbit.co.kr/media/books/'
sub_url <- 'new_book_list.html'
url <- paste0(base_url, sub_url)
html <- read_html(url)
url

href <- li %>% 
    html_node('.info') %>% 
    html_node('a') %>% 
    html_attr('href')

href


container <- html_node(html, '#container')  
book_list <- html_node(container, '.new_book_list_wrap')  
sub_book_list <- html_node(book_list, '.sub_book_list_area')   
# 여기서부터 시작해도 됨.(sub_book_list <- html_node(html, '.sub_book_list_area'))
# 단, 이게 검색범위를 좁힐 수 있는 한계가 있음. 그걸 모르니까 일단 큰 거부터 시작하는 것도 좋다. 코드 몇줄 추가만 하면 되니깡...

lis <- html_nodes(sub_book_list, 'li')     # 이 코드만 돌리면, li가 다른 블록에도 너무 많아서 이상한게 다 들어온다.
# nodes로 들어가야 하는 곳 바로 상위 차원까지 해도 엥간하면 다 나올듯.?

html_node(html, '.sub_book_list_area') %>% 
    html_nodes(sub_book_list, 'li')               # 변수 지정 일일이 안 하고 요렇게 해줘도 됨.

book_url <- paste0(base_url, substr(href,1,17), page_url) 
book_url

title_vector <- c()
writer_vector <- c()
page_vector <- c()
price_vector <- c()

for (i in c(1:25)) {
    page_url <- paste0('page=%s&cate_cd=&drt=&searchKey=&keyWord=', i)
    print(page_url)
    
    for (li in lis) {
        info <- html_node(li, '.info')
        title <- info %>% 
            html_node('.book_tit') %>% 
            html_text()
        writer <- info %>% 
            html_node('.book_writer') %>% 
            html_text()
        href <- li %>% 
            html_node('.info') %>% 
            html_node('a') %>% 
            html_attr('href')
        book_url <- paste0(base_url, href, page_url)      #  paste(base_url, href, sep = '/')을 써도 되긴 됨(url이 이상한데 이상하게 접속하는덴 문제가 없더라고)
        book_html <- read_html(book_url)
        info_list <- html_node(book_html, 'ul.info_list')
        book_lis <- html_nodes(info_list, 'li')
        for (book_li in book_lis) {
            item <- book_li %>% 
                html_node('strong') %>% 
                html_text()
            if (substring(item, 1, 3) == '페이지') {
                page <- book_li %>% 
                    html_node('span') %>% 
                    html_text()
                len <- str_length(page) 
                page <- as.integer(substring(page, 1, len-2))
                break
            }
        }
        pay_info <- html_node(book_html, '.payment_box.curr')
        ps <- html_nodes(pay_info, 'p')
        price <- ps[2] %>% 
            html_node('.pbr') %>% 
            html_node('strong') %>% 
            html_text()
        price <- as.integer(gsub(',','',price))
        
        title_vector <- c(title_vector, title)
        writer_vector <- c(writer_vector, writer)
        page_vector <- c(page_vector, page)
        price_vector <- c(price_vector, price)
    }
}



View(new_books)
write.csv(new_books, "C:/workspace/R/data/new_books.csv")

write.csv(new_books, 'data/한빛도서.csv', fileEncoding='utf-8', row.names=F)
View()

















