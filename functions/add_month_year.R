
add_month_year <- function(monthly_data) {
  
  monthly_data$MonthEndingDate <- as.Date(monthly_data$MonthEndingDate)
  
  monthly_data$Month <- month(
    monthly_data$MonthEndingDate,
    label = TRUE,
    abbr = FALSE
  )
  
  monthly_data$Year <- isoyear(monthly_data$MonthEndingDate)
  
  monthly_data
  
}