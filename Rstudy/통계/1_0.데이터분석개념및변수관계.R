#################################
# 변수
################################

# 범주형 변수/수치형 변수
# 범주형 : 관측치 들이 몇개의 정해진 값만 갖고 있음
# 수치형 : 연속적인 다양한 값을 갖고 있음

# 변수들간의 관측치의 차이를 확인하고 설명
# 절대적인 차이 / 상대적인 차이
# 상대적인 값 : 절대적인 값을 변형해서 생성해낸 수치
# 수학점수와 수학등수
# 90점 vs 70점 / 2등 vs 4등

###############################
# 범주형 변수의 차이 확인 - 요약
# 한개의 범주형 변수의 요약
###############################

# 한개의 범주형 변수 생성
GENDER <- c('남','여','여','남','여','여','여','남','남')
GENDER <- factor(GENDER)
# factor() : 범주형변수로 변환할 때 사용

# levels()로 수준(범주) 확인
levels(GENDER) 
# [1] "남" "여"
# GENDER 변수는 남/여 두개의 범주(level)로 정의됨

# 범주형 변수의 요약
# 절대적인 차이/상대적인 차이로 요약 

# table()로 빈도표 생성 - 절대적인 차이 확인
t_gender <- table(GENDER)
t_gender
# GENDER
# 남 여 
# 4  5

# 상대 빈도 계산 - 상대적인 차이 확인
# 전체 개수 측정
length(GENDER) # 9
sum(t_gender) # 9

t_gender/length(GENDER)
# 남        여 
# 0.4444444 0.5555556 

# 상대빈도 계산함수 prop.table() 상대 빈도 계산
# 절대빈도표를 상대빈도표로 변환
prop.table(t_gender)
# GENDER
# 남        여 
# 0.4444444 0.5555556 

# 범주형 변수의 시각화
# 막대그래프  /   원그래프
# 수준의 높이로 표현   /  원을 분할
# 절대적인 차이/상대적인 차이

#############
# 시각화로 차이 비교
#############
t_gender

barplot(t_gender)
pie(t_gender)

############################
# 수치형 변수의 요약
# 1. 정렬등을 활용한 요약
# 최대값, 최소값, 중앙값등 관측치들의 위치를 활용한 요약
# 2. 합계를 활용한 요약
# 평균, 분산, 표준편차 값의 특성을 활용한 요약
# 기술통계량 활용

# 통계량 vs 기술통계량
# 데이터로부터 계산된 모든 숫자 : 통계량
# 변수자체나 변수들간의 관계등 데이터의 특성을 설명하는 통계량

##############################
# 한개의 수치형 변수의 요약
##############################

# 데이터
score = c(60, 78, 83, 74, 100, 80, 90, 85, 70)

# sort() 관측치 정렬
sort(score)
sort(score, decreasing = TRUE)

# 위치통계량
mean(score) # 평균
min(score) # 최소값
max(score) # 최대값
median(score) # 중앙값

# 최빈값
mode_y<-table(score)
names(mode_y)[which(mode_y==max(mode_y))]

which(mode_y==2)
# 9 반환
names(mode_y)[9]

# quantile() 함수로 다양한 분위수 계산
quantile(score,0.25) #74
quantile(score,0.75) #85
quantile(score,0.5) #80
# type= 생략되어 있으면 type=7 로 계산
# [1]  60  70  74  78  80  83  85  90 100
??quantile

quantile(score,0.25, type=5)
quantile(score,0.75, type=5)

# quantile() 함수는 계산하는 알고리즘 type에 
# 따라 다른 결과가 나옴

# summary() 함수 - 다섯 숫자 요약
summary(score)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 60      74      80      80      85     100 

# 위치 통계량 시각화 도구
score
# boxplot
boxplot(score)

# hist
hist(score)
hist(score, breaks=seq(50,100,5))

# 하나의 수치형 변수의 대략적인 분포를 확인

###################################
# 여러 수치형 데이터를 비교 (시각화)
###################################

##################################
# 2개의 데이터를 히스토 그램으로 비교
##################################

# 두개의 df 생성
carrots <- data.frame(length=rnorm(100000, 6, 2))
cukes <- data.frame(length=rnorm(50000, 7, 2.5))

View(carrots)
View(cukes)

# 각 df에 분류 추가
carrots$veg <- 'carrot'
cukes$veg <- 'cukes'

# 두 df 결합
vegLengths <- rbind(carrots,cukes)
View(vegLengths)

# 당근과 호박의 길이 데이터 분포 비교
# 히스토 그램

library(ggplot2)
ggplot(vegLengths, aes(length, fill=veg)) +
  geom_histogram(alpha=0.5, aes(y=..density..), position='identity')


