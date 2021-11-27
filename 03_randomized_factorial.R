
# 3 methods
# import   (from rio)
# read_csv (from readr/tidyverse)
# fread    (from data.table)

# try reading in 20 times for each method
set.seed(123)
nsim <- 20
randomize <- sample(1:180)
times <- rep(NA,180)

#In total, there are 3 packages * 3 file sizes * 20 replicates = 180 obs
#randomize by doing sample(1:180) and measure in corresponding order.
#Ex, 1:20 refers to 20 replicates where package=1 and filesize=1.

for(i in 1:length(randomize)) {
  print(i)
  #if sample<=60, use rio import
  if (randomize[i] < 61) {
    
    #if sample <=20, use filesize 1 (0.5GsB)
    if (randomize[i] < 21) {
      start <- Sys.time()
      r1 <- rio::import("df0.5.csv")
    }
    #if sample <=40, use filesize 2 (1.2GB)
    else if (randomize[i] < 41) {
      start <- Sys.time()
      r1 <- rio::import("df1.2.csv")
    }
    #else, use filesize 3 (2.0GB)
    else {
      start <- Sys.time()
      r1 <- rio::import("df2.0.csv")
    }
    #record time of rio import.
    times[randomize[i]] <- Sys.time() - start
  }
  
  #same logic repeated for other two packages below.
  else{
    if (randomize[i] < 121) {
      # read_csv
      if (randomize[i] < 81) {
        start <- Sys.time()
        r2 <- rio::import("df0.5.csv")
      }
      else if (randomize[i] < 101) {
        start <- Sys.time()
        r2 <- rio::import("df1.2.csv")
      }
      else {
        start <- Sys.time()
        r2 <- rio::import("df2.0.csv")
      }
      times[randomize[i]] <- Sys.time() - start
    }
    else{
      # fread
      if (randomize[i] < 141) {
        start <- Sys.time()
        r3 <- rio::import("df0.5.csv")
      }
      else if (randomize[i] < 161) {
        start <- Sys.time()
        r3 <- rio::import("df1.2.csv")
      }
      else {
        start <- Sys.time()
        r3 <- rio::import("df2.0.csv")
      }
      times[randomize[i]] <- Sys.time() - start
    }
  }
}

timesCombined <- matrix(data=times, nrow=20, byrow=F)
timesCombined <- data.frame(timesCombined)
names(timesCombined) <- c("rioSmall","rioMed","rioLarge",
                          "readrSmall","readrMed","readrLarge",
                          "freadSmall","freadMed","freadLarge")
boxplot(timesCombined)
summary(timesCombined)