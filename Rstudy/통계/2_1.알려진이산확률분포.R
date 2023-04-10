###############################
# 이항분포 : Binomial Distribution
###############################
# 베르누이 시행을 n번 반곡할때 성공의 수를 확률변수들로 이루어진 분포
# 𝑋= 성공의 확률이 𝑝인 베르누이 시행을 𝑛번 반복할 때 성공의 수 : 이항 확률변수
##############################

######################################################################################
# 이항분포 함수 생성을 위한 수식 작성
######################################################################################
# 베르누이 시행을 n번 던져서 성공할 확률
# P(X=x0) = nCxp**x*(1-p)**n-x, x=0,1,2,3,...,n : 0<= p <=1
######################################################################################
#nCx : n개중 x개를 고르는 방법의 수
#일반식 : n(n-1)...(n-x+1) / x(x-1)...1 == n! / x!(n-x)!

# 5C2 : [1] 10
(5*4*3*2*1) / ((2*1)*(3*2*1)) 

# 함수 구성
comb <- function(n, x) {
  return(factorial(n)/(factorial(x)*factorial(n-x)))
}

comb(5,2)

############################################################
# 이항분포 확률함수

bio <- function(n,p,x) {
  x_set <- c(0:n)
  if(x %in% x_set) {
    return(comb(n,x)* p**x * (1-p)**(n-x))
  }else{
    return(0)
  }
}


# 5그루의 꽃나무 중에서 빨간 꽃나무가 하나도 없을 확률?
# n=5, x=0
bio(5,0.25,0) # [1] 0.75

# 빨간 꽃나무가 4그루 이상일 확률? n=5, x=4.5
bio(5,0.25,4) + bio(5,0.25,5) # [1] 0.015625

####################
# 이항분포 확률 예제

# 대도시의 시민 중 30% 만이 대중교통에 만족한다고 한다.
# 이 도시의 시민 20명을 임의로 선택했을 때 이들 중 3명 미만의 시민이 만족할 확률
# 6명의 시민이 만족할 확률을 구하라

# 확률변수 X ~ Bin(20, 0.3)
x_set <- c(0:20)
# [1]  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

# 3명 미만의 시민이 대중교통에 만족할 확률
# p(x<3) =  p(x=0) + p(x=1) + p(x=2)
# 20C0 * 0.3**0 * 0.7**(20-0) + 20C1 * 0.3**1 * 0.7**20-1 +  20C2 * 0.3**2 * 0.7**20-2
bio(20,0.3,0) + bio(20,0.3,1) + bio(20,0.3,2) # [1] 0.03548313

#6명의 시민이 대중 교통에 만족할 확률
# p(x=6) = 20C6 X 0.3**6 *0.7**(20-6)
bio(20,0.3,6) # 0.191639


# 성공확률 p이고 n번 수행하는 이항분포를 따르는 확률변수의 기대값
# np
# 분산 : npq -> q=1-p -> np(1-p) # 표준편차 : sqrt(npq)

# 감염자와 접촉을 하면 감염되는 바이러스 질환에 대해
# 건강한 사람이 감염자와 한번 접촉했을 때 감염될 확률이 20%라고 한다.
# 감염자가 임의의 건강한 사람 5명과 접촉했을 때 5명 모두 감염될 확률?
# 감염자 수의 기대값과 분산, 표준편차?

# 확률변수 x
x_set <- c(0:5)
# x ~ Bin(5,0.2)

# 5명 모두 감염되었을 확률
# P(x=5) = 5C5 X 0.2**5 X 0.8**(5=5)
bio(5,0.2,5) # [1] 0.00032

# 기대값 / 분산 / 표준편차
# p = 0.2, n = 5

# 기대값 : 1
5*0.2
# 분산 (np(1-p)) : 0.8
5*0.2*(1-0.2)
# 표준편차 : 약 0.8944
sqrt(5*0.2*(1-0.2))


###########################################################
# 이항분포와 관련된 r함수 정리
########################################

# 이항분포의 난수 생성
# 확률변수 x = c(0,1,2,3,4,5)의 난수 생성
# 성공확률이 0.5
# 수행횟수 : 5
# 난수는 0부터 5사이의 값이 발생된다
rbinom(n=1, size=5, prob=0.5) # :  2
rbinom(n=2, size=5, prob=0.5)
rbinom(n=10, size=5, prob=0.5)

rbinom(n=1, size =10 , prob = 0.5)
# x_set <- c(0:10)

# 성공확률 0.4인 베르누이 시행을 5번 수행하는 확률변수 x에 대해 1개의 샘플 추출
set.seed(42)
rbinom(n=1, size=5, prob=0.4) 

set.seed(42)
rbinom(n=5, size=10, prob=0.4)
# 성공확률 0.4인 베르누이 시행을 10번 수행하는 확률변수 x에 대해 5개의 샘플 추출

set.seed(42)
mean(rbinom(n=5, size=10, prob=0.4)) # 5

set.seed(42)
mean(rbinom(n=200, size=10, prob=0.4)) # 4.025
# 난수 추출이 많아지면 평균 성공 횟수는 확률에 수렴한다.

# ex. 하루에 150개의 위젯을 생산하고 결함이 있는 위젯은 다시 작업해야 한다
# 위젯은 5%의 결함을 갖게 된다. 이번주에 매일 다시 작업해야 하는 위젯의 수를 추정

rbinom(7,150,0.05)
# [1]  7 13  7  6  6  8  8

set.seed(42)
mean(rbinom(7,150,0.05)) # 9

set.seed(42)
mean(rbinom(200,150,0.05)) # 7.59

#########################
# 베르누이 난수 (size=1)

