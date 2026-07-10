
get_values_three_nations <- function(monthly_data_scot, monthly_dates) {
  
  this_month_scotland <- monthly_data_scot %>%
    filter(MonthEndingDate == monthly_dates$date_this_month,
           DepartmentType == "Type 1")
  
  this_month_england <- read_excel(
    here("..",
         "7. A&E Three Nations Comparison",
         "processed-data",
         "processed_england_wales_AE.xlsx"),
    sheet = "England"
    ) %>%
    filter(MonthEndingDate == monthly_dates$date_this_month,
           DepartmentType == "Type 1")
  
  this_month_wales <- read_excel(
    here("..",
         "7. A&E Three Nations Comparison",
         "processed-data",
         "processed_england_wales_AE.xlsx"),
    sheet = "Wales"
    ) %>%
    filter(MonthEndingDate == monthly_dates$date_this_month,
           DepartmentType == "Major")
  
  list(
    
    perf4hr_scotland = this_month_scotland$PercentageWithin4HoursEpisode,
    perf4hr_england = this_month_england$PercentageWithin4Hours,
    perf4hr_wales = this_month_wales$PercentageWithin4Hours,
    
    perf4hr_diff_england = round(
      this_month_scotland$PercentageWithin4HoursEpisode -
        this_month_england$PercentageWithin4Hours,
      1
    ),
    
    perf4hr_diff_wales = round(
      this_month_scotland$PercentageWithin4HoursEpisode -
        this_month_wales$PercentageWithin4Hours,
      1
    )
    
  ) # End of list
  
}