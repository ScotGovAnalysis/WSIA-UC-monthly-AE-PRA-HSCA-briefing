
create_three_nations_pra_chart <- function(three_nations_data) {
  
  three_nations_core <- three_nations_data %>%
    filter(
      DepartmentType %in% c("Type 1", "Major"),
      MonthEndingDate >= as.Date("2010-10-01")
      ) %>%
  mutate(
    MonthEndingDate = as.Date(MonthEndingDate)
  )
  
  
  # -- Chart set up --
  
  max_date <- max(three_nations_core$MonthEndingDate)
  
  three_nations_core_labels <- three_nations_core %>%
    group_by(LocationName) %>%
    slice_max(MonthEndingDate, n = 1) %>%
    ungroup() %>%
    mutate(
      Label = paste0(
        format(MonthEndingDate, "%b-%y"),
        "\n",
        round(PercentageWithin4Hours, 1),
        "%"
      )
    )
  
  
  # -- Three nations comparison chart (Core sites) --
  
  chart_three_nations_core <- 
    ggplot(
      three_nations_core,
    aes(
      x = MonthEndingDate,
      y = PercentageWithin4Hours,
      colour = LocationName
    )
  ) +
    geom_line(linewidth = 1) +
    geom_text_repel(
      data = three_nations_core_labels,
      aes(label = Label),
      nudge_x = 100,
      size = 2.5,
      show.legend = FALSE
    ) +
    geom_vline(
      xintercept = as.Date("2015-05-01"),
      colour = "grey40"
    ) +
    annotate(
      "text",
      x = as.Date("2016-05-01"),
      y = 100,
      label = "6 EA Launch",
      size = 2
    ) +
    scale_colour_manual(
      values = c(
        "Scotland" = "dodgerblue4",
        "England" = "red",
        "Wales" = "goldenrod"
      )
    ) +
    scale_y_continuous(
      limits = c(45, 100),
      labels = \(x) paste0(x, "%")
    ) +
    scale_x_date(
      date_breaks = "3 months",
      date_labels = "%b %y",
      limits = c(
        as.Date("2010-10-01"),
        max_date + 90
      )
    ) +
    labs(
      title = "Core A&E sites performance by month: Scotland, England, and Wales",
      x = "Month",
      y = "4 hour performance (%)"
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 90),
      legend.title = element_blank(),
      legend.position = "bottom"
    )
  
  
  ggsave(
    here(
      "outputs",
      "pra-three-nations-core-chart.png"
    ),
    plot = chart_three_nations_core,
    width = 20,
    height = 15,
    units = "cm"
  )
  
}