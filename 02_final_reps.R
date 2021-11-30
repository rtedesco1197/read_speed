library(tidyverse)
library(data.table)
library(rio)

df <- crossing(comp = c("rob", "quang", "third"), 
         size = c("low", "mid", "high"), 
         method = c("import", "read_csv", "fread"))



# get high

nrep <- 20

high_fread <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- fread("df.csv")
  high_fread[i] <- Sys.time() - start
}

high_import <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- import("df.csv")
  high_import[i] <- Sys.time() - start
}

high_readr <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- read_csv("df.csv")
  high_readr[i] <- Sys.time() - start
}

# get mid

mid_fread <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- fread("df3.csv")
  mid_fread[i] <- Sys.time() - start
}


mid_import <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- import("df3.csv")
  mid_import[i] <- Sys.time() - start
}

mid_readr <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- read_csv("df3.csv")
  mid_readr[i] <- Sys.time() - start
}

# get low

low_fread <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- fread("df2.csv")
  low_fread[i] <- Sys.time() - start
}


low_import <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- import("df2.csv")
  low_import[i] <- Sys.time() - start
}

low_readr <- rep(NA, nrep)
for(i in 1:nrep) {
  start <- Sys.time()
  temp <- read_csv("df2.csv")
  low_readr[i] <- Sys.time() - start
}

