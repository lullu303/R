# TXT/EXCEL/CSV/RDA(R 전용파일) 파일의 입출력

# 파일 관리 함수 정리
# 현재 작업 디렉터리
# C:\Users\lullu\Documents\Rstudy

# 파일 저장 디렉터리 - 작업 디렉터리로 설정 후 사용할 것임
# C:\Users\lullu\Documents\Rstudy\data

# 현재 작업 디렉터리 내의 파일 확인
# list.files() # 현 디렉터리의 파일명을 출력
list.files()


# 하위 디렉터리 정보까지 전부 출력
list.files(recursive = T)

# 숨김파일까지 출력
list.files(all.files = T)

# 작업 디렉터리 관련 함수
# 현재 작업 디렉터리 조회
getwd()

# 현재 작업 디렉터리 변경 (Rstudy\data)
setwd("data")
getwd()
list.files()

# 현재 작업 디렉터리를 상위 디렉터리로 변경
setwd("../")
getwd()

# data 폴더를 현재 작업 디렉터리로 설정
setwd("data")
getwd()


# 텍스트 파일 읽어오기
# scan('파일명)

scan1 <- scan('scan_1.txt')
typeof(scan1)

scan2 <- scan('scan_2.txt')
typeof(scan2)

# 텍스트파일을 문자열로 지정 : what=""
scan2 <- scan('scan_2.txt', what="")
typeof(scan2)

# 숫자모양이 아닌 문자 파일을 기본 파라미터로 읽으면 에러 발생
# what ="" 반드시 사용해야 함
scan3 <- scan('scan_3.txt', what="")
scan3

# 숫자와 문자가 혼용된 데이터는 문자로 읽어야 함
scan4 <- scan('scan_4.txt', what="")
scan4

# scan()의 일반 사용은 사용자로부터 데이터를 입력받을 때 사용
# 한개의 데이터 입력 후 enter
# 데이터 입력 없이 enter : 입력의 종료
# 숫자 입력받기
input <- scan()
input

# 문자 입력받기: what=""
input2 <- scan(what="") # 문자의 구분을 띄어쓰기 또는 enter로 가능
input2

# 한줄 문자열 입력받기 : readline() => enter 키 입력 전까지 한문장으로 처리
input3 <- readline()
input3

# 입력 메시지 출력 가능
input4 <- readline("Are you OK? : ")
input4


# 텍스트파일의 한글 엔코딩 방식은 utf-8 이 기본

ex_data <- read.table("data_ex.txt")
ex_data

# 첫 행을 변수명으로 설정
ex_data <- read.table("data_ex.txt", header = TRUE)
ex_data # 1행이 data 값으로 인식

# 원시데이터의 구분이 , 로 
ex1_data2 <- read.table("data_ex1.txt", header = TRUE, sep=",")
ex1_data2
str(ex1_data2)

# header 데이터가 없는 원시파일인 경우 : Vn으로 기본 변수명 생성
ex2_data <- read.table("data_ex2.txt", sep=",")
ex2_data

# 파일 읽어오면서 변수명 생성
# 변수명으로 사용할 벡터 생성
var_name <- c("ID", "SEX", "AGE","AREA")

ex2_data <- read.table("data_ex2.txt",
                       sep=",",
                       col.names = var_name)
ex2_data

# skip 옵션 사용
# skip=2
ex_data2 <- read.table("data_ex.txt", header = TRUE, skip=2)
ex_data2

ex_data2 <- read.table("data_ex.txt", skip=2,
                       col.names = var_name)
ex_data2

#nrows 옵션 : 몇개의 행을 불러올지 지정
#nrows 파라미터는 header 파라미터보다 우선순위가 뒤에 있음
# nrows=7
ex_data3 <- read.table("data_ex.txt", header=TRUE, nrows=7)
ex_data3

# 원본파일에 주석기호가 포함되어 있는 경우
# 주석, 공백은 자동제외
fruit2 <- read.table('fruits_2.txt')
fruit2

# read.delim() 함수 사용해서 파일 읽어오기
ex_delim <- read.delim('data_ex.txt', sep=",")
ex_delim

