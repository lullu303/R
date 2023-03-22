# 행렬에 대해 which() 사용
m <- matrix(11:20, 3, 4)
m

# m안에서 3의 배수인 요소의 위치값 출력
which(m %% 3 == 0)
m[5]

# 파라미터 arr.ind = TRUE 를 사용하면
# ~행, ~열 형태로 인덱스를 반환
# 행열과 배열에만 적용된다
which(m %% 3 ==0, arr.ind = TRUE)
# row col
# [1,]   2   1 - 2행 1열에 3의 배수 값이 있음
# [2,]   2   2
# [3,]   2   3
# [4,]   3   4

# df내에서 which 함수 사용
# 내장 df인 tress 사용
trees
View(trees)

# df에 which() 사용하면 조건에 맞는 행 번호 반환 
# Height가 75미만인 행의 위치 반환
which(trees$Height < 75)
trees[which(trees$Height < 75),]
nrow(trees[which(trees$Height < 75),])

# which.max()/which.min()
# 나무 중에서 Height가 최대/최소인 나무의 정보 출력
which.max(trees$Height)
trees[which.max(trees$Height),] # 높이가 최대인 나무의 정보

which.min(trees$Height)
trees[which.min(trees$Height),] # 높이가 최소인 나무의 정보

#######################################################
# 데이터 구조 변환 함수
#######################################################
# as.vector() as.matrix() as.list() as.data.frame()

# 벡터를 변환
vec <- c(1:3)

# 벡터 -> 리스트
as.list(vec)

# 벡터 -> 행렬
as.matrix(vec)

# 벡터 -> 데이터프레임
as.data.frame(vec)

# 벡터 -> 배열로(사용하지 않음)
as.array(vec) # 에러가 나지 않지만 원하는 결과가 나오지는 않는다

# 리스트를 변환
lst <- list(1,2,3,4,5,6)

# 리스트 -> 벡터로
# 주의 : as.vector()를 사용하지 않음 unlist() 사용
as.vector(lst) # 에러가 나지 않지만 원하는 결과가 나오지는 않는다
unlist(lst)

# 리스트 -> 행렬
# 기본 파라미터 사용시 1열의 행렬로 생성
as.matrix(lst)

#행렬 수를 제공 후 변환 가능
as.matrix(lst,2,3) # 에러가 나지 않고 1열의 행렬만 생성
matrix(lst,2,3)

# 리스트 -> 데이터프레임
as.data.frame(lst)

# 각 요소들을 열(속성)로 생성
# 데이터가 숫자인 경우 리스트 요소의 첫번째 값을 기준으로 
# xX 형태로 변수명을 생성

lst2 <- list('a',5,'k','한글')
as.data.frame(lst2)

# 행렬을 변환
mx <- matrix(c(1,2,3,4), nrow=2)
mx

# 행렬 -> 벡터
as.vector(mx)

# 행렬 -> 리스트
as.list(mx)

# 행렬 -> 데이터프레임
as.data.frame(mx)

# 데이터프레임을 변환
df_midterm

class(df_midterm)

as.vector(df_midterm) # list 형태로 반환
class(as.vector(df_midterm))

df1 <- df_midterm[1,]
class(df1)

df_vec2 <- as.vector(df1)
class(df_vec2)

df2 <- df_midterm[,1]
df2 # 자체가 벡터

# 데이터 프레임 -> 리스트
as.list(df_midterm)

# 데이터프레임 -> 행렬
as.matrix(df_midterm) # 출력결과가 df처럼 보이지만 행렬을 반환함
class(as.matrix((df_midterm)))


