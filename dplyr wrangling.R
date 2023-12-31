#------------------ Section 1: Filter ------------------------#
library(tidyverse)
library(palmerpenguins)
library(lterdatasampler)

# Look for an exact match: ##

penguins_biscoe <- penguins %>% filter(island == "biscoe")
penguins_biscoe

penguins_2007 <- penguins %>% filter(year == 2007)
penguins_2007

adelie_torgersen <- penguins %>% filter(species == "Adelie", island == "Torgersen")
# also: adelie_torgersen <- penguins %>% filter(species == "Adelie" & island == "Torgersen")

#create a subset that only contains gentoo penguins observed in 2008
gentoo_2008 <- penguins %>% filter(species == "Gentoo", year == "2008")
gentoo_2008

#gentoo_adelie <- penguins %>% filter(species == "Gentoo" & year == "adelie"). This would return zero results because we are asking for it to find that has both gentoo and adelie in the species column

gentoo_adelie <- penguins %>% filter(species == "Gentoo" | species == "adelie")
gentoo_adelie

#create a subset that contains obv. where the island is DREAM OR the year is 2009
dream_2009 <- penguins %>% filter(island == "Dream" | year == "2009")
dream_2009

#make a ggplot chart of water temperature vs crab size
temp_size_crab_chart <- ggplot(data = pie_crab, aes(x = water_temp, y = size)) + geom_point()
temp_size_crab_chart

#keeps observations for sites NIB, ZI, DB, JC
#we can use %in% operator to ask: does the value in our column match ANY of the values IN this vector?

pie_sites <- pie_crab %>% filter(site %in% c("NIB", "ZI", "DB", "JC"))
unique(pie_sites$site)


sites <- c("CC", "BB", "PIE")

pie_sites_2 <- pie_crab %>% filter(site %in% sites)
pie_sites_2

#create a subset using the %in% operator that includes sites PIE, ZI, NIB, BB, CC

pie_sites_3 <- pie_crab %>% filter(site %in% c("PIE", "ZI", "NIB", "BB", "CC"))

# excluding filter statements
# != (is this not equal to that value?)

exclude_zi <- pie_crab %>% filter(site != "ZI")

#excluding sites BB, CC, PIE

exclude_bb_cc_pie <- pie_crab %>% filter(!site %in% c("BB", "CC", "PIE"))

#Create a subset from pie_crab that only contains obvs. from NIB, CC, and ZI for crabs with carapace size exceeding 13

cara_13 <- pie_crab %>%  filter(!site %in% c("NIB", "CC", "PIE") & size > 13)
cara_13


# ------------------ Selecting columns -----------------#
# Selected individual columns by names separate them by a oclumn
crabs_subset <- pie_crab %>% select(latitude, size, water_temp)


#select a range of columns using:
crabs_subset_2 <- pie_crab %>% select(site:air_temp)

# select a range and an individual column
crabs_subset3 <- pie_crab %>%  select(date:water_temp, name)
pie_crab %>% select(name, water_temp, size)


#-----------------Mutate------------------#
#use dplyr::mutate() to add or update a column, while keeping all existing columns

crabs_cm <- pie_crab %>%
  mutate(size_cm = size /10)

#what happens if I use mutate to add a new column containing the mean of the size column?
crabs_mean <- pie_crab %>%
  mutate(mean_size = mean(size, na.rm = TRUE))
crabs_mean

crabs_awesome <- pie_crab %>%
  mutate(name = "Molly is awesome")
crabs_awesome

#reminder: group_by + summarize
mean_size_by_site <- pie_crab %>%
  group_by(site) %>%
  summarize(mean_size = mean(size, na.rm = TRUE),
            sd_size = sd(size, na.rm = TRUE))
mean_size_by_site


#what about a group_nby then mutate
group_mutate <- pie_crab %>%
  group_by(site) %>%
  mutate(mean_size = mean(size, na.rm = TRUE))

# what if i want to create a new column in pie_crab that contains "giant" if the size is greater than 35 or "not giant" if the size is less than or equal to 35

#use dplyr::case_when() to write if-else statements more easily
crabs_bin <- pie_crab %>%
  mutate(size_binned = case_when(
    size > 20 ~ "giant",
    size <= 20 ~ "not giant"
  ))


sites_binned <- pie_crab %>%
  mutate(region = case_when(
    site %in% c("ZI", "CC", "PIE") ~ "Low",
    site %in% c("BB", "NIB") ~ "Middle",
    TRUE ~ "High" # or .default = "High"
  ))

