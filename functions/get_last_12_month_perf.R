
get_last_12_month_perf <- function(monthly_data) {
  
  last_12_months_all <- monthly_data %>%
    filter(DepartmentType == "All") %>%
    arrange(MonthEndingDate) %>%
    slice_tail(n = 12)
  
  last_12_months_type1 <- monthly_data %>%
    filter(DepartmentType == "Type 1") %>%
    arrange(MonthEndingDate) %>%
    slice_tail(n = 12)
  
  perf_all <- round(
    100 * sum(last_12_months_all$NumberWithin4HoursAll, na.rm = TRUE) /
      sum(last_12_months_all$NumberOfAttendancesAll, na.rm = TRUE),
    1
  )
  
  perf_type1 <- round(
    100 * sum(last_12_months_type1$NumberWithin4HoursAll, na.rm = TRUE) /
      sum(last_12_months_type1$NumberOfAttendancesAll, na.rm = TRUE),
    1
  )
  
  start_month <- min(last_12_months_all$MonthEndingDate)
  end_month <- max(last_12_months_all$MonthEndingDate)
  
  paste0(
    "Scotland's combined performance over the latest 12 months (",
    format(start_month, "%B %Y"),
    " to ",
    format(end_month, "%B %Y"),
    ") was ",
    perf_all,
    "% for All sites and ",
    perf_type1,
    "% for Core sites."
  )
  
}