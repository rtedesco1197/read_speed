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

mod <- lm(time ~ computer*size*package, data = res)
mod %>% 
  anova()

plot.design(res)
interaction.plot(res$size,res$package,res$time)
interaction.plot(res$size,res$computer,res$time)
interaction.plot(res$package,res$computer,res$time)

library(ggfortify)
autoplot(mod, which = 1:2, label = FALSE)
hist(mod$residuals)


# log transform

mod2 <- lm(log(time) ~ computer*size*package, data = res)
mod2 %>% 
  anova()

autoplot(mod2, which = 1:2, label = FALSE)

# power transformation
# boxcox
hist(mod3$residuals)

# bc <- MASS::boxcox(time ~ computer*size*package, data = res)
# bc$x[which.max(bc$y)]

car::powerTransform(res$time, family = "bcPower")

mod3 <- lm(time^(-0.2543644)  ~ computer*size*package, data = res)
mod3 %>% 
  anova()

autoplot(mod3, which = 1:2, label = FALSE)

# interaction plot
# library(sjPlot)
# plot_model(mod, type = "int")


library(asbio)

# permutation test

perm.fact.test <- function(Y,
                           X1,
                           X2,
                           X3 = NA,
                           perm = 100,
                           method = "a") {
  if (all(is.na(X3))) {
    init.model <- anova(lm(Y ~ X1 * X2))
  }
  if (all(!is.na(X3))) {
    init.model <- anova(lm(Y ~ X1 * X2 * X3))
  }
  
  
  r <- length((init.model)$"F value") - 1
  F.init <- init.model$"F value"[1:r]
  MS <- init.model$"Mean Sq"
  
  
  # (a)
  if (method == "a") {
    F.perm <- matrix(nrow = r, ncol = perm)
    if (all(is.na(X3))) {
      for (i in 1:perm) {
        Y.new <- sample(Y, replace = FALSE)
        F.perm[, i] <- anova(lm(Y.new ~ X1 * X2))$"F value"[1:r]
      }
    }
    
    if (all(!is.na(X3))) {
      for (i in 1:perm) {
        Y.new <- sample(Y, replace = FALSE)
        F.perm[, i] <- anova(lm(Y.new ~ X1 * X2 * X3))$"F value"[1:r]
      }
    }
  }
  
  
  # (b)
  if (method == "b") {
    MS.perm <- matrix(nrow = r + 1, ncol = perm)
    if (all(is.na(X3))) {
      for (i in 1:perm) {
        Y.new <- sample(Y, replace = FALSE)
        MS.perm[, i] <- anova(lm(Y.new ~ X1 * X2))$"Mean Sq"
      }
    }
    
    if (all(!is.na(X3))) {
      for (i in 1:perm) {
        Y.new <- sample(Y, replace = FALSE)
        MS.perm[, i] <- anova(lm(Y.new ~ X1 * X2 * X3))$"Mean Sq"
      }
    }
    
    F.perm <- matrix(nrow = r, ncol = perm)
    for (i in 1:perm) {
      F.perm[, i] <- MS.perm[, i][1:r] / MS.perm[, i][r + 1]
    }
  }
  
  p1 <- matrix(nrow = r, ncol = perm)
  for (i in 1:r) {
    p1[i, ] <- F.perm[i, ] >= F.init[i]
  }
  
  p2 <- apply(p1, 1, function(x) {
    length(x[x == TRUE])
  })
  
  p.val <- (p2 + 1) / perm
  p.val <- ifelse(p.val > 1, 1, p.val)
  
  if (all(is.na(X3))) {
    Table <-
      data.frame(
        Initial.F = init.model$"F value",
        Df = init.model$"Df",
        row.names = c("X1", "X2", "X1:X2", "Residual"),
        pval = c(p.val, NA)
      )
  }
  if (all(!is.na(X3))) {
    Table <-
      data.frame(
        Initial.F = init.model$"F value",
        Df = init.model$"Df",
        row.names = c(
          "X1",
          "X2",
          "X3",
          "X1:X2",
          "X1:X3",
          "X2:X3",
          "X1:X2:X3",
          "Residual"
        ),
        pval = c(p.val, NA)
      )
  }
  res <- list()
  res$Table <- Table
  res
}

perm.fact.test(Y = res$time,
               X1 = res$package,
               X2 = res$size,
               X3 = res$computer,
               perm = 10000)
