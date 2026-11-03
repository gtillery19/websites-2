library(tidyverse)

top_songs <- billboard %>%
  mutate(year = lubridate::year(date.entered)) %>%
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  ) %>%
  mutate(week = parse_number(week)) %>%
  filter(
    artist %in% (
      billboard %>%
        count(artist, sort = TRUE) %>%
        slice_head(n = 6) %>%
        pull(artist)
    ),
    rank <= 10
  ) %>%
  group_by(artist, year, week) %>%
  summarise(avg_rank = mean(rank), .groups = "drop")

write_rds(top_songs, file = "clean_data.rds")
