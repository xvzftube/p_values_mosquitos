library(tidyverse)
set.seed(101)

# define number of iterations and put in a data frame
n <- 1e5
df <- as_tibble(list(iter = seq(1,n)))

# original data and statistic
beer <- c(27,20,21,26,27,31,24,21,20,19,23,24,28,19,24,29,18,20,17,31,20,25,28,21,27)
water <- c(21,22,15,12,21,16,19,15,22,24,19,23,13,22,20,24,18,20)
original_mean <- mean(beer) - mean(water)
get_random_difference <- function(i){
  beer_and_water <- sample(c(beer, water), replace = FALSE)
  random_beer_tag  <- beer_and_water[1:length(beer)]
  random_water_tag  <- beer_and_water[length(beer) + 1: length(water)]
  diff <- mean(random_beer_tag) - mean(random_water_tag)
  return(diff)
}

df_diff <- df %>% 
  add_column(diff = map_dbl(df$iter, get_random_difference)) 

  
# print some results
#print("t-test results")
#t.test(beer,water)
p_val <- mean(df_diff$diff >= original_mean)
print(paste0("Either we observed a data set that has a probability of ", p_val, " or beer made these subjects more tasty"))

df_diff %>% write_csv("./code/df_diff.csv")
