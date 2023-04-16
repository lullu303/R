# 쌍체 표본(대응 표본) t검정
# x의 변화에 따라 y의 값이 결정
# x에 변화를 가했을 때 그 x가 변화되어서 추출된 값을 검정(효과가 있는지)
# A반 학생들이 보충수업 후 본 국어 시험점수를 봤을 때 보충수업의 효과가 있는지

# 선행조건
# 실험 전과 후의 측정 값(x,y)는 정규분포를 따르지 않아도 됨
# 측정값의 차이는 정규성을 갖고 있어야 함

raw_d <- read.csv('data/htest02d.csv', header=T)
head(raw_d)
dim(raw_d)

before <- raw_d[,1]
after <- raw_d[,2]

mean(before) # 10500
mean(after) # 23800

# 두 집단간의 차이값에 대한 정규성 검정
d = before - after

# 정규성 검정 : 정규성을 가정할 수 있다.
shapiro.test(d) # p-value = 0.1621 : 귀무가설 채택

qqnorm(d)
qqline(d)

# 대응표본 t검정(t.test(,,,paired=T))
# alternative는 "two.sided", "greater", "less" 3개의 값이 있다.#
# default 값은 two.sided 이며, 이는 주어진 평균과 샘플이 단지 다르다는 것을 대립가설(H1)으로 두고자 할 때 사용되며#
# greater는 오로지 샘플이 주어진 평균보다 크다는 것을 대립가설(H1)을 두고자 할때,
# less는 작다는 것을 대립가설로 두고자 할 때 사용된다.

# 귀무가설 ; 두 집단의 평균차이는 없다
# 프로모션의 효과가 없다.
t.test(before,after,paried=TRUE, alternative = 'less')
# p-value = 0.006745 유의수준 0.05보다 작으므로 귀무가설을 기각한다
# 대립가설 채택 -> before의 평균이 after의 평균보다 작다
# 프로모션의 효과로 평균이 증가했다.


#############################
# 대응표본 T검정 Ex2
# 다이어트 약의 효과 검증

setwd('통계')
df <- read.csv("data/다이어트약_효과검증.csv")
head(df)


before <- df$다이어트전.kg.
after <- df$다이어트후.kg.

# 평균 계산
mean(before) ; mean(after)
# 줄어든 평균이 의미가 있는 것인지 확인(검정)

############
# 정규성 가정 - 두 변수의 차이값에 대해 정규성검정

diff <- before-after

shapiro.test(diff) # 정규성 가정

# 대응표본 T검정(paired=T)
t.test(before, after, paired = TRUE, alternative = 'greater')
# 귀무가서 : before와 after의 몸무게 평균은 같다
# 대립가설 : before의 몸무게 평균이 after의 몸무게 평균보다 크다
# alternative = 'twosides' : before와 after의 몸무게 평균은 다르다.
# alternative = 'less' : before의 평균이 after보다 작다

# p-value = 2.685e-13 : 귀무가설 기각, 대립가설 채택
# 다이어트약이 효과가 있다.
