###########################
# box plot을 활용한 집단 비교
###########################

mtcars$cyl.f <- factor(mtcars$cyl,
                       levels = c(4,6,8),
                       labels = c("4","6","8"))

mtcars$am.f <- factor(mtcars$am,
                       levels = c(0,1),
                       labels = c("auto","standard"))
View(mtcars)
boxplot(mpg ~ am.f * cyl.f,
        data=mtcars,
        varwidth=TRUE,
        col=c("gold","darkgreen"),
        xlab="AUTO TYPE",
        ylab="Miles per Gallon")

######################################
# 변이 통계량(데이터의 흩어진 정도)
######################################
score
# [1]  60  78  83  74 100  80  90  85  70
# 범위 : 최대값과 최소값의 차이
# 데이터의 퍼져있는 정도를 나타내는 가장 간단한 방법
# 극단적인 값에 영향을 받음
# 2개의 정보만 이용하므로 적절한 척도로 사용하기 어려움

R <- max(score) - min(score)
R

# 중간범위 : 최대값과 최소값의 평균
mean(c(max(score), min(score))) # 80

##############################
# 사분위수 편차
# 극단값 영향으 ㄹ받는 범위 문제점을 보완
# 사분위간 범위(ior)값ㅇ르 2로 나눈 4분 위 범위의 평균

score = c(60,78,83,74,100,80,90,85,70)
Q1 <- quantile(score,0.25)
Q3 <- quantile(score, 0.75)

# 사분위간 범위(IOR)
Iqr <- Q3-Q1
Iqr

# 사분위 편차
Q <- Iqr/2
names(Q) = '사분위편차'
Q
  
##########################
# 분산/ 표준편차 / 변동계수 계산
######################
score
# [1]  60  78  83  74 100  80  90  85  70
mean(score)
var(score)  
sd(score)  
sd(score)/mean(score) # 변동계수  
  
#############################
# 변동계수의 필요성
#####################
  
x1 <- c(1,2,3,4,5)
x2 <- x1 * 10  
x2

# 표준편차 계산
sd(x1)
sd(x2)

# 변동계수 계싼
sd(x1)/mean(x1) # [1] 0.5270463
sd(x2)/mean(x2) # [1] 0.5270463
# 단, 변동계수는 모든 계수가 양수 아니면 잘 사용되지 않는다

###################################################
# 데이터으이 상대적인 위치
##################################################
# 응시자 수 50명의 시험점수에 대해 
# 점수 60저뫄 90점의 상대점수 계산
getwd()
setwd('통계')
getwd()

score =scan('data/score_50.txt')
score

# 백분율
# 전체 관측치 중 특정 값보다 작은 관측치 개수의 비율을 0~1사이값으로 계싼 
# 사이값으로 계산
length(score[score <=60]) # [1] 5
u_60 <- length(score[score <=60]) # 60점 이하인 점수의 수
u_90 <- length(score[score <=90]) # 90점 이하인 점수의 수
# 60점과 90점의 상대점수 계산
u_60 /length(score) # [1] 0.1 하위 10%
u_90 / length(score) # [1] 0.9 하위 90%


# 최대~최소 정규화
#####################
# Min_Max 변환
# 공식 : x원소, X원소 집합
# x_scale = x-min(X) /range
# 관측치 데이터의 범위에서 특정값의 상대적인 위치를 0~1 사이의 값으로 계산 
# 최소값 ~ 최대값 기준
min_s = min(score)
max_s = max(score)

# 전체 구간의 길이(범위)
range <- max_s - min_s

# 60점의 최소-최대 상대점수
(60-min_s)/range # [1] 0.2

# 90점의 최소-최대 상대점수
(90-min_s)/range # [1] 0.8

# 관측치 데이터의 범위에서 특정값의 상대적인 위치를 0~1사이의 값으로 계산 

# 표준화
# 특정값이 평균으로부터 떨어진 정도를 표준편차 단위로 표현
# 평균과 표준편차에 따라 부호에 상관없이 다양한 값을 가질 수 있음
# 공식 : x_scale = x-mean(X)/sd(X)

# 표준화 
mean_s = mean(score)
sd_s= sd(score)

# 60점에 대한 표준화 변환 상대점수
(60-mean_s)/sd_s # [1] -1.300184

# 90점에 대한 표준화 변환 상대점수
(90-mean_s)/sd_s # [1] 1.162286

# scale() 함수 활용
scale(score)


##############################################
# 두 변수에 대한 요약
#############################################
# 두 범주형 변수

# 데이터 불러오기
TWO_CATE <- read.csv('data/TWO_CATE.csv')
str(TWO_CATE)

###############################################
# 분할표 생성
# table(data1, ... )

