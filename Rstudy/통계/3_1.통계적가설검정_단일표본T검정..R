####################################
# 단일 표본 T 검정
# 단일 표본 t 검정 - sample은 정규성을 띈다
# 목적 : 그룹의 평균이 기준값과 차이가 있는지를 확인# 
# 귀무가설 : sample의 평균과 모집단의 평균은 같다# 
# 대립가설 : sample의 평균과 모집단의 평균은 다르다# 
# 가설 수립 예시 : 한 사이트를 운영하고 있는데 고객이 웹사이트에서 체류하는 평균시간이 10분이지 아닌지를 알고 싶어 가설 수립

# 선행조건
# 해당 변수가 정규분포를 따라야 함 : 정규성 검정이 선행되어야 함
# 단, 샘플수가 많을수록 정규성을 띌 가능성이 높아지므로, 
# 샘플수가 부족한 경우에만 정규성 검정을 수행
# 만약, 정규성을 띄지 않으면 비모수적인 방법인 부호검정 을 진행

# 정규성 검정 3가지 방법
# 1. qqplot
set.seed(1)
x <- sample(x=1:200, size=30, replace=F)
x
qqnorm(x)
qqline(x, col=2)

# 2. shapiro-wilk test
# 가장 간단한 확인 방법
# shapiro.test(x)
shapiro.test(x) # p-value = 0.05403
# 귀무가설 채택 : 정규성을 가정할 수 있다.

# 3. Kolmogorov-Smirnov test
# ks.test(x, ,"pnorm",mean(x),sd(x), 
# alternative = c("two.sided", "less", "greater"))
ks.test(x, "pnorm", mean=mean(x), sd=sd(x)) 
#  p-value = 0.4296 으로 유의수준 0.05보다 크므로
# 귀무가설을 채택(정규성을 가정한다)


##########################
# 단일 표본 T검정 EX

getwd()
setwd('통계')
# 데이터 불러오기
data <- read.table('data/heights.csv')
head(data)

#아버지들의 키의 평균은 170이다
# 데이터 추출
data_f <- data$father
data_f

# 정규성 검정
ks.test(data_f,"pnorm", mean=mean(data_f), sd=sd(data_f))
# p_value : 0.6085로 유의수준 0.05보다 크므로
# 귀무가설을 채택(정규성을 가정)

shapiro.test(data_f)
# p-value = 0.1962 유의수준 0.05보다 크므로
# 귀무가설을 채택(정규성을 가정)
##############################
# 1. 1 sample t test

# t.test(x, y = NULL,
#        alternative = c("two.sided", "less", "greater"),
#        mu = 0, paired = FALSE, var.equal = FALSE,
#        conf.level = 0.95, ...)

# 단일 표본 t검정 수행 - 검증 수치 평균 : 170
# 한 집단의 평균검정 : t.test(집단변수명, mu=기준값)
# data의 평균은 모집단의 평균과 같다
t.test(data_f, mu=170)
# p-value <2.2e-16 - 귀무가설을 기각(평균은 170이 아니다)
# t = 9.0664 t통계량은 양수 평균 >170
# 데이터의 평균은 170이 아니고 통계량에 대해 170을 초과를 추정할 수 있음

# 소표본이고 한집단 표본평균과 기준값(모평균)과 같은지 확인할 때 

data

# 정규성 검정
ks.test(data[,1],"pnorm", mean=mean(data[,1]), sd=sd(data[,1]))
# p-value = 0.8772 귀무가설 채택(정규성을 가정)

# 단일표본 T검정
# 귀무가설 : data의 평균은 모집단의 평균 163과 같다
t.test(data$V1, mu=163)
# p-value = 0.00651 유의수준 0.05미만이므로 귀무가설 기각
# t = -2.9728 통계량이 음수이므로 평균은 < 163












