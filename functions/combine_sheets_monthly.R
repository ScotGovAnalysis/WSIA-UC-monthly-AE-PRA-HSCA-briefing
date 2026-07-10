
combine_sheets_monthly <- function(file_path, sheets) {
  
  bind_rows(
    lapply(
      sheets,
      \(sheet) read_excel(file_path, sheet = sheet)
    )
  ) %>%
    arrange(
      MonthEndingDate,
      NHSBoardName,
      DepartmentType
    )
  
}
