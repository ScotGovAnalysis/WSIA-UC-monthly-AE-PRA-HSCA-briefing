
get_five_lowest_sites_monthly <- function(monthly_data_sites) {
  
  latest_month <- monthly_dates$date_this_month
  
  lowest_sites <- monthly_data_sites %>%
    filter(MonthEndingDate == latest_month,
           DepartmentType == "Type 1") %>%
    arrange(PercentageWithin4HoursAll) %>%
    slice_head(n = 5) %>%
    transmute(
      site_text = paste0(
        str_remove(LocationName, " - Type 1$"),
        " (",
        round(PercentageWithin4HoursAll, 1),
        "%)"
      )
    ) %>%
    pull(site_text)
  
  paste0(
    paste(head(lowest_sites, -1), collapse = ", "),
    " and ",
    tail(lowest_sites, 1)
  )
  
}