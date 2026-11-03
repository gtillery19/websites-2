library(tidyverse)

top_songs <- read_rds("clean_data.rds")

billboard_plot <- top_songs %>%
  ggplot(aes(x = week, y = avg_rank, color = artist, group = artist)) +
  geom_line(linewidth = 0.9) +
  geom_point(size = 1.2) +
  scale_y_reverse(breaks = 1:10) +
  facet_wrap(~ year, ncol = 2) +
  labs(
    title = "Top 10 Billboard Performance by Artist and Year",
    subtitle = "Average chart rank for the most active artists",
    x = "Week",
    y = "Chart Rank",
    color = "Artist"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold"),
    plot.subtitle = element_text(color = "grey40"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

ggsave("billboard_plot.png", plot = billboard_plot)
