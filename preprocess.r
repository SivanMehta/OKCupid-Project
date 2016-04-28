library(stringr)
library(dplyr)
library(qdap)

print("preprocessing data...")

# load dataset
if(!file.exists("profiles.csv"))
{
    stop("profiles.csv does not exist, please unzip profiles.csv.zip")
}
profiles <- read.csv("profiles.csv")
print("Finished Step 1 / 7 - loading in .csv file")

# add number of demands
demands <- strsplit(as.character(profiles$essay9), "/. ")
demands <- strsplit(as.character(demands), "and")
demands <- strsplit(as.character(demands), ",")
profiles$n_demands <- sapply(demands, length)
print("Finished Step 2 / 7 - calculating number of demands")

# add number of traits from user
traits <- strsplit(as.character(profiles$essay0), "/. ")
traits <- strsplit(as.character(traits), "and")
traits <- strsplit(as.character(traits), ",")
profiles$n_traits <- sapply(traits, length)
print("Finished Step 3 / 7 - number of traits from user")

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
print("Finished Step 4 / 7 - word counts")

# change categorical variables to characters
profiles$body_type = as.character(profiles$body_type)
profiles$drinks = as.character(profiles$drinks)
profiles$diet = as.character(profiles$diet)
profiles$drugs <- as.character(profiles$drugs)
profiles$smokes = as.character(profiles$smokes)
profiles$status = as.character(profiles$status)
profiles$status = as.character(profiles$status)
profiles$sex = as.character(profiles$sex)
profiles <- subset(profiles, drugs != "" & smokes != "")
print("Finished Step 5 / 7 - factor conversion in characters")

# calculate polarities
sample <- profiles[sample(nrow(profiles), 2000), ]
sample$polarity <- polarity(sample$essay0)$all$polarity
print("Finished Step 6 / 7 - polarity")

# merge in locations
locations_under_30 <- read.csv("locations_under_30.csv")
sample <- merge(sample, locations_under_30, "location")

# write sample
write.csv(sample, "sample.csv")
print("Finished Step 7 / 7 - adding locations and writing sample")
print("done preprocessing data!")
