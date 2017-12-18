#가설 검정 하기
t검정 
데이터 준비 
mpg <- as.data.frame(ggplot2::mpg) 

library(dplyr) mpg_diff <- mpg %>%    select(class, cty) %>%    filter(class %in% c("compact", "suv")) 

head(mpg_diff)
table(mpg_diff$class) 
t.test(data = mpg_diff, cty ~ class, var.equal = T) 
데이터 준비 
mpg_diff2 <- mpg %>%    select(fl, cty) %>%    filter(fl %in% c("r", "p"))  # r:regular, p:premium


table(mpg_diff2$fl)
t.test(data = mpg_diff2, cty ~ fl, var.equal = T) 
상관 분석
데이터 준비 
economics <- as.data.frame(ggplot2::economics) 
cor.test(economics$unemploy, economics$pce) 
데이터 준비 
head(mtcars) 
상관행렬 만들기 
car_cor <- cor(mtcars)  # 상관행렬 생성
round(car_cor, 2)       # 소수점 셋째 자 리에서 반올림해서 출력
