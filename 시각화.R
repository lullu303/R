getwd()
setwd("D:/RPG_PJT")

library(ggplot2)
library(scales)
library(dplyr)

game <- read.csv("data/Video_Games.csv")

head(game)
View(game)

# 플랫폼개수 
pl_count <- game %>% 
              group_by(Platform) %>% 
              summarise(count = n()) %>% 
              View()

# game$Year_of_Release <- ifelse(game$Year_of_Release < 1980 , '1980년 이전',
#                         ifelse(game$Year_of_Release >= 1980 & game$Year_of_Release < 1990, '1980년대',
#                         ifelse(game$Year_of_Release >= 1990 & game$Year_of_Release < 2000, '1990년대',
#                         ifelse(game$Year_of_Release >= 2000 & game$Year_of_Release < 2010, '2000년대',
#                         ifelse(game$Year_of_Release >= 2010 & game$Year_of_Release < 2020, '2010년대',
#                         ifelse(game$Year_of_Release >= 2020 , '2020년 이후'))))))
game %>%group_by(Genre) %>% 
  summarise(line_total = cnt(Genre)) %>% 
  arrange(desc(line_total))

