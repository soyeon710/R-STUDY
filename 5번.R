# 데이터 분석 프로젝트 - 9장
패키지 준비하기 
install.packages("foreign")  # foreign 패키지 설치
library(foreign)             # SPSS 파일 로드
library(dplyr)               # 전처리
library(ggplot2)             # 시각화
library(readxl)              # 엑셀 파일 불러오기

데이터 준비하기 
# 데이터 불러오기
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",                          to.data.frame = T) 

# 복사본 만들기
welfare <- raw_welfare 
데이터 검토하기 
head(welfare) 
tail(welfare) 
View(welfare) 
dim(welfare) 
str(welfare) 
summary(welfare) 
변수명 바꾸기 
welfare <- rename(welfare,                  
                  sex = h10_g3,            # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종 코드
                  code_region = h10_reg7)  # 지역 코드
"성별에 따라 월급이 다를까?" 
1. 변수 검토하기 
class(welfare$sex) 
table(welfare$sex) 
# 이상치 확인
table(welfare$sex) 
# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex
# 결측치 확인
table(is.na(welfare$sex)) 
# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female") table(welfare$sex)
qplot(welfare$sex) 
월급 변수 검토 및 전처리 
1. 변수 검토하기 
class(welfare$income) 
summary(welfare$income) 
qplot(welfare$income) 
qplot(welfare$income) + xlim(0, 1000) 
2. 전처리 
# 이상치 확인
summary(welfare$income)
# 이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income) 

# 결측치 확인
table(is.na(welfare$income)) 
1. 성별 월급 평균표 만들기 
sex_income <- welfare %>%   filter(!is.na(income)) %>% 
                            group_by(sex) %>%
                            summarise(mean_income = mean(income)) 
sex_income 
2. 그래프 만들기 
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col() 

sex_income
# 1. 변수 검토하기
class(welfare$birth)

summary(welfare$birth)

qplot(welfare$birth)
# 태어난 년도 1900~2014, 모름/무응답 : 9999

# 2. 이상치 확인
summary(welfare$birth)

# 3. 결측치 확인
table(is.na(welfare$birth))  # 확인 결과 이상치 및 결측치 없음

#만일 이상치가 있었다면 다음 작업이 필요하다. 즉, 이상치의 결측치 화 
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)

table(is.na(welfare$birth))

# 4. 파생변수 생성 - 나이
welfare$age <- 2015 - welfare$birth + 1

summary(welfare$age)

qplot(welfare$age)


# 5. 나이에 따른 월급 평균표 만들기
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>%  
  summarise(mean_income = mean(income))

head(age_income)

ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_line()


### 다. 년령대에 따른 월급 차이 ----- 어던 연령대의 월급이 가장 많을까 ? -----------
# 분석절차
# 변수검토 및 전처리(연령대, 월급) 
# 변수간 관계분석(년령대별 월급 평균표 만들기, 그래프 만들기)

# 파생변수 만들기 : 초년(30세 미만), 중년(30-59세), 노년(60세 이상)
#  %>% : dplyr 패키지의 함수들은 %>% 를 이용해 조합할 수 있음
# install.packages("dplyr")
# library(dplyr)

welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))

table(welfare$ageg)

qplot(welfare$ageg)

# 연령대에 다른 월급 차이 분석하기 - 연령대별 월급 평균표 만들기    ???
ageg_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income

ggplot(data=ageg_income, aes(x=ageg, y=mean_income)) + geom_col()

ggplot(data=ageg_income, aes(x=ageg, y=mean_income)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))


### 라. 연령대 및 성별 월급 차이 - --- 성별 월급차이는 연령대별로 다를까 ?  -----------
# 변수검토 및 전처리(연령대, 성별, 월급) 
# 변수간 관계분석(년령대 및 성별 월급 평균표 만들기, 그래프 만들기)

# 1. 연령대 및 성별 월급 평균표 만들기
# 결측치, 이상치 조정

sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))

sex_income

# 2. 그래프 만들기
ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill = sex)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 위 그래프는 각 성별의 월금이 연령대와 함께 표현되어 명확한 이해에 어려움이 있다.
ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill = sex)) + geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))


# 이번에는 년령대로 구분하지 않고 나이 및 성별 월급 평균표를 그래프로 나타내 보자
# 그래프는 선 그래프, 월급 평균선이 다른 색으로 

sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

ggplot(data = sex_age, aes(x=age, y=mean_income, col = sex)) + geom_line()


### 마. 직업별 월급차이 --- 어던 직업이 월금을 가장 많이 받을까 ? --------
# 직업별 월급 문석하기
# 1. 직업 변수를 검토하고 전처리 작업 수행합시다. - 월급변수 전처리 작업은 앞단계에서 수행했음.
# 변수간 관계를 분석합니다. 변수검토 및 전처리 (직업, 월급) 
# --> 변수간 관계분석(직업볋 월급 평균표, 그래프 작성)
class(welfare$code_job)

table(welfare$code_job)

# 2. 전처리
# library(readxl)
list_job <- read_excel("koweps_Codebook.xlsx", col_names = T, sheet = 2)

head(list_job)


dim(list_job)  # 직업이 149개로 분류

welfare <- left_join(welfare, list_job, id="code_job")     # left_join 으로 job 변수를 welfare에 결합 

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

# 직업별 월급 평균표 만들기, 직업별 월급 평균 구하기

job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

head(job_income)

# 어떤 직업의 월급이 많은지 월급을 내림 차순으로 정렬하고 상위 10개를 추출
top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

