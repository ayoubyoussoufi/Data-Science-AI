library(gridExtra)
library(dplyr)
library(ggplot2)
#Exercise 1


p1 <- murders %>% ggplot(aes(population,total,label=abb)) + geom_point(size=3)
p2 <- p1+geom_point(color ="darkgreen")+geom_text(nudge_y = -0.9)+xlab("Populations size")+ylab("Total number of murders")+ggtitle("US Gun Murders in 2010") 
p2

p12 <- murders %>% ggplot(aes(population,total,label=state)) + geom_point(size=3) 
p22 <- p1+geom_point(color ="darkgreen")+geom_text(nudge_y =  -5)+xlab("Populations size")+ylab("Total number of murders")+ggtitle("US Gun Murders in 2010") 
p22

grid.arrange(p2, p22, ncol = 2)

#Exercise2 

df <- starwars %>% filter(species == "Human")
df

starwars %>% select(home_world = homeworld) %>% distinct()

starwars %>% summarise(height = mean(height, na.rm = TRUE))%>% group_by(species)
starwars %>% summarise(mass = mean(mass, na.rm = TRUE))


a2 <- select(group_by(species), height, mass)
a2
a3 <- summarise(a2,
                height = mean(height, na.rm = TRUE),
                mass = mean(mass, na.rm = TRUE)
)
a3

df3 <- starwars %>% count(species, sort = TRUE)
df3

ggplot(data = df3) + geom_bar(aes(x = n))


g<- a3 %>% ggplot(aes(height,mass)) + geom_point(size=3)
g1 <- g+geom_smooth(mapping = aes(x = height, y = mass),method = 'lm')
g1 # The visualization shows the more height the more budy mass of the character is important 

#Exercise 3

x <- rnorm(100)
y <- rnorm(200)
pl1 <- hist(x)
pl2 <- hist(y)

z <- t.test(x,y)
pl1










