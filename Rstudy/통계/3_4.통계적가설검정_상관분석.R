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









