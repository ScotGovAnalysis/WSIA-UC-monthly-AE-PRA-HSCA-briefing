
# ============================================================
# Script name:   2_briefing_outputs.R
# Purpose:       Outputs for HSCA briefing (monthly A&E PRA)
# Author:        Sophie Quinn
# Date created:  2026-07-06
# Last updated:  2026-07-27 by KH
# ============================================================

# Inputs: Data in environment from data processing
# Outputs: Briefing outputs
# Depends on: Functions

# ---- Variables for briefing ----

monthly_dates <- get_dates_monthly(monthly_data$Scotland)

monthly_values_all <- get_values_monthly(
  monthly_data$Scotland,
  monthly_dates,
  "All"
)

monthly_values_type1 <- get_values_monthly(
  monthly_data$Scotland,
  monthly_dates,
  "Type 1"
)

last_12_month_perf <- get_last_12_month_perf(
  monthly_data$Scotland
)

create_4hr_performance_chart_monthly(
  monthly_data$Scotland
)

five_lowest_boards <- get_five_lowest_boards_monthly(
  monthly_data$Boards
)

five_lowest_sites <- get_five_lowest_sites_monthly(
  monthly_data$Sites
)

three_nations_values <- get_values_three_nations(
  monthly_data$Scotland,
  monthly_dates
)


# ---- Check for missing boards ----

missing_boards <- check_missing_boards(
  monthly_data$Boards
)

if (nrow(missing_boards) > 0) {
  
  missing_boards_summary <- missing_boards_summary_monthly(
    monthly_data$Boards,
    monthly_data$Scotland,
    missing_boards
  )
  
  missing_boards_message <- missing_boards_message_monthly(
    missing_boards_summary
  )
  
} else {
  
  missing_boards_summary <- tibble()
  
  missing_boards_message <- ""
  
}



# ---- Monthly briefing markdown ----

rmarkdown::render(input = here("scripts", "HSCA_briefing_monthly_AE.Rmd"),
                  output_file = here(
                    "outputs", 
                    paste0("HSCA Briefing - Monthly AE Update - ",format(monthly_dates$date_publication, "%d %B %Y"))
                    )
                  )



# ---- A&E FMQ monthly outputs markdown ----

rmarkdown::render(input = here("scripts", "AE_FMQ_monthly.Rmd"),
                  output_file = here(
                    "outputs", 
                    paste0("AE FMQ Monthly Update - ",format(monthly_dates$date_this_month, "%B %Y"))
                  )
)


# ---- A&E SCANCE monthly outputs markdown ----

rmarkdown::render(input = here("scripts", "AE_SCANCE_monthly.Rmd"),
                  output_file = here(
                    "outputs", 
                    paste0("AE SCANCE Monthly Update - ",format(monthly_dates$date_this_month, "%B %Y"))
                  )
)


# ---- Three nations comparison ----

three_nations_data <- combine_three_nations_data(
  monthly_data$Scotland
)

create_three_nations_pra_chart(three_nations_data)

create_three_nations_pra_workbook(three_nations_data)
                  