# 한 변수의 빈도표
table(TWO_CATE$GENDER)
# 남 여 
# 4  5 

# 두 변수에 대한 교차표(분할표)
table(TWO_CATE$GENDER, TWO_CATE$AGE)
# 20대 30대
# 남    1    3
# 여    2    3

# 범주형 데이터 : 혈액형
blood <- c('A','B','A','AB','O','A','A','O','O','B',
           'A','B','A','O','AB','B','O','AB','O','B')

# 범주형 데이터 : 성별
gender <- c('F','F','M','M','M','F','M','F','M','F',
            'M','M','F','M','M','M','M','M','F','F')

name <- c('정수병','박성동','박산우','김현수','류성희',
          '전창욱','김소향','백지향','김미성','고희태',
          '강청남','송시현','이아련','최소한','김명화',
          '최두경','김아름','홍길동','홍수채','강감찬')

tbl_blood <- table(blood)
tbl_blood

# 분할표의 합계 계산하기
c(tbl_blood, sum(tbl_blood))


# addmargins(A) : 분할표에 합계를 추가해주는 함수
addmargins(tbl_blood)

bDF <- data.frame(name, gender, blood)
str(bDF)

# df의 분할표(교차표)
table(bDf[,c(2,3)])


addmargins(table(bDf[,c(2,3)]))

############################
# 분할표 작성 2 : xtabs()
# 명목형 또는 순서형 데이터의 도수를 표 형태로 기록해놓은것
# xtabs(formula = , data = )

d <- data.frame(x=c("1","2","2","1"), y=c("A","B","A","B"), freq=c(3,5,8,7))
d

# 빈도를 나타내는 컬럼 있는 경우
# 교차표로 재구성
xtabs(freq~x+y, data=d)

# 범주형 변수로만 구성되어 있는 경우
d1 <- data.frame(x=c("1","2","2","1","1","2"), y=c("A","B","A","B","A","B"))
d1
xtabs(~x+y, data=d1)
#   y
# x A B
# 1 2 1
# 2 1 2
# 교차표에서의 차이
# 절대적인 차이 : 이 칸에 관측치가 많다.
# 상대적인 차이 : 이 칸의 데이터 범주가 상대적 비율이 높다

# 분할표의 주변 합을 계산
# margin.table(x, margin=NULL/1/2)
# x : 분할표
# margin : 1은 행방향, 2는 열방향, NULL전체 값의 합

d
xt <- xtabs(freq ~ x +y, data=d)

# 주변 합 계산
margin.table(xt,1) # 행의 합
margin.table(xt,2) # 열의 합
margin.table(xt) # 전체 도수의 합

########################
# 상대 빈도표 생성
# 각 행(열)에서 상대빈도를 계산
# 각 수준의 전체 상대 빈도 비교
# prop.table()

xt
prop.table(xt,1) # 행 data에 대한 각 값의 비율
# y
# x           A         B
# 1 0.3000000 0.7000000
# 2 0.6153846 0.3846154

prop.table(xt,2)
# y
# x           A         B
# 1 0.2727273 0.5833333
# 2 0.7272727 0.4166667

prop.table(xt) # 전체 빈도의 합(23)에 대한 각 도수의 비율
xt

###########################
# 교차표의 시각화 
# heatmap : 2차원 분할표(교차표)를 숫자대신 색으로 표현한 그래프
# 색의 진하기로 크기를 표현

tbl_two <- table(TWO_CATE)

heatmap(tbl_two)
par(pty="m")

heatmap(tbl_two,
        Rowv = NA, Colv = NA, scale='none',
        col=colorRampPalette(c('ivory', 'red'))(100))

colorRampPalette(c('ivory', 'red'))(100)


# 대량 데이터 이용한 heatmap
AGE_CITY = as.matrix(read.csv('data/agecity.csv', row.names = 1))
View(AGE_CITY)

heatmap(AGE_CITY,
        Rowv = NA, Colv = NA, scale='none',
        col=colorRampPalette(c('ivory', 'red'))(100))

# 상대빈도표를 이용한 heatmap
# 
prop.table(AGE_CITY,1)
prop.table(AGE_CITY,2)

heatmap(prop.table(AGE_CITY,1),
        Rowv = NA, Colv = NA, scale='none',
        col=colorRampPalette(c('ivory', 'red'))(100))

heatmap(prop.table(AGE_CITY,2),
        Rowv = NA, Colv = NA, scale='none',
        col=colorRampPalette(c('ivory', 'red'))(100))

####################################################################
# 두 수치형 변수의 요약
# 2차원 공간의 시각화 : 산점도

