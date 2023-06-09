# 그래프 출력
# R 스튜디오 PLOTS 창
# 새로운 plots 창 생성
plot.new()

# 단독 plot창(시스템에 종속)
dev.new()

# 옵션없이 x,y축만 있는 그래프
# plot(y축 데이터) : 산점도(기본그래프 종류)
plot(1:15)

#plot(x축 데이터, y축 데이터) : x,y축 데이터의 개수는 동일해야 함
plot(1:5, c(5,3,2,6,10))

#plot() 함수의 주요 옵션(매개변수)
# xlab : x축 이름
# ylab : y축 이름
# xlim : x축 값의 범위
# ylim : y축 값의 범위
# main : 그래프 제목
# pch : 점의 종류
# cex : 점의 크기
# col : 색상
# type : 그래프의 유형


x <- c(1,2,3); y<-c(4,5,6)
#기본 옵션
plot(x,y,
     xlab="x축 이름",
     ylab="y축 이름",
     main = "그래프 제목")

# 점의 크기/색상
plot(x,y,cex=3, col='red')

# 축 생략
v1 <- c(100,130,120,160,150)

# x,y축 생략, y축 범위(0~200) , c(시작값, 끝값)
plot(v1,
     type='o',
     col='red',
     ylim=c(0,200),
     axes = FALSE, # x,y 축 표시 여부
     ann=FALSE) # 축 제목 표시 여부

# 축 추가 : axis(축종류, 축범위, 축값) 함수 사용
# x축 추가 : 1
axis(1, at=c(1:5),
     lab=c('MON','TUE','WED','THU','FRI'))

#y축 추가 :2
axis(2, ylim=c(0,200))

#그래프제목(title(main=그래프제목,
#           col.main=제목색상, font.main=제목폰트크기)사용)

title(main="FRUIT",
      col.main="red",
      font.main=4)

#축제목 (title(xlab=x축제목,
#           col.lab=제목색상)사용)
title(xlab="DAY", col.lab="black")
title(ylab="PRICE", col.lab="blue")

# title 함수 옵션
x <- c(1,2,3); y <-c(4,5,6)

plot(x,y,ann=FALSE)

title(main="그래프제목",
      xlab="x축제목",
      ylab="y축제목",
      cex.main=3, # 그래프제목 크기
      cex.lab=1.5,  #x,y축 제목 크기
      col.main="red", # 제목 색상
      col.lab="blue" # 축제목 색상
      )

############################################################
# plot 화면분할
# par(mfrow=c(행,열))
plot.new()

# 1행 3열로 화면 분할
v1
par(mfrow=c(1,3))
plot(v1,type='o') # 표식이 있는 꺾은선
plot(v1,type='s') # 계단모양
plot(v1,type='l') # 꺾은선


# 2행 3열로 화면 분할
par(mfrow=c(2,3))
plot(v1,type='o') # 표식이 있는 꺾은선
plot(v1,type='s') # 계단모양
plot(v1,type='l') # 꺾은선
pie(v1)
plot(v1,type="o")
barplot(v1)

# 하나의 화면으로 복귀
par(mfrow=c(1,1))
plot(v1, type='o')

############################################################
# 축제목/지표값/지표선 위치 설정
# par(mgp=c(축제목위치, 지표값위치, 지표선위치))

a
par(mgp=c(1,1,1))
plot(a,xlab="aaa")

par(mgp=c(2,1,0))
plot(a,xlab="aaa")

# 그래프의 여백 조정하기
a <- c(1,2,3,4,5)
plot(a,xlab='aaa')

#par(oma=c(아래, 왼쪽, 위, 오른쪽))
#par(oma=c(0,0,0,0)) - 기본 설정값

par(oma=c(2,1,0,0))
plot(a,xlab='aaa')

#########################################
# 그래프 겹쳐 그리기
# par(new=T) : 중복 허용 옵션

par(mfrow=c(1,1))

v1 <- c(1,2,3,4,5)
v2 <- c(5,4,3,2,1)
v3 <- c(3,4,5,6,7)

