# 벡터 : 1차원 동일한 데이터들의 집합
# c() 함수를 이용해서 생성
ex_vector <- c(-0.5,1.0,0.5)
ex_vector1L <- c(-1L, 0L, 1L)
ex_vector
# [1] -0.5  1.0  0.5

v <-c(1:100)
v
# str() : 변수의 속성(객체종류, 인덱스 범위, 요소값) 확인
str(ex_vector)
str(ex_vector1L)

# length() : 벡터의 길이(요소의 개수) 반환
length(ex_vector)

ex_vector2 <- c("hello","hi~!")
str(ex_vector2)

ex_vecotr3 <- c(TRUE, TRUE, FALSE, FALSE)
str(ex_vecotr3)

v <- c(3>5)
v

#####################
#벡터에서 특정 위치값 추출(인덱싱) : []사용 - index값 1부터 시작
#####################
vec1 <- c(1,2,3,4,5)
# 3번째 요소값 추출
vec1[3] 

# 마이너를 붙일 경우 해당 요소만 제외하고 모두 추출
# 세번째 요소를 제외한 나머지 요소 추출
vec1[-3]

# 연속적인 index의 값을 추출시 초기인덱스:마지막인덱스 사용
vec1[1:3]
vec1[1:(length(vec1)-2)] # 1 2 3

# -인덱스값 : -인덱스값
vec1[-1:-3] # 1번인덱스부터 3번인덱스까지를 제외한 나머지 추출

vec1[2:3]

# 벡터에서 특정 위치값 변경
vec1
vec1[2] <- 6
vec1

# 벡터에 새로운 요소 추가
vec1 <- c(vec1,7)
vec1
length(vec1)
# 주의!
# 없는 위치에 값을 추가하면 길이가 연장되면서 빈 위치에 NA로 채워짐
vec1[7]<-10
vec1
vec1[10]<-20 # 7번값이 있는 상태에서 10번째에 값을 할당하면 8,9번은 NA로 채워진다
vec1

# 벡터의 특정 위치에 요소 추가
# append(벡터변수,추가할 값,after=추가할 위치 인덱스 )함수 사용
# 원본변수 변경시키지 않음
append(vec1,2,after=1)#after=1 1번index 뒤에 추가
vec1

# 벡터의 1번째에 추가할때는
append(vec1,11,after=0)
vec1

# 집합 함수를 사용한 벡터의 집합 연산
# union() : 합집합
# intersect() : 교집합
# setdiff() : 차집합

# 숫자 집합 연산
a <- c(1,2,3)
b <- c(3,4,5)
union(a,b)

c<-c('3','4')
union(a,c) #합집합 연산을 진행하면서 벡터의 원칙에 따라 전부 문자로 변환

intersect(a,b)
setdiff(a,b)
setdiff(b,a)

# 벡터는 각 요소들이 열로 생성되는 의미를 갖는다
# 각 요소(열)의 이름을 지정할 수 있음
# names() 함수 사용
fruits <- c(10,20,30)
names(fruits)<-c('apple','banana','peach')
fruits

# seq() 이용해서 연속적인 날짜 생성
var7 <- seq(as.Date("2023-03-20"),as.Date("2023-06-30"),by='day')
var7

var8 <- seq(as.Date("2023-03-20"),as.Date("2023-06-30"),by='month')
var8

# 벡터에서 특정 값 포함 여부 확인 : %in%
a
3 %in% a
"3" %in% a # 주의
5 %in% a

#################
# 행렬 : 행과 열로 구성된 2차원 데이터
# 단일형
# matrix() 함수를 이용하여 생성
#################
c(1,2,3,4)
mat1 <- matrix(c(1,2,3,4)) # 열기준 생성
mat1

mat2 <- matrix(c(1,2,3,4),nrow=2)
mat2

# 행렬 데이터 구성 방향을 왼쪽에서 오른쪽으로 변경 byrow=T

mat3 <- matrix(c(1,2,3,4),nrow=2, byrow=T)
mat3

# 행열 지정
x <- c(1,2,3,4,5,6)
matrix(x, nrow=2, ncol=3)
matrix(x, nrow=3, ncol=2)
matrix(x, nrow=3, ncol=2, byrow=T)

# matrix의 데이터 조회
mat3
# 모든행의 1열 값 조회(벡터로 반환)
mat3[,1]

# 1행의 모든 열값 조회
mat3[1,]

# 1행 1열의 값 조회
mat3[1,1]

# 행렬에 새로운 행과 열 추가
# rbind(), cbind() 사용
mat4 <- matrix(c(1,2,3,
                 4,5,6,
                 7,8,9), nrow=3, byrow=T)
mat4

