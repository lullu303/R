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

#########################################################
g <- ggplot(mtcars, aes(hp,mpg))
g + geom_point(shape=15, size=3, color="blue")

# g + geom_point(shape=factor(gear),
#                color=factor(gear)
# Error in factor(gear) : object 'gear' not found
# gear 컬럼이 그래프 배경에 매핑되지 않음

# geom_point(aes()) 으로 필요 컬럼 매핑
g + geom_point(aes(shape=factor(gear),
               color=factor(gear)))

# 그래프는 변수값에 의해 서로 다른 모양과 색상으로
# 그려짐 ; 변수명을 인식했음
# 보여주는 결과만 다르게 나옴
# 변수의 값에 따라 내부 그룹이 생성된 건 아님
# 범례 생성이 안됨
g + geom_point(shape=factor(mtcars$gear),
               color=factor(mtcars$gear))


team <- c('ko','ko','ko','ch','ch','ch')
grade <- c(1,2,3,1,2,3)
points <- c(30,51,60,20,47,62)
df_team <- data.frame(team,grade,points)
View(df_team) 

g <- ggplot(df_team, aes(grade, points))

g + geom_line(aes(color=team, linetype=team)) +
  geom_point(aes(shape=team))



# 모든 그래프에 동일한 모양, 동일한 색상을 적용
# 꾸미기 파라미터 적용 없이 그룹만 분류
g + geom_line(aes(group=team), color='red') +
  geom_point(aes(fill=team))












