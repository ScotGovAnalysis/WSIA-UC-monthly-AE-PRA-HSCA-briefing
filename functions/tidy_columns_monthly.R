
tidy_columns_monthly <- function(monthly_data) {
  
  monthly_data %>%
    filter(AttendanceCategory == "All") %>%
    select(
      -LocationCode,
      -AttendanceCategory
    ) %>%
    relocate(
      MonthEndingDate,
      Month,
      Year
    )
  
}
