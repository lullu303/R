# 정규분포 관련 함수
# 특정 숫자가 발생하는 확률 반환(추정값)
# dnorm(x,mean,sd)
# 주어진 숫자 범위까지의 누적확률 반환
# pnorm(q,mean,sd)
# 주어진 누적확률값에 해당하는 확률변수 계산
# qnorm(p,mean,sd)
# 난수 생성
# rnorm(n(생성 개수), mean, sd)

# 평균이 0, 표준편차가 1인 정규분포를 따르는 난수를 10개 생성
rnorm(n=10, mean=0, sd=1) # mean=1, sd=1 기본값

# 평균이 100 표준편차가 20인 정규분포를 따르는 난수 10개 생성
rnorm(n=10, mean=100, sd=20)

set.seed(0)
rnorm(10)

# 정규분포에서 확률값을 계산
set.seed(0)
rNorm10 <- rnorm(10)
rNorm10

p <- dnorm(rNorm10)
p

library(ggplot2)
# 확률분포 그래프 확인
n_df <- data.frame(rNorm10, p)
n_df

ggplot(n_df, aes(x=rNorm10, y=p)) +
  geom_line()

dnorm(c(-1,0,1))
# [1] 0.2419707 0.3989423 0.2419707

n_df2 <- data.frame(n=c(-1,0,1), p=dnorm(c(-1,0,1)))

ggplot(n_df2, aes(x=n, y=p)) +
  geom_line()


# 정규분포에서 누적 확률값 계산
# pnorm(q)
s_n <- sort(rNorm10)
s_n # 확률변수

dnorm(s_n) # 확률변수 각 값에 대한 확률

pnorm(s_n) # 확률변수 각 값까지의 확률

t_p <- pnorm(c(-3,0,3))

qnorm(t_p) # [1] -3  0  3

##############################################
# 두 지점에서 확률값 계산
# 정규 난수를 사용해서 플롯팅
set.seed(0)
randNorm <- rnorm(30000,mean=0, sd=1)
randDensity <- dnorm(randNorm)

p <- ggplot(data.frame(x=randNorm, y=randDensity) ,
              aes(x=x, y=y)) +
  geom_line() + labs(x="x", y="Density")

p # 30000개의 난수에 대한 밀도 함수 그래프 

# -2에서부터 +2까지의 확률
pnorm(2) - pnorm(-2)

# -2에서 0까지의 누적확률
pnorm(0) - pnorm(-2)

# -2까지의 영역 플롯팅
# 왼쪽에서 -2까지의 정규난수를 추출
neg2Seq <- seq(from = min(randNorm), to = -2, by=0.1)

# 확률값 계산 후 df 생성
lessThanNeg2 <- data.frame(x=neg2Seq, y=dnorm(neg2Seq))

# 영역그래프 생성
# 영역은 닫혀 있어야 하므로 영역의 양 끝에 y축 값이 0인 데이터 추가 
c(min(randNorm),0)
c(max(randNorm),0)

lessThanNeg2 <- rbind(c(min(randNorm),0) , 
                      lessThanNeg2,
                      c(max(lessThanNeg2$x),0))

head(lessThanNeg2,3)
tail(lessThanNeg2,3)

# 그래프 그리기
p + geom_polygon(data=lessThanNeg2, aes(x=x, y=y))

##################
# -2에서 2까지의 확률값을 플로팅
neg2Pos2Seq <- seq(from=-2, to=2, by=0.1)
neg2To2 <- data.frame(x=neg2Pos2Seq,
                      y=dnorm(neg2Pos2Seq))

neg2To2 <- rbind(c(min(neg2To2$x),0),
                 neg2To2,
                 c(max(neg2To2$x),0))
p + geom_polygon(data=neg2To2 , aes(x=x, y=y))
pnorm(2) - pnorm(-2)

##################################################
# 어떤 회사에서 제조되는 전구의 수명시간은 정규분포를 따른다
# 제조 전구의 평균 수명시간 3,000시간, 표준편차 80시간
# 임의로 선택한 전구 1개의 수명시간이 2,948 ~ 3,080 시간 사이일 확률

mu = 3000
sigma = 80
x1=2948 ; x2=3080

