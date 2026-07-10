
save_processed_data_monthly <- function(monthly_data) {
  
  write_xlsx(
    x = monthly_data,
    path = here("processed-data", "processed_monthly_AE_PRA.xlsx")
  )
  
}