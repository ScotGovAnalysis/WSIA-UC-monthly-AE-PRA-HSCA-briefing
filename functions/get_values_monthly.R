
get_values_monthly <- function(monthly_data, monthly_dates, dep_type) {
  
  this_month <- monthly_data %>%
    filter(MonthEndingDate == monthly_dates$date_this_month,
           DepartmentType == dep_type)
  
  last_month <- monthly_data %>%
    filter(MonthEndingDate == monthly_dates$date_last_month,
           DepartmentType == dep_type)
  
  last_year <- monthly_data %>%
    filter(MonthEndingDate == monthly_dates$date_last_year,
           DepartmentType == dep_type)
  
  list(
    
    # 4-hour performance
    perf4hr_this_month = this_month$PercentageWithin4HoursAll,
    perf4hr_last_month = last_month$PercentageWithin4HoursAll,
    perf4hr_last_year = last_year$PercentageWithin4HoursAll,
    
    perf4hr_diff_last_month = round(
      this_month$PercentageWithin4HoursAll -
        last_month$PercentageWithin4HoursAll,
      1
    ),
    
    perf4hr_diff_last_year = round(
      this_month$PercentageWithin4HoursAll -
        last_year$PercentageWithin4HoursAll,
      1
    ),
    
    
    # Attendances
    attendances_this_month =
      this_month$NumberOfAttendancesAll,
    
    attendances_last_month =
      last_month$NumberOfAttendancesAll,
    
    attendances_last_year =
      last_year$NumberOfAttendancesAll,
    
    attendances_diff_last_month = round(
      100 * (
        this_month$NumberOfAttendancesAll -
          last_month$NumberOfAttendancesAll
      ) /
        last_month$NumberOfAttendancesAll,
      1
    ),
    
    attendances_diff_last_year = round(
      100 * (
        this_month$NumberOfAttendancesAll -
          last_year$NumberOfAttendancesAll
      ) /
        last_year$NumberOfAttendancesAll,
      1
    ),
    
    
    # Over 12-hour waits
    waits12hr_this_month =
      this_month$NumberOver12HoursAll,
    
    waits12hr_last_month =
      last_month$NumberOver12HoursAll,
    
    waits12hr_last_year =
      last_year$NumberOver12HoursAll,
    
    
    waits12hr_diff_last_month = round(
      100 * (
        this_month$NumberOver12HoursAll -
          last_month$NumberOver12HoursAll
      ) /
        last_month$NumberOver12HoursAll,
      1
    ),
    
    waits12hr_diff_last_year = round(
      100 * (
        this_month$NumberOver12HoursAll -
          last_year$NumberOver12HoursAll
      ) /
        last_year$NumberOver12HoursAll,
      1
    )
    
  ) # End of list
  
}