# rbind(matrix변수, 추가할데이터벡터) 행추가-변수 원본 변경 없음
mat4<-rbind(mat4,c(10,11,12))
mat4

# 추가되는 행의 열의 개수가 다를경우 경고 후 열수 개수만큼만 추가
mat4<-rbind(mat4,c(13,14,15,16))
mat4

# cbind() 열 추가
mat5 <- matrix(c('a','b','c','d'), nrow=2, byrow=T)
mat5

# 열 추가
mat5 <- cbind(mat5,c('e','f'))
mat5

# 열이름 지정 : colnames(matrix), 행이름 지정 : rownames(matrix)
colnames(mat5) <- c('F','S','T')
rownames(mat5) <- c('A','B')
mat5

############
# 배열 : 행열의 구조를 n차원으로 확대 가능한 데이터 세트
# 단일형
# array(변수명, dim=c(행수, 열수, 차원수))
############
y <- c(1,2,3,4,5,6)
array(y,dim=c(2,2,1)) #z=1

array(y,dim=c(2,2,2)) #z=2

array(y,dim=c(2,2,3)) #z=3

array1 <- array(c(1:12),dim=c(4,3))
array1

array2 <- array(c(1:12),dim=c(2,2,3))
array2

array2[1,1,3]
array2[1,1,] # 모든 층의 1행 1열의 값 추출, 1 5 9
array2[,,2] # 2층의 모든 값 추출

############################################################################

#### 
# 리스트 : 여러데이터를 그룹화한 개념
# 다중형 1차원 구조
# 리스트 <- 벡터, 행렬, 데이터프레임, 리스트
# 함수의 결과물이 리스트형태로 반환되는 경우가 많음
# list() 사용
####

# 리스트 생성
# 여러 형태의 데이터 타입을 사용
lst <- list(1,'2',3.14,TRUE,"홍길동")
lst
# [[1]],[[2]] : 리스트에 포함된 값을 형별로 출력
# 리스트 변수 속성 확인
str(lst)

list1 <- list(c(1,2,3),"hello")
list1

str(list1)

# key=value로 구성된 리스트
list2 <- list(name="james",
              address='Seoul',
              tel="010-1111-0000",
              pay=500)
list2
typeof(list2$name)
list2$pay

list2[1]
lst[2]
list2[2:4]

# 리스트에 새로운 요소 추가
list2$birth <- '1997-10-23'
list2

# 하나의 key에 두개의 value 동시에 넣기
list2$name <- c('홍길동','이몽룡')
list2$name
list2

# 리스트에 특정요소 삭제
list2$birth <- NULL
list2


###############################
# Dataframe
# 리스트를 2차원으로 확장해서 구성한 다중형 구조
# 각 열에는 변수명이 있어야 함 (속성명, 열이름)
# data.frame(열1, 열2, 열3)

#데이터프레임 생성
#열 기준 데이터를 벡터로 생성 후 함수 사용

ID <- c(1:10)
SEX <- c("F","M","F","M","M","F","M","F","M","M")
AGE <- c(50,40,28,50,27,23,56,47,20,38)
AREA <- c('서울','경기','제주','서울','서울',
          '서울','경기','인천','서울','경기')

# 벡터변수를 포함한 데이터프레임 생성
# 변수의 이름을 열 이름으로 생성
dataframe_ex <- data.frame(ID, SEX, AGE, AREA)
dataframe_ex
str(dataframe_ex)

# 벡터 변수 사용
eng <- c(90,80,60,70)
math <- c(50,60,100,20)
class <- c(1,1,2,2)
df_test <- data.frame(eng, math, class)
df_test

# df 생성 방법 2 (key=value)
df_midterm <- data.frame(kor = c(90,80,60),
                         eng = c(90,97,88),
                         math = c(85,90,78))

# df 생성 방법 3 
df_test = data.frame(id=ID, sex=SEX)
df_test


df_test = data.frame(번호=ID, 성별=SEX)
df_test

no <- c(1,2,3,4)
name <- c('Apple','Peach','Banana','Grape')
price <- c(500,200,100,50)
qty <- c(5,2,4,7)

df_sales <- data.frame(NO=no, NAME=name, PRICE=price, QTY=qty)
df_sales

# df의 열이름 변경
# names(df) 이용
df_midterm
names(df_midterm) <- c('국어','영어','수학')

# df의 열이름/행이름 조회
# colnames(df);rowmanes(df)
colnames(df_midterm)
rownames(df_midterm)

# 데이터프레임에 열 추가
# df$ 새로운 열이름 <- 값
df_midterm$미술 <- 95 #모든 행에 95값을 추가
df_midterm

# 데이터프레임에서 열 삭제
#subset(df, select=조건) : 원본을 변경시키지 않음
df_midterm <- subset(df_midterm, select=-미술)
df_midterm







