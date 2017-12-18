# Boxplot를 활용한 과대오차 찾아내고 그래프 완성하기 - 7장 
install.package("ggplot2")  
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy) #hwy는 내장함수 
boxplot(mpg$hwy)$stats
# 12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy) 
table(is.na(mpg$hwy))# 결측지의 빈도  
       mpg %>%   
      group_by(drv) %>%   
summarise(mean_hwy = mean(hwy, na.rm = T)) 
# 1. 결측치 정제하기
# 결측치 확인
table(is.na(df$score)) 

# 결측치 제거
df_nomiss <- df %>% filter(!is.na(score)) 

# 여러 변수 동시에 결측치 제거
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex)) 

# 함수의 결측치 제외 기능 이용하기
mean(df$score, na.rm = T) 
exam %>% summarise(mean_math = mean(math, na.rm = T)) 

# 2. 이상치 정제하기
# 이상치 확인
table(outlier$sex) 

# 결측 처리
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex) 

# boxplot 으로 극단치 기준 찾기
boxplot(mpg$hwy)$stats 

# 극단치 결측 처리
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy) 