pnorm(x2, mean=mu, sd=sigma) - pnorm(x1, mean=mu, sd=sigma)

z1 <- (x1-mu)/sigma # -0.65
z2 <- (x2-mu)/sigma # 1
pnorm(z2) - pnorm(z1)
# [1] 0.5834986

############################
# 정규분포 밀도함수 생성
##############################
# mu : 평균
# sigma : 표준편차 


Norm_F <-function(x) {
  return ((1/sqrt(2 * pi * sigma**2)) * (exp(-(x-mu)**2/(2*sigma**2))))
}

# 남자 고등학생 키의 평균이 170CM이고 표준편차가 5CM라면,
# 우연히 만난 남자 고등학생의 키는 N(170,5^2)를 따른다고 할 수 있다.

# 남자 고등학생의 키 ~N(170,5^2)


mu=170
sigma=5
Norm_F(170)
integrate(Norm_F, 165,175)

# 키 165인 남자 고등학생을 우연히 만날 확률
Norm_F(175)
dnorm(175, mean = mu, sd=sigma)

# 키 165~175 사이의 남자고등학생을 우연히 만날 확률
integrate(Norm_F,165,175)
pnorm(175, mean=170, sd=5, lower.tail = TRUE) - pnorm(165, mean = 170, sd=5, lower.tail = TRUE)
# [1] 0.6826895

# lower.tail = TRUE/FALSE
# lower.tail = TRUE 이면 확률 계싼 범위P(X <= x)
# lower.tail = FALSE 이면 확률 계싼 범위P(X > x)


####################################
# 모의고사 평균 점수가 70점이고 표준편차가 8점이라면
# 우연히 만난 학생의 점수는 N(70,8^2)을 따른다고 할 수 있다
# 이 사실을 바탕으로 우연히 만난 학생의 점수가 54점 이상 86점 이하일 확률
mu=70
sigma=8
integrate(Norm_F,54,86)
# 0.9544997 with absolute error < 1.8e-11
pnorm(86,70,8) - pnorm(54,70,8) # 0.9544997

#####################################
# 취득점수 영어 : 80점(60,10), 중국어 : 65점(50,5)

# 영어 점수 80점보다 높은 점수의 비중
pnorm(80,mean=60, sd=10, lower.tail = F)
# [1] 0.02275013

# 영어 점수 80점보다 낮은 점수의 비중
pnorm(80,mean=60, sd=10, lower.tail = T)
# [1] 0.9772499

# 중국어 점수 65점보다 높은 점수의 비중
pnorm(65,mean=50, sd=5, lower.tail = F)
# [1] 0.001349898

# 중국어 점수 65점보다 낮은 점수의 비중
pnorm(65,mean=50, sd=5, lower.tail = T)
# [1] 0.9986501

#################
# 평균 무게 300g 표준편차 50g인 A농장의 사과들 중
# 무게가 203.81g ~ 302.9g 사이에 해당하는 사과가 선택될 확률

# 203.81g을 초과할 확률
pnorm(203.81, mean=300, sd=50, lower.tail=F)
# [1] 0.9728102

# 301.9g을 초과할 확률
pnorm(302.9, mean=300, sd=50, lower.tail = F)
# [1] 0.4768743

pnorm(203.81, mean=300, sd=50, lower.tail=F) - pnorm(302.9, mean=300, sd=50, lower.tail = F)
# [1] 0.4959359


####################################
# 중심극한정리
# 동일한 확률분포를 가진 독립 확률변수 n개의 평균의 분포는
# n이 적당히 크다면 정규분포에 가까워진다.

# ----------------------------------------------
# A반 수학 성적
A_class <- c(10,10,100,100)

# A반 수학 성적 평균
mean(A_class)
# [1] 55

# 히스토그램
hist(A_class, breaks = 10)

# A_class의 samples의 평균 구하기
asm <- sapply(1:20, function(i)mean(sample(A_class, 2, replace = F)))

# 20번 추출된 표본의 평균
asm

# 표본 평균들의 평균
mean(asm)

# 표본 평균 값들의 히스토그램
hist(asm)

