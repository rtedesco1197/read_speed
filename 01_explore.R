# 3 methods
# read.csv (from base)
# read_csv (from readr/tidyverse)
# fread    (from data.table)

# slow... took forever
r1 <- read.csv("df.csv")

# it's really the question of which of the remaining 2 is faster?

# try reading in 20 times for each method
nsim <- 20

# read_csv
time2 <- rep(NA, nsim)
for (i in 1:nsim) {
  start <- Sys.time()
  r2 <- readr::read_csv("df.csv")
  time2[i] <- Sys.time() - start
}
hist(time2)
summary(time2)

# fread
time3 <- rep(NA, nsim)
for (i in 1:nsim) {
  start <- Sys.time()
  r3 <- data.table::fread("df.csv")
  time3[i] <- Sys.time() - start
}
hist(time3)
summary(time3)