#각 plot 창에 출력
plot(v1,type='s', col='red', ylim=c(1,5))
plot(v2,type='o', col='blue', ylim=c(1,5))
plot(v3,type='l', col='green', ylim=c(1,7))

# par(new=T) 사용 => 축의 중복도 허용되어서 그래프 구분이 어려움
plot(v1,type='s', col='red', ylim=c(1,5))
par(new=T)
plot(v2,type='o', col='blue', ylim=c(1,5))
par(new=T)
plot(v3,type='l', col='green', ylim=c(1,7))

# plot()과 lines() 함수를 사용하여 겹쳐서 출력
plot(v1,type='s', col='red', ylim=c(1,10))
lines(v2,type='o', col='blue', ylim=c(1,5))
lines(v3,type='l', col='green', ylim=c(1,15))
#lines() : 그래프 위에 선을 추가하는 함수

points(3,5, cex=5, pch="+", col="red")
points(2,5, cex=5, pch=1, col="red")
points(3,4, cex=5, pch=2, col="red")

# 대각선 그리기
# abline() 함수 사용
# a : 절편
# b : 기울기
# col : 색상
# lty : 선스타일
abline(a=0, b=1, col='black', lty=6)

# 수평선 : h값 사용
# 수직선 : v값 사용
abline(h=6, col='magenta', lty=3)
abline(v=3, col='cyan', lty=2)

# legend(x,y,범례내용, 크기, 색상, 선타입) : 범례 생성
plot.new()
plot(v1,type='s', col='red', ylim=c(1,10))
lines(v2,type='o', col='blue', ylim=c(1,5))
lines(v3,type='l', col='green', ylim=c(1,15))

legend(4,5,
       c("v1", "v2", "v3"),
       cex=0.2,
       col=c("red", "blue", "green"),
       lty=1)

legend('topleft',
       c("v1", "v2", "v3"),
       cex=0.2,
       col=c("red", "blue", "green"),
       lty=1)

legend('bottomright',
       c("v1", "v2", "v3"),
       cex=0.2,
       col=c("red", "blue", "green"),
       lty=1)

###########################################
# barplot() 함수
# 범주형 자료의 빈도수를 기둥의 높이로 표현하는 그래프
# 수치형 자료의 크기를 높이로 비교 표현하는 그래프

# barplot(height, 인수, ... ,)
# height
# 각 기둥의 높이에 해당한느 값 (벡터 또는 행렬)
# 벡터일 경우 각 기둥의 높이는 x의 원소들로 결정
# 행렬일 경우, 열의 개수 만큼 기둥이 만들어지고
# 기둥의 높이는 열에 해당되는 행값의 누적값으로 높이가 결정됨 
# 데이터프레임일 경우 벡터or행렬로 형변환해야 함

#[1] 벡터 이용
x <- c(1,2,3,4,5)
barplot(x)
barplot(x, names=c(1:5))

#빈도값을 생성 후 막대그래프 그리기
a <- c(1,2,3,3,1)
a_t <- table(a)
barplot(a_t)

#가로막대그래프
barplot(x, horiz=T)
barplot(a_t, horiz=T)

# [2] 행렬 값으로 barplot() 그리기
x <- matrix(c(5,4,3,2),2,2)
x

# 행열의 각 열에 대한 누적막대그래프
barplot(x,
        names=c('1열', '2열'),
        col = c("gold", "tomato"),
        ylim=c(0,12))

# 묶음막대 그래프
barplot(x,
        beside=T,
        names=c('1열', '2열'),
        col = c("pink", "blue"),
        ylim=c(0,6))

# 여백 설정 : oma 옵션
par(oma=c(1,0,5,1,0.5))

barplot(x,
        beside=T,
        names=c('1열', '2열'),
        col = c("skyblue", "magenta"),
        ylim=c(0,12))

# 가로누적 막대그래프
barplot(x,
        
        names=c('1열', '2열'),
        col = c("skyblue", "magenta"),
        horiz = T,
        Xlim=c(0,12))


