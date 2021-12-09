# library(tidyverse)
# library(data.table)
# library(rio)
# 
# t1 <- system.time(read_csv("df.csv"))
# t2 <- system.time(read_csv("df2.csv"))
# t3 <- system.time(read_csv("df3.csv"))
# t4 <- system.time(read_csv("df4.csv"))
# t5 <- system.time(read_csv("df5.csv"))
# t6 <- system.time(read_csv("df6.csv"))
# t7 <- system.time(read_csv("df7.csv"))
# t8 <- system.time(read_csv("df8.csv"))
# t9 <- system.time(read_csv("df9.csv"))
# t10 <- system.time(read_csv("df10.csv"))
# 
# t_readr <- rbind(t(t1), t(t2), t(t3), t(t4), t(t5), t(t6), t(t7), t(t8), t(t9), t(t10))
# 
# 
# tt1 <- system.time(fread("df.csv"))
# tt2 <- system.time(fread("df2.csv"))
# tt3 <- system.time(fread("df3.csv"))
# tt4 <- system.time(fread("df4.csv"))
# tt5 <- system.time(fread("df5.csv"))
# tt6 <- system.time(fread("df6.csv"))
# tt7 <- system.time(fread("df7.csv"))
# tt8 <- system.time(fread("df8.csv"))
# tt9 <- system.time(fread("df9.csv"))
# tt10 <- system.time(fread("df10.csv"))
# 
# t_fread <- rbind(t(tt1), t(tt2), t(tt3), t(tt4), t(tt5), t(tt6), t(tt7), t(tt8), t(tt9), t(tt10))
# 
# ttt1 <- system.time(import("df.csv"))
# ttt2 <- system.time(import("df2.csv"))
# ttt3 <- system.time(import("df3.csv"))
# ttt4 <- system.time(import("df4.csv"))
# ttt5 <- system.time(import("df5.csv"))
# ttt6 <- system.time(import("df6.csv"))
# ttt7 <- system.time(import("df7.csv"))
# ttt8 <- system.time(import("df8.csv"))
# ttt9 <- system.time(import("df9.csv"))
# ttt10 <- system.time(import("df10.csv"))
# 
# t_import <- rbind(t(ttt1), t(ttt2), t(ttt3), t(ttt4), t(ttt5), t(ttt6), t(ttt7), t(ttt8), t(ttt9), t(ttt10))
# 
# dfs <- c("df", str_c("df", 2:10))
# sizes <- c() 
# for(i in 1:length(dfs)) {
#   sizes[i] <- file.size(str_c(dfs[i], ".csv"))
# }
# 
# dat <- as_tibble(rbind(t_readr, t_fread, t_import)) %>% 
#   mutate(meth = rep(c("readr", "fread", "import"), each = 10),
#          size = rep(sizes/1000000000, 3))
# dat %>% write_csv("add.csv")

dat <- read_csv("add.csv") %>% 
  mutate(meth = factor(meth))

dat %>% 
  ggplot(aes(size, elapsed, color = meth)) +
  geom_line()

dat %>% 
  ggplot(aes(size, elapsed, color = meth)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Size (GB)",
       y = "Time Elapsed (sec.)") +
  theme_bw()

anc <- aov(elapsed ~ meth + size, data = dat)
anc %>% 
  car::Anova(type = "III") %>% 
  broom::tidy()

anc %>% 
  pluck("residuals") %>% 
  shapiro.test() %>% 
  tidy()

car::leveneTest(elapsed ~ meth, data = dat) %>% 
  tidy()

library(multcomp)
phoc <- glht(anc, linfct = mcp(meth = "Tukey"))

phoc %>% 
  tidy()

