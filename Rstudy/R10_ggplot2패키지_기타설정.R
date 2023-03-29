###############################
# 그래프에 기타 객체 추가하기
###############################
library(ggplot2)

### 막대 그래프에 수치 레이블 표시
# 빈도계산된 y값이 저장되는 변수 ..count..
# 빈도막대그래프에 텍스틀르 출력하고자 하면 
# - geom_text(stat='count') 설정해야 함

ggplot(mtcars, aes(x=factor(cyl))) +
  geom_bar(width = 0.8, fill='red') +
  geom_text(stat="count", # 출력 y 좌표
            aes(label=..count..),
            vjust=-0.5)

# 묶음막대그래프에 텍스트(레이블) 표시
# geom_text(position=position_dodge(width =실제 막대그래프 값))
ggplot(mtcars, aes(x=factor(cyl), fill=as.factor(am))) +
  geom_bar(position="dodge", width=1) +
  geom_text(stat="count", # 출력 y 좌표
            aes(label=..count..),
            position = position_dodge(width=1.8),
            vjust=-0.5 )


# 누적막대 그래프에 레이블 표시
# position="stack"

ggplot(mtcars, aes(x=factor(cyl), y =..count.., fill=as.factor(am))) +
  geom_bar(position="stack", width=0.8) +
  geom_text(stat="count", # 출력 y 좌표
            aes(label=..count..),
            position = position_stack(vjust=0.5))

# stat='identity'인 경우
# fill 파라미터로 그룹핑하면 결국 누적막대그래프
# position = position_stack(vjust=0.5) 이용.
sleep
aes(ID, extra, fill=group)

ggplot(sleep, aes(x=ID, y =extra, fill=group)) +
  geom_bar(stat='identity', position="stack") +
  geom_text(stat='identity',
            aes(label=extra),
            position = position_stack((vjust=0.5)))
  
##########################################################
score <- read.csv('data/학생별과목별성적_국영수_new.csv')
head(score)

ggplot(score,aes(이름,점수, fill=과목)) +
  geom_bar(stat='identity') + # stat="count"가 디폴트이므로 변경해서 사용 
  geom_text(aes(label=점수), # stat='identity'가 디폴트
            position=position_stack(vjust=0.5))


















