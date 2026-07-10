
# ============================================================
# Script name:   1_pra_data_processing.R
# Purpose:       Processing monthly A&E PRA data files
# Author:        Sophie Quinn
# Date created:  2026-07-06
# Last updated:  2026-07-09 by SQ
# ============================================================

# Inputs:  Files for monthly PRA (all xlsx)
# Outputs: Data in environment to produce outputs
# Depends on: Functions

# ---- Monthly PRA ----

file_name_monthly <- list.files(path = here("inputs"), pattern = "^(.*)-ae-monthly-attendance-and-waiting-times.xlsx$") %>%
  str_remove("\\$") %>%
  str_remove("\\~") %>%
  unique()


monthly_data <- list(
  
  Scotland = combine_sheets_monthly(here("inputs", file_name_monthly),
                                    c("Scotland", "Scotland Type 1 and 3")),
  
  Boards = combine_sheets_monthly(here("inputs", file_name_monthly),
                                  c("NHSBoards", "NHSBoards Type 1 and 3")),
  
  Sites = read_excel(here("inputs", file_name_monthly), sheet = "Hospitals")
  
)


# Adding month and year:

monthly_data <- lapply(monthly_data, add_month_year)


# Remove and reorder columns:

monthly_data <- lapply(monthly_data, tidy_columns_monthly)


# Save processed data:

save_processed_data_monthly(monthly_data)