# [3] dataframe으로 막대그래프 그리기
v1=c(100,120,140,160,180)
v2=c(130,130,150,140,170)
v3=c(180,140,110,120,150)

qty <- data.frame(BANANA=v1, CHERRY=v2, ORANGE=v3)

# 'height'는 반드시 벡터 또는 행렬이어야 합니다 => 형변환 해야함
#누적 막대그래프
barplot(as.matrix(qty),
        main = "Fruit's Sales QTY",
        col = rainbow(nrow(qty)),
        ylim= c(0,300)
        )

#묶음막대그래프
barplot(as.matrix(qty),
        main = "Fruit's Sales QTY",
        beside = T,
        col = rainbow(nrow(qty)),
        ylim= c(0,300)
)

legend(14,300,
       c('MON', 'TUE', 'WED','TUE', 'FRI'),
       cex = 0.8,
       fill = rainbow(nrow(qty)) )

rainbow(7)
rainbow(7)

rainbow(4)

rainbow(100)


######################################################
# 히스토그램
# 연속형 data를 구간별로 시각화할 때 사용
# 5학년 1반 학생들 20명의 키 data
# hist() 함수
######################################################
weather <- read.csv("weather_area.csv")
View(weather)

tmpl <- weather$평균기온
hist(tmpl)
# 그래프함수에 기본설정된 수 만큼 구간을 나누고
# 해당구간에 빈도를 계산해서 보여줌
# 25도에서 30도 사이의 빈도가 가장 높음
# 여름기온임을 유추할 수 있음

# 구간 간격 조정
# 구간을 특정 개수로 설정, breaks = 구간 수
hist(tmpl, breaks = 24 )

# 임의로 구간 설정 breaks = 구간 값 벡터
hist(tmpl, breaks=seq(10,40,by=5))

##############################################
# 원그래프
# 데이터간의 비율 비교할 때 많이 사용
# 차트에 표시할 데이터의 전체 합이 100이 되어야 하는 경우 유용
# pie()
##############################################

# 기본 pie 차트
pl <- c(10,20,32,38)
pie(pl, radius = 1)

pie(pl, radius = 1, init.angle = 90)

# 색상과 label명 설정
pie(pl, radius = 1, init.angle = 90,
    col=rainbow(length(pl)),
    label=c("1주", "2주", "3주", "4주"))

pie(pl, radius = 0.5, init.angle = 90,
    col=rainbow(length(pl)),
    label=c("1주", "2주", "3주", "4주"))


# 데이터값 출력하기
# 소수점 1자리수로 퍼센트 출력
pl/sum(pl)
pct <- round(pl/sum(pl)* 100,1)
lab <- paste(pct, "%")

pie(pl, radius = 1, init.angle = 90,
    col=rainbow(length(pl)),
    label=lab)

# legend() : 범례
legend('topright',
       c("1주", "2주", "3주", "4주"),
       cex=0.5,
       fill=rainbow(length(pl)))

pct <- round(pl/sum(pl)* 100,1)
lab <- paste(pct, "%")
lab1 <- c("1주", "2주", "3주", "4주")
lab2 <- paste(lab1, "\n", lab)

pie(pl, radius = 1, init.angle = 90,
    col=rainbow(length(pl)),
    label=lab2,
    cex=0.8) #label 크기 조정

############################################
# boxplot()
# 기술통계량(중앙값, 제1사분위, 제3사분위 등)을
# 상자모양으로 요약해서 나타낸 그래프

v1 <- c(10,12,15,11,20)
v2 <- c(5,7,15,8,9)
v3 <- c(11,20,15,18,13)

boxplot(v1,v2,v3,
        col=c("blue","yellow", "pink"),
        names=c("v1", "v2", "v3"))

boxplot(v1,v2,v3,
        col=c("blue","yellow", "pink"),
        names=c("v1", "v2", "v3"),
        horizontal = T)

boxplot(v1,v2,v3,
        col=c("blue","yellow", "pink"),
        names=c("v1", "v2", "v3"),
        horizontal = T,
        notch = T)

setwd("../")
getwd()









































