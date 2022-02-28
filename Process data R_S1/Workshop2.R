library(gridExtra)
library(dplyr)
library(ggplot2)

#1a) Using the variable 'Sepal.Length" create an histogram

hist(iris$Sepal.Length)

#1b) Draw the histogram for the variable "Sepal.Length" 

ggplot(iris)+geom_histogram(aes(x = Sepal.Length, y = ..density..), bins = 50) +
  geom_density(aes(Sepal.Length),col='red')

#1c) Draw a scatterplot of Sepal.Length and Sepal.Width 


p <- iris %>% ggplot() +geom_point(aes(x = Sepal.Length, y =Sepal.Width, col=Species, shape=Species), size = 3 )+
 xlab("Sepal Length") + ylab("Sepal Width") +
  ggtitle("based on species")  
p

#1d)Add a separate regression line for each group. 

p+geom_smooth(aes(x = Sepal.Length, y =Sepal.Width, col=Species),method = "lm")

#1e) Then overall a smooth line (method = "loess")

p+geom_smooth(aes(x = Sepal.Length, y =Sepal.Width),method = "loess")


#1f) Draw a separate scatter plot with a regression line, one for each level of the variable Species 

p +geom_smooth(aes(x = Sepal.Length, y =Sepal.Width, col=Species),method = "lm")+
  facet_wrap(~Species)

#Exercise2
#2a)From "mpg" dataset draw a scatter plot for `displ` (x-axis) and `hwy` (y-axis)

W <- mpg %>% ggplot() +geom_point(aes(x = displ, y =hwy), size = 3 )+
  xlab("displ") + ylab(" hwy") 
W

#2b) Modify the previous scatter plot in such a way that the colour depends on the class and the shape on the year

W1 <- mpg %>% ggplot() +geom_point(aes(x = displ, y =hwy, col=year), size = 3 )+
  xlab("displ") + ylab("hwy") +
  ggtitle("based on year")  
W1

#2c)display the same data conditionally on one categorical variable

W1+facet_wrap(~class)

#2d) Load the diamonds dataset. Draw a scatter plot of 'carat' ` (x-axis)  and 'price' (y-axis) 
d <- diamonds %>% ggplot() +geom_point(aes(x = carat, y =price, col=cut), size = 0.5 )+
  xlab("carat") + ylab("price") +
  ggtitle("based on cut")
d+geom_smooth(aes(x = carat, y =price),method = "lm")+facet_wrap(~color)

#Exercise3
#3a) Which variable (column) has the highest number of missing values
sapply(starwars, function(x) sum(is.na(x)))
# we can see that "birth_year" has the highest missing values
#3b) How many humans are contained in starwars dataset?
df <- starwars %>% filter(species == "Human") %>% group_by(gender)  %>% count()
df
#3c) From which homeworld do the most individuals (rows) come from
starwars  %>% group_by(homeworld) %>% count() %>% arrange(desc(n))
#We can see that "Naboo" is the most individual in homeworld


#3d) Create a barplot of the gender distribution of the starwars Universe, set the title
pl <- ggplot(data = starwars,aes(x = gender, fill = gender)) + geom_bar(aes(x = gender))+
  ggtitle("Gender distribution of the sw Universe")+
  scale_fill_manual(
    values = c("#00AFBB", "#E7B800"), 
    na.value = "#FC4E07"
  ) 
pl  

#3f) Draw the densities for the height variable of feminines and masculines only
#Solution1
df1 <- starwars %>% filter(gender=="feminine")
ggplot(data = df1 ,aes(height)) + geom_density(kernal = "gassuian")+
  ggtitle("distribution of feminine height")

dfm <- starwars %>% filter(gender=="masculine")
ggplot(data = dfm ,aes(height)) + geom_density(kernal = "gassuian")+
  ggtitle("distribution of masculine height")

#Solution2
starwars_na <- starwars %>% na.omit()
ggplot(starwars_na, aes(x=height)) + geom_density(aes(group=gender, color=gender))

#3g) Draw a segmented barplot for the variable 'sex'

ggplot(starwars_na)+ geom_bar(aes(x = sex,y = (..count..)/sum(..count..), fill = factor(hair_color)))





