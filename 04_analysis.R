library(tidyverse)

res <- bind_rows(read_csv("res_quang.csv"),
                 read_csv("res_rob.csv"),
                 read_csv("res_lance.csv")) %>% 
  mutate(across(where(is_character), factor))

res %>% count(computer)


res %>% 
  ggplot(aes(time, package)) +
  geom_boxplot() +
  facet_grid(~ size)

library(mosaic)

favstats(time ~ package + computer + size, data = res)

mod <- lm(sqrt(time) ~ computer*size*package, data = res)
mod %>% 
  anova()

# interaction plot

library(sjPlot)

plot_model(mod, type = "int")


plot.design(res)
interaction.plot(res$size,res$package,res$time)
interaction.plot(res$size,res$computer,res$time)
interaction.plot(res$package,res$computer,res$time)

library(ggfortify)
autoplot(mod, which = 1:2, label = FALSE)
hist(mod$residuals)

