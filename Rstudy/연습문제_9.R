# 4.다음과 같이 cabbage_exp.txt 문서를 만드시오
# 5. 그래프 작성
cab <- read.table("data/cabbage_exp.txt", header = T, sep=",")
dim(cab)
str(cab)

ggplot(cab, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat = 'identity', position = 'dodge')

factor(cab$Date)



# factor 변경 후 level 바꿨는데 NA가 나오는 경우
# level을 명시할 때 실제 data와 다른 data를 명시한 것
# data 앞에 공백이 있어서 생기는 문제

# 범례순서와 x축 요소 항목 순서 변경
ggplot(data=cab, aes(x=factor(Date, level=c(' d21', ' d20', ' d16')),
                     y=weight, 
                     fill=factor(Cultivar,level=c('c52','c39')))) +
  geom_bar(stat='identity', position="dodge") +
  labs(x="Date",
       fill="Cultivar")
  
  
#######################################################################
# 6. 앞의 자료에 파레트를 추가하여 색상을 변경하시오 
library(ggplot2)

ggplot(data = cab, aes(x=factor(Date,level=c(' d21', ' d20', ' d16')),
                       y=weight,
                       fill=factor(Cultivar,level=c('c52','c39')))) +
  geom_bar(stat='identity', position="dodge",color="black") +
  labs(x="Date",
       fill="Cultivar")
# 막대그래프
ggplot(data = cab, aes(x=factor(Date,level=c(' d21', ' d20', ' d16')),
                       y=weight,
                       fill=factor(Cultivar,level=c('c52','c39')))) +
  geom_bar(stat='identity', position='dodge',color="black") +
  scale_fill_brewer(palette = "Accent") +
  labs(x="Date",
       fill="Cultivar")

# 7. 누적막대그래프
ggplot(data = cab, aes(x=factor(Date), y=Weight,
                       fill=factor(Cultivar, level=c('c52', 'c39')))) +
  geom_bar(stat='identity') +
    labs(x='Date', fill='Cultivar')
  

# 8. 그래프에 수치 표시
ggplot(data = cab, aes(x=factor(Date), y=Weight,
                       fill=factor(Cultivar, level=c('c52', 'c39')))) +
  geom_bar(stat='identity') + 
  geom_text(aes(label=Weight),
            position = position_stack(vjust=0.5)) +
  labs(x='Date', fill='Cultivar')