# 아래 코드에서 유추할 수 있는 확률변수 x값의 범위는? 0,1
rbinom(n=1, size=1, prob=0.4)
rbinom(n=5, size=1, prob=0.4)
rbinom(n=10, size=1, prob=0.4)
rbinom(n=100, size=1, prob=0.4)

hist(rbinom(n=100, size=1, prob=0.4))
hist(rbinom(n=1000, size=1, prob=0.4))

# 이항분포의 시각화
binom <- data.frame(success=rbinom(n=10000, size=5, prob=0.3), size=5)
binom

library(ggplot2)
ggplot(binom, aes(x=success)) + geom_histogram(bankwidth=1)

######################
# size (시행횟수)를 다르게 해서 비교
######################
binom <- data.frame(success=rbinom(n=10000, size=5, prob=0.7), size=5)
binom_10 <- data.frame(success=rbinom(n=100000, size=10, prob=0.3), size=5)
binom_100 <- data.frame(success=rbinom(n=100000, size=100, prob=0.3), size=5)
binom_1000 <- data.frame(success=rbinom(n=10000, size=1000, prob=0.3), size=5)

par(mfrow=c(2,2))
hist(binom$success)
hist(binom_10$success)
hist(binom_100$success)
hist(binom_1000$success)
# 시행회수 size가 크면 성공 확률 크기에 상관없이
# 이항분포는 좌우대칭을 이룬다

###########################################
# 성공확률에 따른 시각화 비교

binom <- data.frame(success=rbinom(n=10000, size=5, prob=0.7), size=5)
binom_10 <- data.frame(success=rbinom(n=100000, size=10, prob=0.5), size=5)
binom_100 <- data.frame(success=rbinom(n=100000, size=100, prob=0.5), size=5)
binom_1000 <- data.frame(success=rbinom(n=10000, size=1000, prob=0.5), size=5)

par(mfrow=c(2,2))
hist(binom$success)
hist(binom_10$success)
hist(binom_100$success)
hist(binom_1000$success)


#
binom <- data.frame(success=rbinom(n=10000, size=5, prob=0.2), size=5)
binom_10 <- data.frame(success=rbinom(n=100000, size=10, prob=0.2), size=5)

par(mfrow=c(2,2))
hist(binom$success)
hist(binom_10$success)

#
binom <- data.frame(success=rbinom(n=10000, size=5, prob=0.8), size=5)
binom_10 <- data.frame(success=rbinom(n=100000, size=10, prob=0.8), size=5)

par(mfrow=c(2,2))
hist(binom$success)
hist(binom_10$success)

# 성공확률이 0.5에 가까우면 시행회수 n의 크기에 관계 없이 좌우대칭 종모양을 함
# 시행회수 n이 크면 성공확률의 크기에 관계없이 이항분포는 좌우대칭을 이룸
# 성공확률이 0.5보다 작으면 오른쪽 꼬리분포
# 성공확률이 0.5보다 크면 왼쪽꼬리분포

#########################################
# 포아송분포함수 생성
#########################################
# 포아송분포 함수 생성을 위한 수식 작성
##########################################
# # P(X=x0) = lambda**x * e**-lambda / x! x=0,1,2,3,...,n : lambda : 평균발생횟수
##########################################
# e**-lambda: e는 자연상수
# exp(-lambda) 로 계산

# 확륧마수
poi <- function(lambda, x) {
  return((lambda**x * exp(-lambda))/factorial(x))
}

#####################
# 확률계산 예제
#####################

# 50분동안 평균 3회 휴대전화가 울릴 때 : lambda 3
# 휴대전화가 50분동안 1번 이상 울릴 확률은? x : 1이상 ~ 무한대
# 1 이상의 모든 경우의 확률 께산은 불가능함
# 모든 확률의 합은 1이므로 1에서 한번도 울리지 않을 확률을 빼서 계산
1-poi(3,0) # x가 0인 이유 한번도 울리지 않을 확률을 계산하기 위함

# 기대값과 분산
# 기대값 : E(x) = lambda
# 분산 : V(x) = lambda

#######################
# 관련된 R 함수

# 확률변수 내 특정 값이  발생하는 확률 반환 함수
# dpois(x, lambda)

# 평균발생회수가 0.3인 포아송 분포를 따르는 확률변수 내 
# 특정값 1이 발생할 확률
dpois(1, 0.3) # 0.2222455

# 주어진 숫자 범위까지의 누적 확률 반환
# 평균 발생횟수가 0.3인 포아송 분포를 따르는 확률변수에 대해
# 3까지의 누적 확률
ppois(3, lambda=0.3) #0.9997342

# 평균 발생횟수가 20인 포아송 분포를 따르는 확률변수에 대해
# 3까지의 누적 확률
ppois(3,lambda=20)
# 3.20372e-06
# 0.000006

# 누적확률값이 주어진 경우 해당하는 확률 변수(분위수) 게산
# qpois(p, lambda)
# quantile(분위수)
qpois(ppois(3,lambda=0.3),0.3) # 3

# 난수 생성
# rpois(n, lambda)

# 서로 다른 기댓값을 갖는 포아송 분포 생성

pois1 <- rpois(n=1000, lambda = 1)
pois3 <- rpois(n=1000, lambda = 3)
pois5 <- rpois(n=1000, lambda = 5)

pois10 <- rpois(n=1000, lambda = 10)
pois20 <- rpois(n=1000, lambda = 20)
pois30 <- rpois(n=1000, lambda = 30)
pois40 <- rpois(n=1000, lambda = 40)
pois50 <- rpois(n=1000, lambda = 50)

par(mfrow=c(1,1))
hist(pois1)
hist(pois3)
hist(pois5)

hist(pois10)
hist(pois20)
hist(pois30)
hist(pois40)
hist(pois50)



#### lambda값에 따라 정규분포 근사
















