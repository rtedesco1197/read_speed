res <- bind_rows(read_csv("res_quang.csv"),
                 read_csv("res_rob.csv"),
                 read_csv("res_lance.csv"))

res %>% count(computer)
