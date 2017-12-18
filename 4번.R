#데이터 정제하고 분석하기 - 7장
summarise()에서 na.rm = T사용하기 ??? 결측치 생성 
exam <- read.csv("csv_exam.csv")            # 데이터 불러오기
exam[c(3, 8, 15), "math"] <- NA             # 3, 8, 15 행의 math 에 NA 할당

??? 평균 구하기 
exam %>% summarise(mean_math = mean(math))             # 평균 산출

##   mean_math ## 1        NA 
exam %>% summarise(mean_math = mean(math, na.rm = T))  # 결측치 제외하고 평균 산출
다른 함수들에 적용 
exam %>% summarise(mean_math = mean(math, na.rm = T),      # 평균 산출
                   sum_math = sum(math, na.rm = T),        # 합계 산출
                   median_math = median(math, na.rm = T))  # 중앙값 산출
평균값으로 결측치 대체하기 
평균 구하기 
mean(exam$math, na.rm = T)  # 결측치 제외하고 math 평균 산출
exam$math <- ifelse(is.na(exam$math), 55, exam$math)  # math 가 NA 면 55 로 대체
table(is.na(exam$math))                               # 결측치 빈도표 생성
exam  # 출력
이상치 제거하기 - 1. 존재할 수 없는 값 ??? 논리적으로 존재할 수 없으므로 바로 결측 처리 후 분석시 제외 
이상치 포함된 데이터 생성 - sex 3, score 6 
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),                       score = c(5, 4, 3, 4, 2, 6)) outlier
table(outlier$sex) 
table(outlier$score) 
결측 처리하기 - sex 
# sex 가 3 이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex) outlier # sex 가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score) outlier 
결측치 제외하고 분석 
outlier %>%   filter(!is.na(sex) & !is.na(score)) %>%   group_by(sex) %>%   summarise(mean_score = mean(score))
