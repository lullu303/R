# credit.csv 파일을 활용해서 아래 내용의 코드를 작성하시오.
credit_df <- read.csv('data/credit.csv')
# 100명 고객에 대한 신용평가 자료
head(credit_df)
tail(credit_df)
str(credit_df)

# 연령별 신용도의 빈도 확인(age와 credit 교차표)
credit_df$Age <- as.factor(creadit_df$Age)

# xtabs() 함수로 각 셀의 도수 계산
freeq_Age <- xtabs(~Age, data=credit_df)
credit_Age_Freq <- xtabs(~Age+Credit, data=credit_df)

# margin.table()을 이용하여 행변수에 대한 도수분포 계산
margin.table(credit_Age_Freq, 1)
margin.table(freeq_Age,1)

# margin.table()을 이용하여 열변수에 대한 도수분포 계산
margin.table(credit_Age_Freq, 2)
margin.table(freeq_Age,2)
margin.table(freeq_Age)

# prob.table()을 이용하여 행비율 계산
prop.table(credit_Age_Freq, margin = 1)
prop.table(freeq_Age, margin=1) # 엉뚱한 결과 

# prob.table()을 이용하여 열비율 계산
prop.table(credit_Age_Freq, margin = 2)
prop.table(freeq_Age, margin=2)

# prob.table()을 이용하여 전체비율 계산
prop.table(credit_Age_Freq, margin = NULL)
prop.table(freeq_Age, margin=NULL)









