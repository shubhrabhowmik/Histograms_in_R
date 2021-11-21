# Histograms in ggplot2

# load heights data
library(tidyverse)
library(dslabs)
data("heights")

# define p
p = heights %>%
  filter(sex == "Male") %>%
  ggplot(aes(x = height))

# basic histograms
p + geom_histogram()  # plot-1
p + geom_histogram(binwidth = 1)  # plot-2

# histogram with blue fill, black outline, labels and title
p + geom_histogram(binwidth = 1, fill = 'blue', col='black')+
  xlab("Male heights in inches")+
  ggtitle("Histogram")     # plot-3

# Smooth density plots in ggplot2
p + geom_density()    # plot-4
p + geom_density(fill = "blue")  # plot-5

# Quantile-quantile plots in ggplot2
# basic QQ-plot
p = heights %>% filter(sex == "Male") %>%
  ggplot(aes(sample = height))     
p + geom_qq()  # Plot-6

# QQ-plot against a normal distribution with same mean/sd as data
params = heights %>%
  filter(sex == "Male") %>%
  summarise(mean = mean(height), sd = sd(height))

p + geom_qq(dparams = params)+
  geom_abline()   # plot-7

# QQ-plot of scaled data against the standard normal distribution 
heights %>%
  ggplot(aes(sample=scale(height)))+
  geom_qq()+
  geom_abline()  # plot-8

# Grids of plots with the gridExtra Package
# define plots p1, p2, p3
p = heights %>% filter(sex=="Male") %>% ggplot(aes(x=height))
p1 = p + geom_histogram(binwidth = 1, fill = "blue", col = "black")
p2 = p + geom_histogram(binwidth = 2, fill = "blue", col = "black")
p3 = p + geom_histogram(binwidth = 3, fill = "blue", col = "black")

# arrange plots next to each other in 1 row, 3 columns
install.packages("gridExtra")
library(gridExtra)
grid.arrange(p1, p2, p3, ncol=3) # plot-9
