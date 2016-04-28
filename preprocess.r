library(stringr)
library(dplyr)
library(qdap)

# load dataset
profiles <- read.csv("profiles.csv")
print("Loaded profiles.csv")

# add alcohol word counts
essays <- select(profiles, starts_with("essay"))
essays <- apply(essays, MARGIN=1, FUN=paste, collapse=" ")
essays <- str_replace_all(essays, "\n", " ")
essays <- str_replace_all(essays, "<br />", " ")
profiles$wine_count <- str_count(essays, "wine")
profiles$beer_count <- str_count(essays, "beer")
profiles$drink      <- str_count(essays, "drink")
profiles$alcohol    <- profiles$wine_count + profiles$beer_count + profiles$drink
print("made alcohol word counts")

# calculate polarities
sample <- profiles[sample(nrow(profiles), 2000), ]
sample$polarity <- polarity(sample$essay0)$all$polarity
print("made polarity calculation")

# write sample
write.csv(sample, "sample.csv")
print("wrote final file")