# -------------------------------------------
# A반의 수학성적을 300개로 늘리고
# 표본 크기에 따른 표본의 평균값 분포를 확인

A_class2 <- c(rep(10,100), rep(50,100), rep(100,100))

# a반의 수학성적 평균
mean(A_class2) #[1] 53.33333

# 히스토그램
hist(A_class2)

# 2행 2열로 그래프 한번에 그리기
par(mfrow=c(2,2))

# 표본크기 2의 평균 데이터 생성 : 10000번
asm2 <- sapply(1:10000, function(i) mean(sample(A_class2, 2, replace = F)))

# 표본크기 30의 평균 데이터 생성 : 10000번
asm30 <- sapply(1:10000, function(i) mean(sample(A_class2, 30, replace = F)))

# 표본크기 50의 평균 데이터 생성 : 10000번
asm50 <- sapply(1:10000, function(i) mean(sample(A_class2, 50, replace = F)))

# 표본크기 80의 평균 데이터 생성 : 10000번
asm80 <- sapply(1:10000, function(i) mean(sample(A_class2, 80, replace = F)))


hist(asm2,main='표본크기2')
hist(asm30,main='표본크기30')
hist(asm50,main='표본크기50')
hist(asm80,main='표본크기80')

# 표본의 킈가 커짐에 다라 정규분포의 형태를 이루게 되고
# 표본 크기가 30개 이상인 경우 표본들의 평균분포가 
# 정규분포를 띈다고 가정한다

# 이항 분포의 정규 근사 정의
#####################

# 확률변수 X가 성공횟수를 나타내는 이산형 확률변수이고
# X ~ Bin(n,p)일 때, np나 n(1-p)가 모두 충분히 클 경우(보통 10 이상)에
# 확률변수 X는 근사적으로 다음의 정규분포를 따른다
# X ~ N(np(평균), np(1-p)(분산))


# 문제의 확률변수 x는 n=150, prob=0.6
np <- 150*0.6 # 90 (충분히 큼)
n1_p <- 150*0.4 # 60 (충분히 큼)

# 그러므로 문제 확률변수 x ~ n(90,36)인 정규분포에 근사한다

# 확률변수 x가 82이상 102 미만일 확률은?

# 연속성 수정 :
  # 이산형 확률분포는 계단형으로 나타나지만
  # 연속형 확률분포는 좌우대칭 종모양 곡선으로 나타나므로
  # 이항분포 [ a <= X <= b ] 확률을 정규분포에서 [a-0.5 <= X <= b+0.5]일
  # 확률로 근사시키는 것

# 그러므로 우리가 구할 확률은
# P(82 <= x < 102) == P(82 <= X <= 101)
# 연속성 수정
# 정규분포 상에서는 P(81.5 < X < 101.5) 의 확률을 계산한다
# 평균 90, 분산 36을 따르는 정규분포에 근사

# 이항분포로 계산
size=150; p=0.6
pbinom(101, size,p) - pbinom(81,size,p) # [1] 0.8945357

# 정규 근사 확률로 계싼
mu = size *p
sigm = sqrt(size*p*(1-p))
pnorm(101.5, mu, sigm) - pnorm(81.5, mu, sigm) # [1] 0.8940697

# 근사한 결과

##########################################
# 카이제곱 분포
##########################################

# chisq()

# 밀도 함수
# dchisq(df)

# 누적분포함수
# pchisq(df, lower.tail=TRUE,FALSE)

# 난수 발생
# rchisq(n, df)

ggplot(data.frame(x=c(0,10)), aes(x=x)) +
  stat_function(fun=dchisq, args=list(df=3), 
                colour="black", size=1.2) +
  geom_text(x=1.5, y=0.20, label="df=3") + 
  stat_function(fun=dchisq, args=list(df=5), 
                colour="blue", size=1.2) +
  geom_text(x=3.0, y=0.1, label="df=5") +
  stat_function(fun=dchisq, args=list(df=10), 
                colour="red", size=1.2) +
  geom_text(x=10.0, y=0.05, label="df=10") +
  ggtitle("카이제곱분포") +
  xlim(0,20)
  
# 누적 카이제곱 분포 확률 계산
pchisq(q=2.5, df=3, lower.tail = TRUE) # [1] 0.5247089

