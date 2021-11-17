x <- matrix(nrow = 1000000, ncol = 100)
set.seed(100)
for(i in 1:ncol(x)) {
  x[, i] <- rnorm(1000000)
}

df <- tibble::as_tibble(x)

head(df)

# write_csv(df, "df.csv")
