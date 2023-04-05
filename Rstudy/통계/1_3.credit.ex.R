# credit.csv 파일을 활용해서 아래 내용의 코드를 작성하시오.
credit_df <- read.csv('data/credit.csv')
# 100명 고객에 대한 신용평가 자료
head(credit_df)
tail(credit_df)
str(credit_df)

# 연령별 신용도의 빈도 확인
# xtabs() 함수로 각 셀의 도수 계산
# margin.table()을 이용하여 행변수에 대한 도수분포 계산
# margin.table()을 이용하여 열변수에 대한 도수분포 계산
# prob.table()을 이용하여 행비율 계산
# prob.table()을 이용하여 열비율 계산
# prob.table()을 이용하여 전체비율 계산