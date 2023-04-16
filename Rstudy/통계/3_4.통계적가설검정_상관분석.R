getwd()

# 상관분석
# 두 연속형 변수간에 선형관계를 파악
# 귀무가설 ; 상관관계가 없다
# 산점도로 시각화 
library(readxl)
da <- read_xlsx('data/일별_금은달러.xlsx')
head(df)
names(df) <- c('일자', '금값', '은값', '달러환율')
head(df,1)

library(dplyr)
df <- arrange(df, by=일자)
head(df)
tail(df)

# 산점도 그리기
library(ggplot2)
library(reshape2)

df_long <- melt(df, id.vars = '일자')
head(df_long, 1)

ggplot(df_long, aes(일자, value, color=variable)) +
  geom_point() +
  theme(axis.test.x=element_text(angle=90, hjust=1))

# 각 항목별 산점도
ggplot(df_long, aes(금값, 은값)) +
  geom_point(color='blue') +
  theme(axis.test.x=element_text(angle=90, hjust=1))

ggplot(df_long, aes(금값, 달러환율)) +
  geom_point(color='blue') +
  theme(axis.test.x=element_text(angle=90, hjust=1))

ggplot(df_long, aes(달러환율, 은값)) +
  geom_point(color='blue') +
  theme(axis.test.x=element_text(angle=90, hjust=1))

pairs(~금값+은값+달러환율, data=df,
      lower.panel=panel.smooth, pch=20,
      main='금값 vs 은값 vs 달러환율')

# 피어슨 상관 계수
# 두 변수 모두 연속형 변수 일때 사용하는 상관계수로 x와 y에 대한 상관 계수는 다음과 같이 정의 됨 
# 상관계수가 1에 가까울 수록 양의 상관관계가 강하다고 함 
# 상관계수가 -1에 가까울수록 음의 상관관계가 강하다고 함 
# 상관계수가 0에 가까울수록 상관관계가 약하다고 함
# 또한, p-value가 0.05 미만이면 유의한 상관성이 있다고 봄

# 스피어만 상관계수
# 분석하고자 하는 두 연속형 분포가 심각하게 정규분포를 벗어난다거나 순위척도 자료일 때 사용
# 연속형 자료일 때는 각 측정값을 순위 척도 자료로 변환시켜 계산
# 두 변수 순위 사이의 단조 관련성(한 변수가 증가할 때 다른 변수가 증가하는지 감소하는지에 대한 관계)만을 측정하는 상관계수
# 선형적인 상관 관계를 나타내지 않는다

View(df)

cor(df[,c(2:4)], use="all.obs", method="pearson")

cor.test(df$금값, df$은값, method = 'pearson')

res <- cor.test(df$금값, df$은값, method = 'pearson')
res[3]$p.value
res[4]$estimate # 상관계수

#####################################
# 스피어만 상관계수
# 실제값을 순위척도로 변환 후 계산 진행
cor(df[,c(2:4)], use="all.obs", method="spearman")














