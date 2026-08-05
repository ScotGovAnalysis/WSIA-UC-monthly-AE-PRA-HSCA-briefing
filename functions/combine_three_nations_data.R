
combine_three_nations_data <- function(scot_data){
  
  scot_data <- scot_data %>%
    filter(DepartmentType %in% c("All","Type 1")) %>%
    transmute(
      MonthEndingDate,
      Month,
      Year,
      LocationName,
      DepartmentType,
      NumberOfAttendances = NumberOfAttendancesAll,
      NumberWithin4Hours = NumberWithin4HoursAll,
      NumberOver4Hours = NumberOver4HoursAll,
      PercentageWithin4Hours = PercentageWithin4HoursAll
    )
  
  
  eng_data <- readxl::read_xlsx(
    here(
      "..",
      "7. A&E Three Nations Comparison",
      "processed-data",
      "processed_england_wales_AE.xlsx"
    ),
    sheet = "England"
  ) %>%
    filter(DepartmentType %in% c("All","Type 1"))
  
  
  wales_data <- readxl::read_xlsx(
    here(
      "..",
      "7. A&E Three Nations Comparison",
      "processed-data",
      "processed_england_wales_AE.xlsx"
    ),
    sheet = "Wales"
  ) %>%
    filter(DepartmentType %in% c("All", "Major")) %>%
    select(-((ncol(. )-3):ncol(.)))
  
  
  bind_rows(
    scot_data,
    eng_data,
    wales_data
  ) %>%
    arrange(MonthEndingDate)
  
  
}