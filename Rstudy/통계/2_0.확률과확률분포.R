#################################
# 표본의 추출
################################

# 무작위 추출(임의 추출) : 임의로 표본을 추출하는 방법

# 0과 1사이의 균일한 분포내에서 난수를 생성
# runif(h) : r unif
runif(1)
runif(10)

# R은 다른 분포에서도 무작위 변량을 생성할 수 있음
# 주어진 분포에 대해 난수 생성기의 이름을 분포의 약어 앞에 "r"이 붙는다

# 정규분포를 따르는 데이터의 난수 생성
# rnorm(n)
rnorm(1)
rnorm(10)

##############################
# 다른 여러 분포에서의 난수 발생
###############################

runif(1, min=-3, max=3)
rnorm(1)
rnorm(1, mean=100, sd=15)
rbinom(1, size=10, prob=0.5)
rpois(1, lambda = 10)



rnorm(3, mean =c(-10,0,+10), sd=1)
# 첫번째 난수 : 평균 -10이고 표준편차가 1인 정규분포에서 추출
# 두번째 난수 : 평균 0이고 표준편차가 1인 정규분포에서 추출
# 세번째 난수 : 평균 10이고 표준편차가 1인 정규분포에서 추출

norm_test = rnorm(12, mean =c(-10,0,+10), sd=1)
m_test = norm_test[c(1,4,7,10)]
z_test = norm_test[c(2,5,8,11)]
p_test = norm_test[c(3,6,9,12)]

mean(m_test)
mean(z_test)
mean(p_test)

########################
# 동일한 난수 발생 -> seed 고정
########################

# 실행시마다 동일한 시퀀스를 재생하려고 하면
# set.seed(n) 호출하여 난수 생성기 초기화
# 실행시마다 설정

set.seed(42)
runif(10)

runif(10) #또 seed를 전달하지 않음. 할때마다 전달해줘야 함.

###########################################
# sample(set, n, replace=F/T/생략)
# sample(x, size, replace = FALSE, prob = NULL)
# prob = NULL : 무작위 추출
# prob = 확률값 : 확률값에 기인해서 추출 진행
# install.packages("tidyverse")
library(tidyverse)

word_series <- read.csv('data/world_series.csv')
View(word_series)

# 시리즈가 플레이된 연도에서 무작위로 표본추출
sample(word_series$year,10) # 비복원 추출
sample(word_series$year,20, replace = T)
sample(word_series$year,20, replace = F)

??sample

###############################
# 확률분포
###############################

# 불공정한 주사위의 확률 분포 확인
# 확률변수에 필요한 사건
dice = c(1,2,3,4,5,6)

# 그 값이 나올 수 있는 확률 : prob
# 불공정한 주사위의 각 눈에 대한 확률은 아래값으로 가정한다.
prob = c(1/21, 2/21, 3/21, 4/21, 5/21, 6/21)


# 주사위 확률 변수에 대해 복원 추출로 불공정한 주사위 확률을 
# 사용해서 sample 100개 추출
# 추출된 sample은 불공정한 주사위의 확률을 따르는가?

set.seed(42)
smple <- sample(dice,size=100,replace= T,prob=prob)
smple

test <- table(smple)
test

res = data.frame(test)
res = data.frame(res, 'rel_frep'=res$Freq/100)
res

# smple Freq rel_frep
# 1     1    2     0.02
# 2     2    9     0.09
# 3     3   23     0.23
# 4     4   18     0.18
# 5     5   22     0.22
# 6     6   26     0.26

# 동일한 확률분포를 따르는 표본추출을 10000번 추출
set.seed(42)
smple <- sample(dice,size=10000,replace= T,prob=prob)
smple

test <- table(smple)
test

res_10000 = data.frame(test)
res_10000 = data.frame(res, 'rel_frep'=res_10000$Freq/10000)
res_10000

# #   smple Freq rel_frep
# 1     1  467   0.0467
# 2     2  949   0.0949
# 3     3 1457   0.1457
# 4     4 1909   0.1909
# 5     5 2325   0.2325
# 6     6 2893   0.2893

# 표본추출의 개수가 많아지면 실제 확률 분포에 가까워진다.


#########################################################################
# 추측통계의 확률
################

# 전교생 점수에서 68점의 확률 확인

score <- read_csv('data/scores400.csv')
View(score)

# 68점의 분포 확인
count <- 0
for (jumsu in score$score) {
  if(jumsu[1]==68) {
    count <- count+1
  }
}

length(score$score)
count
count/length(score$score)
# score에서 68점 4%

##################
# score에서 68점의 추출 확률
#################
# 1000번 추출
set.seed(42)
smpl = sample(score$score, 1000, replace=T)

# 68점의 분포 확인
count <- 0
for(jumsu in smpl) {
  if(jumsu == 68) {
    count <- count +1
  }
}

count
count/1000

###########################################
# 이산형 확률 변수/확률 분포
###########################################
# 불공정한 주사위의 확률변수, 확률 분포, 확률 함수

# 확률 변수
x_set <- c(1,2,3,4,5,6)

# 확률분포를 표현하는 확률함수 구현 -f(3)
f <- function(x) {
  if (x %in% x_set) {
    res <- x/21
    return(res)
  } else {
    return(0)
  }
}

# 확률분포
# 확률변수가 취할 수 있는 값의 집합데이터, 확률함수
# 확률분포 dX = [x_set, f] 

# 위 확률 변수에 대하여 확률값을 확률함수 f로 계산
p_k <- c()