# 두 수치형 변수를 가로축/세로축으로 활용하여 그린 그래프 
# 두 변수의 평균을 보조선으로 활용 : 2차원 공간의 무게중심 표현 

# 2차원 데이터의 산점도
two_cont <- read.csv('data/TWO_CONT.csv')
two_cont

# 공부시간과 시험점수 관측 데이터 
# HOUR SCORE
# 1    0    60
# 2    4    78
# 3    3    83
# 4    6    74
# 5    6   100
# 6    7    80
# 7    8    90
# 8    8    85
# 9    3    70

# plot()
plot(two_cont, pch=16, col='blue')

# 보조선 추가
# abline(v=/h=) 활용
abline(v=mean(two_cont$HOUR), lty=2)
abline(h=mean(two_cont$SCORE), lty=2)

#############################
# 두 수치형 변수의 관계를 계산한 기술 통계량
# 공분산
# 0에 가까울수록 두 변수는 관련이 없음
# 큰 양수가 나올수록 두 변수는 양의 상관을 갖게 됨
#####
# 공식 : sum((x-mean(X))) * (y-mean(Y))/(n-1)
######
h <- two_cont$HOUR - mean(two_cont$HOUR)
# [1] -5 -1 -2  1  1  2  3  3 -2
s <- two_cont$SCORE - mean(two_cont$SCORE)
# [1] -20  -2   3  -6  20   0  10   5 -10

h*s

sum(h*s) / (nrow(two_cont)-1) # [1] 21.875
# cov() 공분산 구하는 함수
cov(two_cont$HOUR, two_cont$SCORE) # [1] 21.875

# 공분산은 두 변수의 관계에 대한 절대적인 요약값임
# 두변수의 단위 문제가 발생

# 상관계수(피어슨) 도입
# -1 <= 상관계수 <= 1
# 공식 : cov(x,y)/sqrt(var(x)*var(y))

# 상관계수
cov(two_cont$HOUR, two_cont$SCORE)/sqrt(var(two_cont$HOUR) * var(two_cont$SCORE))
# [1] 0.7011677 => 강한 양의 상관

cor(two_cont$HOUR, two_cont$SCORE) 
# [1] 0.7011677
# 공부시간과 점수는 강한 양의 상관관계를 갖는다 

###################################################
# 한 범주형 변수와 한 수치형 변수
getwd()
setwd('통계')
# 데이터 불러오기
two_var1 <- read.csv('data/TWo_VAR1.csv')
two_var1

# aggregate(계산열 ~ 기준열, data=, 통계함수) 조건부 평균 계산
aggregate(SCORE~CITY, data=two_var1, mean)
mean(two_var1$SCORE)


# 조건부 평균 2
two_var2 <- read.csv('data/TWo_VAR2.csv')
two_var2

#  공부방법별 점수의 평균 차이
aggregate(SCORE~METHOD, data=two_var2, mean)
# A 공부방법으로 공부한 학생들의 성적은 전체 평균보다 높다

# 그룹별 BOXPLOT을 활용한 시각화

# 도시에 따른 점수 비교
boxplot(SCORE~CITY, data = two_var1)

# 공부방법에 따른 점수 비교
boxplot(SCORE ~ METHOD, data=two_var2)


# 그룹별 상자그림 예 2
#######################################
# 1000명의 고객의 거주지와 방문 횟수 데이터
######################################

city_count <- read.csv('data/city_count.csv')
View(city_count)
nrow(city_count)
ls(city_count) # [1] "CITY"  "COUNT"

# 거주지별 고객수
aggregate(COUNT ~ CITY, data=city_count, length)

# 거주지별 고객들의 총 방문횟수
aggregate(COUNT ~ CITY, data=city_count, sum)

# 거주지별 고객들의 평균방문횟수
aggregate(COUNT ~ CITY, data=city_count, mean)

boxplot(COUNT~CITY, data=city_count)

##########################################################
# 수치형 변수의 구간화를 활용한 조건부 요약
#########################################################

two_var2

# cut(data=, breaks=구간 수/구간기준) 함수로 수치형 변수를 구간화하기
# 구간 경계값 지정 : 0 ~ 75, 76~85, 86~100
breaks = c(0,75,85,100)

# 구간화
score_grp <- cut(two_var2$SCORE, breaks = breaks)

score_grp

two_var2$SCORE_GRp <- score_grp
two_var2

# 교차표 생성
table(two_var2$METHOD, two_var2$SCORE_GRp)
table(two_var2$SCORE_GRp, two_var2$METHOD)

# 시각화
heatmap(table(two_var2$SCORE_GRp, two_var2$METHOD),
        Rowv = NA, Colv = NA, scale='none', 
        col=colorRampPalette(c('blue','red'))(100))


