pchisq(q=2.5, df=5, lower.tail = TRUE) # [1] 0.2235049

pchisq(q=2.5, df=10, lower.tail = TRUE) # [1] 0.009124279

# 카이제곱 분포 난수 발생
rchi <- rchisq(n=100, df=50)
rchi

hist(rchi, breaks=20)

#########################################
# t 분포
#########################################
# 정규분포에서는 모분산(σ2)을 알고 있다고 가정하지만, 
# 실전의 현실세계에서는 모분산(σ2)을 모르는 경우가 
# 대부분이다보니 표본을 추출해서 표본분산(s2)을 계산하여 
# 사용하는 경우가 많다. 
# 이러다 보니 표준정규분포 통계량 Z 값을 사용할 수 없고 
# 표본확률분포를 사용해야 하는데 
# 그 중의 하나가 T통계량을 사용하는 t-분포임. 
# 알려지고 검증된 표본 확률 분포(소표본에서 사용)

ggplot(data.frame(x=c(-3,3)), aes(x=x)) +
  stat_function(fun=dnorm, colour="blue", size=1) +
  stat_function(fun=dt, args=list(df=3), colour="red", size=2) +
  stat_function(fun=dt, args=list(df=1), colour="yellow", size=3) +
  annotate("segment", x=1.5, xend=2, y=0.4, yend=0.4, colour="blue", size=1) +
  annotate("segment", x=1.5, xend=2, y=0.37, yend=0.37, colour="red", size=2) + 
  annotate("segment", x=1.5, xend=2, y=0.34, yend=0.34, colour="yellow", size=3) + 
  annotate("text", x=2.4, y=0.4, label="N(0,1)") +
  annotate("text", x=2.4, y=0.37, label="t(3)") + 
  annotate("text", x=2.4, y=0.34, label="t(1)") + 
  ggtitle("Normal Distribution, t-distribution")+
  geom_vline(xintercept = 1)

# t분포 관련 함수
# 밀도 함수
# dt(x, df)
ggplot(data.frame(x=c(-3,3)), aes(x=x)) +
  stat_function(fun = dt, args=list(df=1), colour="yellow", size=3)

dt(c(-3,3),1) # [1] 0.03183099 0.03183099
# 누적 분포 함수
# pt(q,df,lower.tail=T/F)
pt(q=1, df=1, lower.tail = T) # [1] 0.75

# 난수 발생
# rt(n, df)
set.seed(0)
rt <- rt(50, df=1)
hist(rt, breaks = 20)

###################################################################################
# F 분포
# F-분포는 F-검정 (F-test)과 두 집단 이상의 분산이 같은지 여부를 비교하는 분산분석(ANOVA, Analysis of Variance)에 사용되며, 
# (카이제곱 분포처럼) 분산을 제곱한 값만을 사용하므로 양(+)의 값만을 가지고 되고, 
# 왼쪽으로 치우치고 오른쪽으로 꼬리가 긴 비대칭형 형태를 갖는다.
# (카이제곱 분포와 모양이 유사함)
##################################################################################
# 밀도함수
# df(x, df1, df2)
# 
# 누적분포함수
# pf(x, df1, df2, lower.tail=TRUE/FALSE)
# 
# 분위수 함수
# qf(p, df1, df2, lower.tail=TRUE/FALSE)
# 
# 난수 발생
# rf(n, df1, df2)

x <- seq(0,5)
x
plot(x,df(x,50,100), type='l', col='red', lwd=5)
lines(x,df(x,10,30), type='l', col='pink', lwd=3)
lines(x,df(x,5,10), type='l', col='purple', lwd=3)

ggplot(data.frame(x=c(0,5)), aes(x=x)) + 
  stat_function(fun=pf, args=list(df1=5, df2=10), colour="blue", size=1) + 
  ggtitle("Cumulative F-distribution : F(df1=5, df2=10)")

pf(q=2, df1=5, df2=1, lower.tail=TRUE)
qf(p=0.835805, df1=5, df2=10, lower.tail = TRUE)

set.seed(42)
rf <- rf(100, df1=5, df2=100)

hist(rf)










