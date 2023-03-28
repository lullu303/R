library(googleVis)
ls(Fruits)
# [1] "Date"     "Expenses" "Fruit"    "Location" "Profit"   "Sales"    "Year"

# 과일별 판매액 평균
aggregate(Sales~Fruit, Fruits, mean)

# 과일별 비용의 최대값
aggregate(Expenses~Fruit, Fruits, max)

# 과일별 수익의 최소
aggregate(Profit~Fruit, Fruits, min)

# 위치별 판매금액의 평균
aggregate(Sales~Location, Fruits, mean)

aggregate(Profit~Location+Fruit)

# 지역 연도별 수익의 최대값
aggregate(Profit~Location+Year, Fruits,max)

df_subway <- read.csv("data/1-4호선승하차승객수.csv")
View(df_subway)
ls(df_subway)

# 노선 번호별 총 승차 인원수를 구하시오
aggregate(승차~노선번호, df_subway,sum)
# 노선 번호별 총 하차 인원수를 구하시오
aggregate(하차~노선번호, df_subway, sum)
# 노선 번호별 승차 인원수 평균을 구하시오
aggregate(승차~노선번호, df_subway, mean)
# 노선 번호별 하차 인원수 최소값을 구하시오
aggregate(하차~노선번호, df_subway, min)
# 노선 번호별 승차, 하차 각 최대값을 구하시오
aggregate(cbind(승차,하차)~노선번호,df_subway,max)

# 노선번호별 승하차 총 인원수를 구하시오
aggregate(cbind(승차,하차)~노선번호,df_subway,sum)

# 계산열에서 + 연산은 실제 컬럼의 덧셈연산을 진행
# => 노선번호별 승차와 하차를 더한 인원수의 최대값
aggregate(승차+하차~노선번호, df_subway, sum)
aggregate(승차+하차~노선번호, df_subway, max)

# apply() 연습문제
data1 <- read.csv("data/data1.csv")
data1
View(data1)
ls(data1)
# [1] "X2000년" "X2001년" "X2002년" "X2003년" "X2004년" "X2005년" "X2006년" "X2007년" "X2008년" "X2009년"
# [11] "X2010년" "X2011년" "X2012년" "X2013년" "연령별"

# 연도별 합계
col_sum <- apply(data1[-1],2,sum)
col_sum

# 연령별 합계
row_sum <- apply(data1[-1],1,sum)
row_sum

# 2008년부터 2012년까지 연도별 합계를 각각 구하시오
# data1[,c['x2008년':'x2012년']]
apply(data1[10:14],2,sum)
# 2008년부터 2012년까지 연령별 합계를 각각 구하시오
apply(data1[10:14],1,sum)
# 2000년, 2005년, 2010년의 연도별 합계를 각각 구해 d1에 대입하시오
d1 <- apply(data1[c('X2010년', 'X2000년', 'X2005년')],2,sum)
# 2000년, 2005년, 2010년의 연령별 합계를 각각 구해 d2에 대입하시오
d2 <- apply(data1[c('X2010년', 'X2000년', 'X2005년')],1,sum)
d2

# sapply() 연도별 합계를 구하시오
class(sapply(data1[-1],sum))

data2 <- read.csv("data/1-4호선승하차승객수.csv")
head(data2)

# 노선번호별 총 승차 인원수를 구하시오(tapply) # tapply => 그룹핑의 역할
# tapply(계산값, 기준값, 통계함수)
attach(data2)
tapply(data2$승차, data2$노선번호, sum)
tapply(승차, 노선번호, sum)
tapply(하차, 노선번호, sum)

# 데이터2의 총승차 및 총하차 인원수
# sapply는 전달되는 계산 데이터가 list나 df이어야 함
sapply(data2[3:4],sum)
sapply(cbind(승차,하차),sum) 
# 전달된 계산 데이터가 매트릭스형이기 때문에 다른 결과가 생성

# lapply 계산 데이터는 리스트나 df여야 함
lapply(data2[3:4],sum) # 리스트로 결과가 반환

apply(data2[3:4],2,sum) # 벡터로 반환

#############################################################
# stringr 패키지 : 문자열 처리 함수를 포함한 패키지
library(stringr)
mystr<-'홍길동15강감찬25이순신35,김유신45'

# 문자열 길이
len <- str_length(mystr)
len

# '김유신'문자열 위치
str_locate(mystr, '김유신') # 행렬 반환
# start end
# [1,]    17  19

# 부분 문자열
str_sub(mystr, 2, 5)
str_sub(mystr, 5,)
str_sub(mystr,1,5)

mystr = 'hello world'

# 대소문자 변환 함수
str_to_lower(mystr)
str_to_upper(mystr)
str_to_title(mystr)

mystr="hong1234"

# 문자 대체 함수
str_replace(mystr, 'hong', 'kang')

# 문자 결합
str_c(mystr,'choi9876')

mystr = 'kim,lee,choi,park'
# 문자 분리 함수
str_split(mystr,',') # list로 반환
unlist(str_split(mystr,',')) # 벡터로 변환

human=c('홍길동10', '박영희20', '김철수30', '이몽룡40')
str_c(human, collapse = '/')
paste(human, collapse = '/')

fruits <- c('apple','Apple','banana','Pineapple',"Java","jungle")

str_detect(fruits,'P')
str_detect(fruits, '^b')
str_detect(fruits, '^[Jj]')
str_detect(fruits,'[lp]')

############################
# sqldf 패키지 - sql 쿼리 문장을 df에 적용시킬 수 있는 함수
library(sqldf)
library(ggplot2)

# cyl 개수가 4개인 자동차 정보 추출
sqldf("select * from mpg where cyl=4")

# 제조사별 고속도로 연비의 최대값 
sqldf("select manufacturer,max(hwy), min(cty) from mpg group by manufacturer")













