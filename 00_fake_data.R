library(tidyverse)

x <- matrix(nrow = 1000000, ncol = 100)
set.seed(100)
for(i in 1:ncol(x)) {
  x[, i] <- rnorm(1000000)
}

df <- as_tibble(x)

head(df)

# write_csv(df, "df.csv")


x2 <- matrix(nrow = 750000, ncol = 100)
set.seed(101)
for(i in 1:ncol(x2)) {
  x2[, i] <- rnorm(750000)
}

df2 <- as_tibble(x2)

head(df2)

write_csv(df2, "df2.csv")



x3 <- matrix(nrow = 1000000, ncol = 55)
set.seed(102)
for(i in 1:ncol(x3)) {
  x3[, i] <- rnorm(1000000)
}

df3 <- as_tibble(x3)

head(df3)

write_csv(df3, "df3.csv")


file.info("df.csv")[1] # 1.963204005 GB

file.info("df2.csv")[1] # 1.472402481 GB

file.info("df3.csv")[1] # 1.079761146 GB



