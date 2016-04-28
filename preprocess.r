library(stringr)
library(dplyr)
library(qdap)

# load dataset
if(!file.exists("profiles.csv"))
{
    stop("profiles.csv does not exist, please unzip profiles.csv.zip")
}
profiles <- read.csv("profiles.csv")

# add number of demands
demands <- strsplit(as.character(profiles$essay9), "/. ")
demands <- strsplit(as.character(demands), "and")
demands <- strsplit(as.character(demands), ",")
profiles$n_demands <- sapply(demands, length)

# add number of traits from user
traits <- strsplit(as.character(profiles$essay0), "/. ")
traits <- strsplit(as.character(traits), "and")
traits <- strsplit(as.character(traits), ",")
profiles$n_traits <- sapply(traits, length)

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

# calculate polarities
sample <- profiles[sample(nrow(profiles), 2000), ]
sample$polarity <- polarity(sample$essay0)$all$polarity

# write sample
write.csv(sample, "sample.csv")
