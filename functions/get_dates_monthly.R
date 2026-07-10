
get_dates_monthly <- function(monthly_data) {
  
  this_month <- max(monthly_data$MonthEndingDate, na.rm = TRUE)
  
  this_month_name_year <- monthly_data %>%
    filter(MonthEndingDate == this_month) %>%
    distinct(Month, Year)
  
  get_first_tuesday <- function(date) {
    
    month_start <- floor_date(date, "month")
    
    month_start + ((3 - wday(month_start) + 7) %% 7)
    
    }
  
  list(
    date_this_month = this_month,
    date_last_month = floor_date(this_month, "month") - 1,
    date_last_year = monthly_data %>%
      filter(
        Month == this_month_name_year$Month,
        Year == this_month_name_year$Year - 1
      ) %>%
      pull(MonthEndingDate) %>%
      max(),
    date_publication = get_first_tuesday(this_month %m+% months(2)),
    date_next_update = get_first_tuesday(this_month %m+% months(3))
  )
  
}
