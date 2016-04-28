library(stringr)
library(dplyr)
library(qdap)

# load dataset
profiles <- read.csv("profiles.csv")
print("Loaded profiles.csv")

# add number of demands
demands <- strsplit(as.character(profiles$essay9), "/. ")
demands <- strsplit(as.character(demands), "and")
demands <- strsplit(as.character(demands), ",")
profiles$n_demands <- sapply(demands, length)
print("Calculated number of demands")

# add number of traits from user
traits <- strsplit(as.character(profiles$essay0), "/. ")
traits <- strsplit(as.character(traits), "and")
traits <- strsplit(as.character(traits), ",")
profiles$n_traits <- sapply(traits, length)
print("Calculated number of traits")

# add word counts
essays <- select(profiles, starts_with("essay"))
essays <- apply(essays, MARGIN=1, FUN=paste, collapse=" ")
essays <- str_replace_all(essays, "\n", " ")
essays <- str_replace_all(essays, "<br />", " ")
profiles$wine_count <- str_count(essays, "wine")
profiles$beer_count <- str_count(essays, "beer")
profiles$drink      <- str_count(essays, "drink")
profiles$alcohol    <- profiles$wine_count + profiles$beer_count + profiles$drink
profiles$wc <-  sapply(strsplit(as.character(profiles$essay0), " "), length)

print("Caclulated word counts")

# calculate polarities
sample <- profiles[sample(nrow(profiles), 2000), ]
sample$polarity <- polarity(sample$essay0)$all$polarity
print("Caclulated polarities")

# write sample
write.csv(sample, "sample.csv")
print("Wrote final file")