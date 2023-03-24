# 실습 사용 excel 파일 읽어오기
setwd("../")
getwd()
# 패키지 로드
# install.packages("readxl")
library(readxl)
exdata1 <- read_excel("data/Sample1.xlsx")

# tibble
# 데이터프레임을 업그레이드 한 형태
# Data Science를 위해 개발된 R 패키지 중 
# tidyverse 패키지에서 사용하는 데이터 형태
# 원시 데이터 구조 확인 
str(exdata1)
# 데이터 형태 : tbl, data.frame
# 관측치 10 / 변수 8개
# 데이터 형태 : num(실수), chr(문자)

dim(exdata1)
# 10행 8열의 구조

ls(exdata1)
# [1] "AGE"     "AMT16"   "AMT17"   "AREA"    "ID"      "SEX"     "Y16_CNT" "Y17_CNT"
# 2016년 2017년 신용카드 사용 현황 데이터 
# AMTxx : 사용금액, xx_CNT : 사용건수
# 금액은 AMT먼저 나오고 건수는 연도가 먼저 나옴
# 변수명은 건수에 맞게 금액의 변수명 변수 : Yxx_AMT

# 변수명 변경(일부변경)
library(dplyr)

#rename() 이용 - 원본 저장 필요 
exdata1 <- rename(exdata1, Y17_AMT = AMT17, Y16_AMT=AMT16)
head(exdata1,2)










