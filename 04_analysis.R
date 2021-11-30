res <- bind_rows(read_csv("res_quang.csv"),
                 read_csv("res_rob.csv"),
                 read_csv("res_lance.csv"))

res %>% count(computer)


res %>% 
  ggplot(aes(time, package)) +
  geom_boxplot() +
  facet_grid(~ size)


mod <- lm(time ~ computer*size*package, data = res)
mod %>% 
  anova()

library(mosaic)

favstats(time ~ package + computer + size, data = res)