top10

# 그래프로 나타내기
ggplot(data=top10, aes(x=reorder(job, mean_income), y= mean_income)) + 
  geom_col() +
  coord_flip()


# 이번에는 월금이 하위 10위권인 직업을 추출
bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)

bottom10

# 그래프 만들가
ggplot(data=bottom10, aes(x=reorder(job, -mean_income), y= mean_income)) + 
  geom_col() +
  coord_flip() +
  ylim(0, 850)


### 바. 성별 직업 빈도 - "성별로 어던 직업이 가장 많을까 ? ------
# 분석절차
# 변수 검토 및 전처리(성별, 직업) - 변수간 관계분석(성별 직업 빈도표 만들기, 그래프 만들기)
# 성별 변수 전처리와 직업 변수 전처리는 앞에서 완료했음.  바로 변수간 관계를 분석해 보자
#
# 1. 성별 직업 빈도표 만들기 - 각각 상위 10개를 추출
# 남성 직업별 빈도 상위 10개
job_male <- welfare %>% 
  filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_male

# 여성 직업별 빈도 상위 10개
job_female <- welfare %>% 
  filter(!is.na(job) & sex == "female") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_female


# 그래프 만들기

# 남성 직업 상위 10개 그래프
ggplot(data=job_male, aes(x=reorder(job, n), y= n)) + 
  geom_col() +
  coord_flip()

# 여성 직업 상위 10개 그래프
ggplot(data=job_female, aes(x=reorder(job, n), y= n)) + 
  geom_col() +
  coord_flip()


###  사. 종교 유무에 따른 이혼율 - "종교가 있는 사람이 이혼을 덜할까 ?  ------
# 분석절차
# 변수 검토 및 전처리(종교, 혼인상태) - 변수간 관계분석(종교 유무에 따른 이혼율 표 만들기, 그래프만들기)

# 종교 변수 검토 및 전 처리
# 1. 변수 검토하기
class(welfare$religion)

table(welfare$religion)

# 2. 전처리
# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")

table(welfare$religion)

qplot(welfare$religion)


# 혼인상태변수 검토 및 전 처리
# 1. 변수 검토하기
class(welfare$marriage)

table(welfare$marriage)

# 2. 파생변수 만들기
# 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA))

table(welfare$group_marriage)

table(is.na(welfare$group_marriage))

qplot(welfare$group_marriage)

# 종교유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))

religion_marriage

# 앞의 표에서 이혼에 해댕하는 값만 추출해 이혼율 표를 만들어 보자

# 이혼 추출
divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(religion, pct)

divorce

# 그래프 만들기
# 이혼율 표를 이용해 그래프를 그려보자

ggplot(data=divorce, aes(x=religion, y= pct)) + geom_col()

# 년령대 및 종교 유무에 따른 이혼률 분석하기
# 년령대별 이혼율 표 만들기
ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg, group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))

ageg_marriage

# 년령대별 이혼률 그래프 만들기
# 초년제외, 이혼 추출
ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage == "divorce") %>% 
  select(ageg, pct)

ageg_divorce

ggplot(data = ageg_divorce, aes(x = ageg, y = pct))+ geom_col()

# 년령대 및 종교 유무에 따른 이혼률 표 만들기
# 년대, 종교유무, 결혼 상태별 비융표 만들기
ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != "young") %>% 
  group_by(ageg, religion, group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))

ageg_religion_marriage

# 년령대 및 종교 유무별 이혼률 표 만들기
df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(ageg, religion, pct)

df_divorce

ggplot(data = df_divorce, aes(x=ageg, y=pct, fill = religion)) +
  geom_col(position = "dodge")



## 아. 지역별 연령대 비율 - 노년층이 많은 지역이 어디일까요 ?   --------

# 변수 검토 및 전처리(지역, 년령대) - 변수간 관계분석(지역별 연령대 비율표 만들기, 그래프만들기)
# 지역 변수 검토 및 전 처리
# 1. 변수 검토하기
class(welfare$code_region)

table(welfare$code_region)

# 2. 전처리
# code_region ( 1 서울,  2 수도권(인천/경기), 3 부산/경남/울산, 4 대구/경북, 5 대전/충남
#               6 강원/충북,  7 광주/전남/전북/제주도)

# 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))

list_region

# 지역별 변수 추가
welfare <- left_join(welfare, list_region, id= "code_region")

welfare %>% 
  select(code_region, region) %>% 
  head

# 지역별 년령대 비율 분석하기
# 지역별 년령대 비율표 만들기
region_ageg <- welfare %>% 
  group_by(region, ageg) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 2))

head(region_ageg)

# 그래프 만들기
ggplot(data=region_ageg, aes(x=region, y= pct, fill = ageg)) + 
  geom_col() +
  coord_flip()

# 노년층 비율 내림차순 만들기
list_order_old <- region_ageg %>% 
  filter(ageg == "old") %>% 
  arrange(pct)

list_order_old

# 지역명 순서 변수 만들기
order <- list_order_old$region

order

ggplot(data=region_ageg, aes(x=region, y= pct, fill = ageg)) + 
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)

# 년령대 순으로 막대 색깔 나열하기
class(region_ageg$ageg)

levels(region_ageg$ageg)

# factor()를 이용해서 ageg 변수를 factor 타입으로 변환하고 level 파라미터를 이용해 순서를 정한다.
region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))

class(region_ageg$ageg)

levels(region_ageg$ageg)

ggplot(data=region_ageg, aes(x=region, y= pct, fill = ageg)) + 
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)
