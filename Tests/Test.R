library(testthat)

# Test if DonorSearch Aristotle updates correctly
constituents <- read.csv(file = "../Data/DonorSearch Aristotle.csv")
sample_constituents <- constituents[constituents$Estimated.Capacity <= 1000000, ]
sample_constituents <- sample_constituents[sample(nrow(sample_constituents), 100), ]
update <- function(df) {
  df$Aristotle.Score <- df$Aristotle.Score+rnorm(nrow(df))
  df$Aristotle.Score[df$Aristotle.Score > 100] <- 100
  df$Aristotle.Score[df$Aristotle.Score <= 0] <- 1
  df$Size <- 1/log(df$Estimated.Capacity + 1)
  df
}
test_that("matrix",{
  expect_false(
    isTRUE(
      all.equal(
        sample_constituents, 
        update(sample_constituents)
      )
    )
  )
})
