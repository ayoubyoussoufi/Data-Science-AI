setwd("D:/Desktop/DataScienceMSc/ProcessDataR")
library(dplyr)
library(ggplot2)
wine <- read.csv("winequality-red.csv")
summary(wine)

wine <- wine %>% mutate(label =
                     case_when(alcohol < 9 ~ "Light", 
                              ( alcohol >=9 & alcohol < 12 ) ~ "Medium",
                               alcohol >= 12 ~ "Strong"))
wine %>% group_by(label) %>% summarise(n=n()) %>% arrange(desc(n))

p1 <- wine %>% ggplot(aes(label,fixed.acidity)) + geom_bar(stat = "identity", aes(fill = label))

p1+ggtitle("Distribution of the concentration of alcohol")

p2 <- ggplot(wine) + geom_histogram(aes(x = fixed.acidity, y = ..density..), bins=10, fill = 'pink') + geom_density(aes(x = fixed.acidity),col = 'green')
p2+facet_wrap(~label)


p2 <- wine %>% ggplot(aes(fixed.acidity))
p2+geom_density()+facet_wrap(~label)

cat <- cut(wine$quality,c(2,4,6,8), right = TRUE)
p <- wine %>% ggplot()+geom_jitter(aes(x=quality,y=alcohol, col=cat))
#p+geom_vline(data=wine, aes(xintercept=grp.mean, color="red"),linetype="dashed")

############################################################

library(gapminder) 
library(tidyverse)
library(dplyr) 

gapminder %>% group_by(continent)%>% summarise(nbr_continent = n(), n_country = n_distinct(country), mean(lifeExp))

gapminder %>%
  filter(year == 1992 & continent== 'Europe') %>%
  group_by(country) %>%
   summarize(n=sum(pop))%>%  arrange(desc(n))

gapminder$label <- NA
for(i in 1:length(gapminder$pop)){
  
  gapminder$label[i] <-gapminder$pop[i]/10**6
  gapminder$pop[i] <- gapminder$label[i]
}





  





