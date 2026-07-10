
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
    perf4hr_this_month = this_month$PercentageWithin4HoursEpisode,
    perf4hr_last_month = last_month$PercentageWithin4HoursEpisode,
    perf4hr_last_year = last_year$PercentageWithin4HoursEpisode,
    
    perf4hr_diff_last_month = round(
      this_month$PercentageWithin4HoursEpisode -
        last_month$PercentageWithin4HoursEpisode,
      1
    ),
    
    perf4hr_diff_last_year = round(
      this_month$PercentageWithin4HoursEpisode -
        last_year$PercentageWithin4HoursEpisode,
      1
    ),
    
    
    # Attendances
    attendances_this_month =
      this_month$NumberOfAttendancesEpisode,
    
    attendances_last_month =
      last_month$NumberOfAttendancesEpisode,
    
    attendances_last_year =
      last_year$NumberOfAttendancesEpisode,
    
    attendances_diff_last_month = round(
      100 * (
        this_month$NumberOfAttendancesEpisode -
          last_month$NumberOfAttendancesEpisode
      ) /
        last_month$NumberOfAttendancesEpisode,
      1
    ),
    
    attendances_diff_last_year = round(
      100 * (
        this_month$NumberOfAttendancesEpisode -
          last_year$NumberOfAttendancesEpisode
      ) /
        last_year$NumberOfAttendancesEpisode,
      1
    ),
    
    
    # Over 12-hour waits
    waits12hr_this_month =
      this_month$NumberOver12HoursEpisode,
    
    waits12hr_last_month =
      last_month$NumberOver12HoursEpisode,
    
    waits12hr_last_year =
      last_year$NumberOver12HoursEpisode,
    
    
    waits12hr_diff_last_month = round(
      100 * (
        this_month$NumberOver12HoursEpisode -
          last_month$NumberOver12HoursEpisode
      ) /
        last_month$NumberOver12HoursEpisode,
      1
    ),
    
    waits12hr_diff_last_year = round(
      100 * (
        this_month$NumberOver12HoursEpisode -
          last_year$NumberOver12HoursEpisode
      ) /
        last_year$NumberOver12HoursEpisode,
      1
    )
    
  ) # End of list
  
}