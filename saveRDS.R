votes_cast_voting_age_2018_numeric <- read_xlsx("Raw-data/votes_cast_voting_age_2018.xlsx", col_types = "numeric", skip = 2) %>%
  clean_names() %>%
  select(!c(state_abbreviation, state_name, congressional_district))

votes_cast_voting_age_2018_character <- read_xlsx("Raw-data/votes_cast_voting_age_2018.xlsx", col_types = "text", skip = 2) %>%
  clean_names() %>%
  select(c(state_abbreviation, state_name, congressional_district))

votes_cast_voting_age_2018 <- cbind(votes_cast_voting_age_2018_character, votes_cast_voting_age_2018_numeric) %>%
  drop_na() %>%
  select(-line_number) %>%
  rename("Votes Cast" = votes_cast_for_congressional_representative_for_the_november_6_2018_election1, 
         "Number of Eligible Citizens (Estimate)" = citizen_voting_age_population2,
         "Margin of Error for Eligible Citizens" = x7,
         "Voting Rate" = voting_rate3,
         "Margin of Error for Voting Rate" = x9)


saveRDS(object = votes_cast_voting_age_2018_numeric, file = "milestone_6/votes_cast_voting_age_2018_numeric.RDS")
saveRDS(object = votes_cast_voting_age_2018_character, file = "milestone_6/votes_cast_voting_age_2018_character.RDS")
saveRDS(object = votes_cast_voting_age_2018, file = "milestone_6/votes_cast_voting_age_2018.RDS")

