
create_4hr_performance_chart_monthly <- function(monthly_data) {
  
  latest_year <- max(monthly_data$Year)
  
  years_to_plot <- sort(unique(monthly_data$Year))
  years_to_plot <- tail(years_to_plot, 5)
  
  colour_values <- setNames(
    c("#C6DBEF",
      "#6BAED6",
      "#3182BD",
      "#08519C",
      "#E69F00"
      )[seq_along(years_to_plot)],
    years_to_plot
    )
  
  
  month_lookup <- tibble(
    EquivalentMonthThisYear = seq(
      from = as.Date(paste0(latest_year, "-01-01")),
      by = "1 month",
      length.out = 12
    )
  ) %>%
    mutate(
      Month = factor(
        month.name,
        levels = month.name,
        ordered = TRUE
      ),
      EquivalentMonthThisYear =
        ceiling_date(EquivalentMonthThisYear, "month") - days(1)
    ) %>%
    select(
      Month,
      EquivalentMonthThisYear
    )
  
  
  graph_data <- monthly_data %>%
    filter(
      Year %in% years_to_plot,
      DepartmentType == "All"
      ) %>%
    left_join(
      month_lookup,
      by = "Month"
      )
  
  chart <- graph_data %>%
    ggplot(
      aes(
        x = EquivalentMonthThisYear,
        y = PercentageWithin4HoursEpisode,
        colour = factor(Year)
      )
    ) +
    geom_line(linewidth = 1) +
    scale_colour_manual(values = colour_values) +
    scale_x_date(
      breaks = month_lookup$EquivalentMonthThisYear,
      date_labels = "%b %Y",
      expand = c(0.01, 0.01)
      ) +
    scale_y_continuous(
      limits = c(55, 85),
      breaks = seq(55, 85, 5)
    ) +
    labs(
      title = "NHS Scotland: Monthly (All sites) ED 4-hour performance by calendar year",
      x = "Month ending date",
      y = "4-hour performance (%)"
    ) +
    theme_minimal() +
    theme(
      text = element_text(size = 9),
      legend.position = "bottom",
      legend.title = element_blank(),
      axis.text.x = element_text(
        angle = 45,
        hjust = 1,
        vjust = 1
      )
    ) +
    removeGrid(x = TRUE, y = FALSE)
  
  ggsave(
    here(
      "outputs",
      "monthly-4hr-performance-chart.png"
    ),
    plot = chart,
    width = 8,
    height = 4.5,
    dpi = 300
  )
  
}