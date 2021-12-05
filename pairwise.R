install.packages("rcompanion")
library(rcompanion)

pairwisePermutationTest(time ~ size, data = res)
pairwisePermutationTest(time ~ package, data = res, method = "bonf")
pairwisePermutationTest(time ~ computer, data = res, method = "bonf")
