list.files()
setwd("data")
getwd()
list.files()

# 다음과 같은 데이터 프레임 df_ex1 생성
# ◼ NO NAME PRICE
# ◼ 1 monitor 300000
# ◼ 2 mouse 25000
# ◼ 3 keyboard 35000
no = c(1,2,3)
name= c('monitor', 'mouse', 'keyboard')
price = c(300000, 25000, 35000)

df_ex1 <- data.frame(NO=no, NAME=name, PRICE=price)
df_ex1

# 다음과 같은 데이터 프레임 생성 : df_student
# ◼ NAME KOR MATH ENG
# ◼ 홍길동 100 90 80
# ◼ 이몽룡 90 95 98
# ◼ 성춘향 85 98 100

df_student <- data.frame(
  Name=c('홍길동','이몽룡','성춘향'),
  KOR=c(100,90,85),
  MATH=c(90,95,98),
  ENG=c(80,98,100)
)
df_student

# 열 이름 모두 출력
names(df_student) # 벡터 요소의 이름을 부여할 때도 사용가능
colnames(df_student)

# ◼ 행의 개수 출력
nrows(df_student)
NROWS(df_student)

# ◼ 1, 2 열 출력
# ◼ 1, 3 열 출력
df_student[,1:2]
df_student[,c(1,3)]
########################################################################
# 데이터프레임 연습문제
########################################################################


# 다음과 같은 데이터 프레임 생성 : df_eval
# NAME  TOEIC  JLPT   
# 이몽룡  500      N1  
# 박길동  600      N4   
# 홍길동  700      N5 
# 김길동  650      N2 

df_eval <- data.frame(Name=c('이몽룡','박길동','홍길동','김길동'),
                      TOEIC=c(500,600,700,650),
                      JLPT=c('N1','N4','N5','N2'))
df_eval

df_eval <- cbind(df_eval, 
                 data.frame(SCI=c(88,80,94,70)))

df_eval

ncol(df_eval)
NCOL(df_eval)

# 2행만 제외하고
df_eval[-2,]

# 1열을 제외하고
df_eval[,-1]

# 1,4,2,3 열 순서로 출력
df_eval[,c(1,4,2,3)]
df_eval[,c('Name', 'SCI', 'TOEIC', 'JLPT')]

df_eval[2,'Name']

# merge(공통열 확인해야 함)
df_student;df_eval
merge(df_student, df_eval) # INNER JOIN(교집합)
merge(df_student, df_eval, all = T) # OUTER JOIN(합집합)
# 컬럼 data가 없으면 NA로 처리

cbind(df_student, df_eval)

cbind(df_eval, df_student)

# df_eval에서 NAME, TOEIC, JLPT 열만 선택해 df_eval2로 생성
df_eval2 <- df_eval[,c('Name', 'TOEIC', 'JLPT')]
df_eval2 <- subset(df_eval, select = c('Name', 'TOEIC', 'JLPT'))
df_eval2

########################################################################
# 데이터입출력 연습문제
########################################################################

# 1. ex1.txt 파일을 원본 그대로 읽어오기
ex_data <- scan("ex1.txt", what="")
ex_data

# 2. 메모장을 열어 아래 내용을 입력 후 ex2.txt로 저장
# 숫자와 숫자 사이는 스페이스로 구분
# ex2.txt 파일을 원본 그대로 가져오기
ex2_1 <- scan('ex2.txt') 
ex2_1

# 3. ex2.txt 파일을 테이블 형태로 읽어오기
ex2_2 <- read.table('ex2.txt')
ex2_2
class(ex2_2)

# 4. 사용자로부터 국어 점수를 입력받아 벡터로 저장
# kor <- scan(what="")
kor <- as.double(readline("국어 점수 입력 : "))
class(kor) #"character" -> "numeric"


# 5. 사용자로부터 주소를 입력 받아 벡터로 저장
address <- scan(what="주소 입력 : ")
address

input2 <- scan(what="") # 문자의 구분을 띄어쓰기 또는 enter로 가능
input2

# 6. 메모장을 열어 아래 내용을 입력해 mem.txt로 저장
# 구분자는 공백으로 설정
# mem.txt 파일을 데이터프레임으로 저장
# 열 이름은 name, tel, address로 변경해서 읽어오기
mem <- read.table("mem.txt",
                  header = T,
                  col.names = c("name", "tel", "address"))
mem

# 8. baseball_player.txt 파일을 주석을 제외하고 데이터 프
# 레임으로 가져와서 View() 함수로 확인
# 주석을 제외하고 데이터프레임으로 저장

baseball <- read.table('baseball_player.txt',
                       sep = ",",
                       header=T)
baseball

# baseball_player.txt 파일의 3행부터 6행까지 데이터 프
# 레임(players)으로 가져와서( 변수명 지정)
# ◼ 변수명 : 순위, 타율, 홈런, OPS
baseball <- read.table('baseball_player.txt',
                       sep = ",",
                      skip=3,
                      nrow=4,
                      col.names = c("순위", "타율", "홈런", "OPS"))
baseball

# players.xlsx 파일로 저장 (행 번호 제거하고 저장)
library(writexl)
write_xlsx(player, path = "players.xlsx") #행인덱스 내보냄
write_xlsx(player, path = "players.xlsx", row.names=F) #행인덱스 내보내지 않음



# 10.아파트_실거래가.xlsx 파일을 데이터 프레임으로 가져와
# 서 View() 함수로 확인하고
library(readxl)
apt_info <- read_excel('아파트_실거래가.xlsx')
View(apt_info)
class(apt_info)
# ◼ 거래금액이 100,000 이상인 행만 추출해서 View() 함수로 확인
apt_sub <- subset(apt_info, 거래금액 >=100000)
View(apt_sub)
# ◼ 거래금액이 100,000 이상인 행 수 출력하고
cat("거래금액이 100,000 이상인 행 수 : ", nrow(apt_sub))

# ◼ “apt_sub_100000.csv”로 저장 (따옴표 제외)
write.csv(apt_sub, file='apt_sub_100000.csv',
          quote=FALSE)

