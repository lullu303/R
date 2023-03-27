################################
# aggregate() 함수
# 특정 열을 기준으로 통계량을 계산 해주는 함수
# 데이터 프레임을 대상 통계 함수 사용

# install.packages("googleVis")
library(googleVis)
Fruits
fruits <- Fruits

# 년도별 판매량의 합계를 구하시오
# aggreate( 계산될 열 ~ 기준 열 , 데이터셋, 함수)
aggregate(Sales~Year, Fruits,sum)

# 과일별 판매 수량의 합계
aggregate(Sales~Fruit, Fruits,sum)

# 가장 적게 판매된 과일의 수량
aggregate(Sales~Fruit, Fruits, min)

# 가장 많이 판매된 과일별 수량
# aggregate(Sales~Fruit, Fruits, max)

# 기준열 추가
# '+ 추가조건'
aggregate(Sales ~ Fruit + Year, Fruits, sum)
Fruits

# 계산열 추가
aggregate(cbind(Sales, Expenses) ~ Year, Fruits, mean)

aggregate(cbind(Sales, Expenses) ~ Year+Date, Fruits, mean)

# 1~4호선 승하차 승객수 활용
df_subway <- read.csv("data/1-4호선승하차승객수.csv")
head(df_subway)

# 노선번호별 총 승차 인원수
aggregate(승차 ~ 노선번호, df_subway, sum)
class(res)

# 노선번호별 총 하차 인원수
aggregate(하차 ~ 노선번호, df_subway, mean)


aggregate(cbind(승차,하차) ~ 시간, df_subway, sum)

# apply() 계열 함수
# 함수를 적용해서 결과를 얻는 함수
# apply() : 행려르이 행 또는 열 방향으로 특정 함수를 적용

mat1 <- matrix(c(1,2,3,4,5,6), nrow=2, byrow=T)
mat1

apply(mat1,1,sum) #각 행의 합계를 구함
apply(mat1,2,sum) #각 행의 합계를 구함

##################################################
# # data1.csv : ansi -> utf 8

data1 <- read.csv("data/data1.csv")
View(data1)
ls(data1)
# [1] "X2000년" "X2001년" "X2002년" "X2003년" "X2004년" 
# "X2005년" "X2006년" "X2007년" "X2008년"
# [10] "X2009년" "X2010년" "X2011년" "X2012년" "X2013년" "연령별"

# 2. 연도별 합계를 모두 구하시오
# 연령별은 제외 후 연산 진행
# data[-1] : 1열 제외 모든 열
apply(data1[-1],2,sum) # 1-행, 2-열

class(apply(data1[-1],2,sum)) # "numeric" ; vector형으로 반환

# 3. 연령별 합계를 출력
apply(data1[-1],1,sum)
class(apply(data1[-1],1,sum))
# apply() 함수에 적용가능한 함수(모든 함수(사용지 정의 함수))

########################################
# lapply() : 반환값이 list 형태
# list인 경우 대부분 unlist 해서 사용. 활용도가 높지는 않음

ls_s <- list(Fruits$Sales)
ls_p <- list(Fruits$Profit)

# ls_s, ls_p 에서 mas값을 추출
lapply(c(ls_s, ls_p), max)
# 반환 형태 : list

sapply(c(ls_s, ls_p), max)
# 반환 형태 : vector

df_ab <- data.frame(a= c(1,7,3), b= c(5,7,8))
sapply(df_ab,max)
lapply(df_ab, max)

######################################################
# tapply(계산열, 기준열, 적용함수) : 특정 요소를 기준으로 그룹화하여 함수 수행
# group_by 효과 : ~ 별로 ~ 수행

#
Fruits
tapply(Fruits$Sales, Fruits$Fruit, sum) # 벡터 반환

attach(Fruits) # df각 속성을 계산에 용이하게 사용하기 위해 현ㅅ크립트에 포함시킴
# df를 attach하면 df없이 컬럼만 변수(객체) 처럼 사용가능
Sales;Fruit
tapply(Sales, Fruit, sum)

# attach() : 데이터를 R탐색 경로에 추가
# detach() : 데이터를 R탐색 경로에서 제거

#
# mapply(함수, 벡터1, 벡터2, 벡터3, ... , )
# 여러 개의 벡터 또는 리스트를 인자로 받아서 
# 지정된 함수에 데이터의 동일 위치 요소들을 적용시킨 결과를 반환
# 데이터 프레임이 아닌 데이터에 대해 데이터프레임처럼 연산해 주는 기능

v1 <- c(1,2,3,4,5)
v2 <- c(10,20,30,40,50)
v3 <- c(100,200,300,400,500)

mapply(sum, v1,v2,v3)

v4 <- c(1000,2000,3000,4000)
# mapply(sum, v1, v2, v3, v4)
# v4 의 요소 수가 다른 벡터보다 짧다
# mapply에 사용할 벡터들은 같은 길이여야 함


# sweep() 함수
# 행렬, 배열, 데이터프레임에 연산자를 적용하는 함수

mat1 <- matrix(c(1,2,3,4),2,2)
mat1

a <- c(1,3)

sweep(mat1,2, a) # 빼기연산(디폴트), mat1의 각 행에 대해서  a벡터 값을 뺀 결과
sweep(mat1,2, a, "+") # 더하기 연산







install.packages("stringr")

library(stringr)

#####
# . : 문자 1개를 의미
stri <- c("ABB", "aaB", 'aa.b', "aAb")
str_detect(stri, "a.b")
# 패턴문자 a.b 소문자 a가 한번 나오고 어떤문자든 1번 나오고 소문자 b가 나타나는 패턴

# ... : 3개의 문자를 포함하는
pt <- '...'
strstr_detect(stri,pt)

stri <- c("ABB", "aaB", 'aa.b', "aAb")
str_detect(stri, pt)

#################
# str_count() : 특정 문자 출현 횟수 세는 함수

# 대소문자 변환

# 모든 문자를 대문자로
str_to_upper(fruits)


# 모든 문자를 소문자로
str_to_lower(fruits)

# 단어의 첫 문자를 대문자로
str_to_title(fruits)

str_to_title('aPPLE') #"Apple" 단어의 첫문자는 대문자로 나머지 문자는 소문자로
# 단어의 구분 ' ', ',' , ....

# str_c() : 문자열 합치기
str_c("apple", "banana")
fruits
str_c(fruits)
str_c("Fruits : ", fruits)

# 벡터집합의 모든 요소를 하나의 문자열로 결합
# collapse : 구분자 사용
str_c(fruits, collapse="")
str_c(fruits, collapse=" ")
str_c(fruits, collapse = "-")

# str_dup() : 반복 출력
str_dup(fruits, 3)

# 문자열 길이 반환
str_length(fruits) # 벡터의 각 요소의 길이
length(fruits) # 벡터의 요소의 개수

# str_locate(데이터, 특정 문자) : 특정 문자의 위치값 반환
str_locate('pineapple', 'e')
str_locate('pineapple', 'p') # 첫번쨰 찾은 문자의 위치
# 집합 데이터에 대입하면 행열 반환
str_locate(fruits, 'a')

str_locate("서울시 강남구 역삼동", "강남구")
# start end
# [1,]     5   7

str_apple = "apple"

# str_replace(전체문자열, 대상, 교체될 문자)
str_replace(str_apple, 'p', '*')