ex_delim1 <- read.delim('data_ex1.txt', sep=",")
ex_delim1


#############################################################
# csv 파일 읽어오기
# csv 파일 : 범용 데이터 형식
# 값 사이를 쉼표로 구분
# 용량 작고, 다양한 소프트웨어에서 구분자를 사용할 수 있음
# read.csv()
##############################################################

fruit3 <- read.csv('fruits_3.csv')
fruit3

# 원본파일에 header 가 없는 경우 header=T 가 기본 파라미터이므로
# 1행이 header 처리
fruit4 <- read.csv('fruits_4.csv', header=F)
fruit4

# 헤더명(변수명) 직접 지정해서 가져오기
var_name <- c('NO', 'NAME', 'PRICE','QTY')
fruit4 <- read.csv('fruits_4.csv', header=F,
                   col.names = var_name)
fruit4
str(fruit4)

##############################################################
# 엑셀파일 읽어오기
# 엑셀관련 패키지 설치하고 로드 후 사용해야 함
# readxl 패키지

# 패키지 설치(install.packages("패키지명")) - 한번 설치로 계속 사용 가능
# 로드 : library(패키지명) 스크립트 열때마다 계속 실행해줘야 함
# install.packages("readxl")
library(readxl)

# 엑셀파일 읽어오기
# read_excel() 사용
excel_data_ex <- read_excel("data_ex.xls")
excel_data_ex
str(excel_data_ex) #tibble 구조로 읽어옴(data.frame과 같은 구조)

# 1번 sheet가 아닌 다른 sheet 읽어올 때 : sheet=sheet번호 사용
excel_data_ex2 <- read_excel("data_ex.xls", sheet=2)
excel_data_ex2

# header가 없는 원본 파일인 경우 : col_names = F
fruit_no_header <- read_excel('fruit_no_header.xlsx',
                              col_names = F)
fruit_no_header

# 변수명 지정 후 읽어오기
var_name2 <- c('NO', 'FRUIT', 'PRICE', 'QTY')
fruit_no_header1 <- read_excel('fruit_no_header.xlsx',
                              col_names = var_name2)
fruit_no_header1

# clipboard 에서 복사한 데이터 읽어오기 (엑셀, 텍스트파일 가능)
mid_exam <- read.delim("clipboard", header = T)
mid_exam

f_text <- read.delim("clipboard", header = T)
f_text

###############################################################
# 데이터 내보내기
# csv와 txt 파일로 저장
# write.csv(원본df, file='경로를 포함한 파일명') 사용

name <- c("홍길동", "이몽룡", "성춘향")
age <- c(23,30,25)
address <- c("서울", "부산", "남원")
df_member <- data.frame(NAME=name,
                        AGE=age,
                        ADDRESS=address)
df_member

write.csv(df_member,file="mem_test.csv")
# 외부 파일 저장 시 행/열 인덱스가 저장이 됨
# 행 이름이 추가되지 않도록 설정 : row.names=FALSE
write.csv(df_member,file="mem_test1.csv", row.names = FALSE)

# 따옴표 제외 파리미터 : quote = FALSE
write.csv(df_member,file="mem_test2.csv", row.names = FALSE,
          quote=FALSE)

########################################
# txt 파일로 저장 : write.table() 함수 사용
########################################

write.table(df_member, file='mem_text1.txt', row.names = FALSE,
            quote = FALSE)

########################################
# 엑셀파일로 저장하기
# writexl 패키지 사용
# write_xlsx(df, path='경로를 포함한 파일명')
########################################
# install.packages("writexl")
library(writexl)

member
# format_headers=T/F (기본값 : T)
write_xlsx(member, path='mem_text.xlsx')
write_xlsx(member, path='mem_text1.xlsx', format_headers = F)

#######################################
# rda 파일로 저장하기
# rda 파일 : R 전용파일(용량 작고 빠름)
# save(df, file='저장파일.rda') - 내보내기
# load('파일명.rda')
#######################################
member
save(member, file='data_ex.rda')
rm(member) # 원본 df 삭제
member # 에러

# 읽어오기
load('data_ex.rda') # 기존에 저장했던 원본 df 형태 그대로 load됨
member




