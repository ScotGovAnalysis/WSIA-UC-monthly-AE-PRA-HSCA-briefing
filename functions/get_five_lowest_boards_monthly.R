
get_five_lowest_boards_monthly <- function(monthly_data_boards) {
  
  latest_month <- monthly_dates$date_this_month
  
  lowest_boards <- monthly_data_boards %>%
    filter(MonthEndingDate == latest_month) %>%
    arrange(PercentageWithin4HoursAll) %>%
    slice_head(n = 5) %>%
    transmute(
      site_text = paste0(
        LocationName,
        " (",
        round(PercentageWithin4HoursAll, 1),
        "%)"
      )
    ) %>%
    pull(site_text)
  
  paste0(
    paste(head(lowest_boards, -1), collapse = ", "),
    " and ",
    tail(lowest_boards, 1)
  )
  
}