for(x in x_set) {
  p_k <- c(p_k, f(x))
}

p_k
# [1] 0.04761905 0.09523810 0.14285714 0.19047619 0.23809524 0.28571429

# 불공정한 주사위의 
dx <- data.frame('p_x'=x_set, 'p_k'=p_k)
dx
f(15) # [1] 0
f(5) # [1] 0.2380952

###########################
# 이산형 확률분포의 성질
# 1. 모든 확률은 0보다 크고
# 2. 확률의 합은 1이다.

# 불공정한 주사위에 대한 확률분포는 이산형 확률분포의 성질을 만족하는가?
sel <- TRUE

# 모든 확률은 0보다 크고 
# 불공정한 주사위의 확률분포
ls(dx) # p_k가 확률변수에 대응하는 확률 
for(prob in dx$p_k) {
  if(prob >= 0) {
    sel <- TRUE
  } else {
    sel <- FALSE
    break
  }
}
if (sell == TRUE) {
  print("이산형 확률분포 성질 1 만족")
} else {
  print("이산형 확률분포 성질 1 불만족")
}

# 확률의 합은 1에 최대한 근사한다
sum(dx$p_k) # [1] 1

# 두 성질 모두 만족하므로 불공정 주사위의 확률분포 dx는 이산형 확률분포임 

###############
# 누적분포함수 F(x)
# 확률변수가 특정 값보다 작거나 같은 확률을 나타내는 함수

# 불공정한 주사위의 누적분포함수 cdf_F(x) 정의

# 확률변수 정의
x_set <- c(1,2,3,4,5,6)

# 누적분포함수 정의
cdf_F <- function(x) {
  p_k_temp <- c()
  for(k in x_set) {
    if(k <= x) {
      p_k_temp <- c(p_k_temp, f(k))
      print(p_k_temp)
    }
  }
  return(sum(p_k_temp))
}

cdf_F(6)
# [1] 0.04761905
# [1] 0.04761905 0.09523810
# [1] 0.04761905 0.09523810 0.14285714
# [1] 0.04761905 0.09523810 0.14285714 0.19047619
# [1] 0.04761905 0.09523810 0.14285714 0.19047619 0.23809524
# [1] 0.04761905 0.09523810 0.14285714 0.19047619 0.23809524 0.28571429
# [1] 1


####################################
# 확률변수의 지표 : 평균 - 기대값

# 확률분포의 평균
# 이산확률분포의 기대값 : 확률변수 각 값에 대해서 확률을 가중값으로 사용한
# 가중평균
# 식 : E(X)=∑(Xi*P(Xi))

# 확률변수
x_set <- c(1,2,3,4,5,6)

# 불공정한 주사위 확률(가정한 확률)을 구현한 확률함수 f
# P(Xi)
f <- function(x){
  if(x %in% x_set) {
    res <- x/21
    return(res)
  }else {
    return(0)
  }
}

# 기대값 계산
p_k_com <- c()

for(x in x_set) {
  p_k_com <- c(p_k_com, x*f(x))
}
p_k_com

# 기대값 
sum(p_k_com) # [1] 4.333333

#####################################
# 0,  1,  2
# 0.2 0.5 0.3
0*0.2 + 1 * 0.5 +2 * 0.3
# 1주에 평균 1.1 경기를 기대할 수 있다.

################
# 불공정한 주사위를 백만번 굴려 얻은 표본 평균 
# 1000000
dx$p_k
smp1 <- sample(x_set, 1e+06, replace=T, prob=dx$p_k)
mean(smpl) # [1] 4.332164

# 확률변수의 분산
# Var(X)
# 확률변수로부터 기대값의 차이의 제곱에 대한 기대값 계산

#############################
# 불공정한 주사위
# 확률변수
x_set
# 확률함수
f
# 기대값
ex <- sum(p_k_com)
ex

# 분산 계산
p_var <- c()

for(x in x_set) {
  p_var <- c(p_var, (x-ex)**2*f(x))
}
p_var

# 분산
sum(p_var) # [1] 2.222222




##########################
# 샘플을 통해서 얻은 값들의 평균(표본평균)은 확률변수다
# 표본의 추출은 확률에 의거한다. 그러므로 표본은 확률변수에 해당됨
# 표본들의 평균, 표본들로 계산되어 나오는 평균도 확률변수

# 표본평균
# 모집단에서 무작위 추출로 표본크기가 20인 표본을 추출하여 표본평균을 계산
# 10000번 실행

# 사용데이터
score

# 20개의 추출된 표본의 평균을 계산해서 저장할 벡터
sample_means = c()

for (i in 1:10000) {
  sample_m <- mean(sample(score$score, 20, replace=T))
  sample_means <- c(sample_means, sample_m)
}

sample_means

head(sample_means)
# [1] 71.30 71.45 67.80 68.90 69.95 70.75

smpl_means_df <- data.frame('sample_mean'=sample_means)
head(smpl_means_df)

library(ggplot2)

ggplot(smpl_means_df, aes(x=sample_mean)) +
  geom_histogram() +
  geom_vline(xintercept = mean(score$score), 
             linetype='dotted', color='red', linewidth=3) +
  geom_vline(xintercept = mean(smpl_means_df$sample_mean), 
            color='blue', linewidth=1)

# 표본평균의 히스토그램은 모집단의 산포도이고 모평균을 중심으로 분류가 됨
# 무작위 추출에 의한 표본평균으로 모평균을 추측할 수 있음







