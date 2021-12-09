install.packages("rcompanion")
library(rcompanion)

pairwisePermutationTest(time ~ size, data = res, method = "fdr")
pairwisePermutationTest(time ~ package, data = res, method = "fdr")
pairwisePermutationTest(time ~ computer, data = res, method = "fdr")
