
missing_boards_summary_monthly <- function(monthly_data_boards,
                                          monthly_data_scotland,
                                          missing_boards) {
  
  latest_year <- max(monthly_data_scotland$Year)
  
  latest_complete_date <- max(
    setdiff(
      monthly_data_scotland$MonthEndingDate,
      missing_boards$MonthEndingDate
    )
  )
  
  start_date <- monthly_data_scotland %>%
    filter(MonthEndingDate <= latest_complete_date) %>%
    distinct(MonthEndingDate) %>%
    arrange(MonthEndingDate) %>%
    slice_tail(n = 12) %>%
    summarise(min_date = min(MonthEndingDate)) %>%
    pull(min_date)
  
  
  scotland_summary <- monthly_data_scotland %>%
    filter(
      MonthEndingDate >= start_date,
      MonthEndingDate <= latest_complete_date
    ) %>%
    summarise(
      NumberOfAttendancesEpisode_12m =
        sum(NumberOfAttendancesEpisode, na.rm = TRUE),
      
      PercentageWithin4HoursEpisode_12m =
        round(
          100 * sum(NumberWithin4HoursEpisode, na.rm = TRUE) /
            sum(NumberOfAttendancesEpisode, na.rm = TRUE),
          1
        )
    )
  
  boards_summary <- monthly_data_boards %>%
    filter(
      MonthEndingDate >= start_date,
      MonthEndingDate <= latest_complete_date
    ) %>%
    group_by(NHSBoardName) %>%
    summarise(
      NumberOfAttendancesEpisode_12m =
        sum(NumberOfAttendancesEpisode, na.rm = TRUE),
      
      PercentageWithin4HoursEpisode_12m =
        round(
          100 * sum(NumberWithin4HoursEpisode, na.rm = TRUE) /
            sum(NumberOfAttendancesEpisode, na.rm = TRUE),
          1
        ),
      
      .groups = "drop"
    ) %>%
    mutate(
      PercentageScotlandAttendances_12m =
        round(
          100 * NumberOfAttendancesEpisode_12m /
            scotland_summary$NumberOfAttendancesEpisode_12m,
          1
        )
    )
  
  missing_boards_summary <- missing_boards %>%
    group_by(MissingBoards) %>%
    summarise(
      DatesMissing = paste(
        format(MonthEndingDate, "%B %Y"),
        collapse = ", "
      ),
      .groups = "drop"
    ) %>%
    rename(
      NHSBoardName = MissingBoards
    )
  
  missing_boards_summary %>%
    left_join(
      boards_summary,
      by = "NHSBoardName"
    ) %>%
    select(
      NHSBoardName,
      DatesMissing,
      PercentageScotlandAttendances_12m,
      PercentageWithin4HoursEpisode_12m
    ) %>%
    mutate(
      PercentageWithin4HoursEpisode_12m_scot =
        scotland_summary$PercentageWithin4HoursEpisode_12m,
      MonthFrom = format(as.Date(start_date), "%B %Y"),
      MonthTo = format(as.Date(latest_complete_date), "%B %Y")
    )
  
}
