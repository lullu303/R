# ggplot2 패키지 : 시각화 패키지
# 기본 그래프 기능보다 더 다양한 방식의 그래프 작도가 가능
# 산점도 : geom_point()
# 꺾은선 그래프 : geom_line()
# 막대그래프 : geom_bar()
# boxplot, 히스토그램
# + 연산자를 활용해 겹쳐그릴 수 있다.
# 다른 객체 추가 가능(직선, 텍스트, 도형)

# 패키지 설치 및 로드
# install.packages("ggplot2")
library(ggplot2)

# 1단계 : 그래프 기본 틀 생성
# ggplot(데이터세트, aes(속성)) 함수 사용 - 그래프이 좌표 생성 위해 틀을 만드는 함수
# aes() : x축 / y축에 맵핑되는 데이터(속성) 설정


# mpg 사용
head(mpg)
ggplot(data=mpg, maping=aes(x=displ, y=hwy))
ggplot(mpg,aes(displ, hwy))


# 2. 그래프 추가 ( + 연산자 사용)
ggplot(mpg, aes(displ,hwy)) + geom_point()


# 3. 그래프 관련 설정 변경 ( + 연산자 사용)
ggplot(mpg, aes(displ, hwy)) + geom_point() +xlim(3,6)
ggplot(mpg, aes(displ, hwy)) + geom_point() +xlim(3,6)+ylim(10,30)

# 여러라인으로 표현 : + 뒤에서 줄 바꾸기, + 연산자가 행 앞으로 오면 에러
ggplot(mpg, aes(displ, hwy)) +
  geom_point() + 
  xlim(3,6) +
  ylim(10,30)

# mpg 데이터의 각 자동차들에 대해 고속도로 연비와 도시연비의 관계를
# 시각화로 확인하시오
ggplot(data=mpg, aes(x=cty, y=hwy)) +
  geom_point()

# 막대그래프 1 - 집단간 차이 표현
# 데이터의 크기를 막대의 길이로 표현

# 1. 집단별 평균표 만들기
# mpg 데이터의 각 자동차 구동방식별 고속도로 연비 차이를 확인하시오
library(dplyr)
df_mpg <- mpg %>% group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg
# 2. 그래프 생성하기
ggplot(data=df_mpg, aes(x=drv, y=mean_hwy)) +
  geom_col()

# 막대를 크기 순으로 정렬하기
# 배경도에서 정렬 완료
ggplot(data=df_mpg, aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) +
  geom_col()

ggplot(data=df_mpg, aes(x=reorder(drv, mean_hwy), y=mean_hwy)) +
  geom_col()

# 막대그래프2 - 빈도 막대 그래프
# 값의 개수(빈도)로 막대의 길이를 표현
# 범주형 변수인 경우 값의 빈도를 세서 그래프를 표현

# geom_bar() : 빈도는 자동계산함
ggplot(data=mpg, aes(x=drv)) + geom_bar()

# drv 속성
class(mpg$drv) # 범주형 변수
table(mpg$drv)

# ggplot(data=mpg. aes(x=drv)) + geom_col() -> x,y축 값이 모두 필요
# geom_col() requires the following missing
# aesthetics : y

# 연속형 변수로 geom_bar()를 사용하면 
# x축 : 연속변수, y축 : 빈도
# 고속도로 연비 :hwy
ggplot(data=mpg, aes(x=hwy)) + geom_bar()
# hwy 데이터의 빈도를 세서 막대 그래프 생성
table(mpg$hwy)

# 연속형 데이터 각각의 빈도는 별다른 의미가 없다
# 구간의 빈도를 주로 사용- 히스토그램

######################################
# geom_bar() 그래프의 stat 옵션
# stat : statistic 의 약자
# y축값 사용 방법을 설정하는 파라미터
# stat = 'count' : 디폴트 설정
# 빈도수 계산
# x축 값만 지정


# stat = 'identity' 
# y축값을 데이터 기반으로 정해줄 때
# y축값을 명시 : geom_col()과 같은 의미를 갖는다


# diamonds 데이터 세트
View(diamonds)

# 3가지 같은 결과 코드
ggplot(data=diamonds, aes(cut)) + geom_bar()
ggplot(data=diamonds, aes(x=cut)) + geom_bar()
ggplot(data=diamonds, aes(cut)) + geom_bar(stat='count')


# sleep 데이터세트
View(sleep)
ggplot(data=sleep, aes(x=ID, y=extra)) + 
  geom_bar(stat='identity')


# geom_bar(stat=, position='dodge'/'fill')
# dodge : 묶음막대, fill : 비율로 표시
# position을 사용하기 위해서는 aes(fill=group) : 각 막대의 색상 표현
View(sleep)
ggplot(data=sleep, aes(x=ID, y=extra, fill=group)) + 
  geom_bar(stat='identity', position='dodge')

ggplot(data=sleep, aes(x=ID, y=extra, fill=group)) + 
  geom_bar(stat='identity', position='fill')

ggplot(data=diamonds, aes(x=color, fill=cut)) + 
  geom_bar(stat='count', position='fill')



