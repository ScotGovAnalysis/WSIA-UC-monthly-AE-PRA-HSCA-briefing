
missing_boards_message_monthly <- function(missing_boards_summary) {
  
  if (nrow(missing_boards_summary) == 0) {
    return("")
  }
  
  warnings <- apply(
    missing_boards_summary,
    1,
    function(x) {
      
      dates <- strsplit(x["DatesMissing"], ", ")[[1]]
      
      date_text <- collapse_dates(dates)
      
      month_text <- if (length(dates) == 1) {
        ""
      } else {
        "months"
      }
      
      month_text_2 <- if (length(dates) == 1) {
        "this month"
      } else {
        "these months"
      }
      
      paste0(
        "**Missing data for ",
        x["NHSBoardName"],
        ":** ",
        x["NHSBoardName"],
        " is missing for ",
        month_text,
        " ",
        date_text,
        ". For data in the last year up to the latest complete month (",
        x["MonthFrom"],
        " to ",
        x["MonthTo"],
        "), ",
        x["NHSBoardName"],
        " has accounted for ",
        x["PercentageScotlandAttendances_12m"],
        "% of national attendances. Performance within this period for ",
        x["NHSBoardName"],
        " has been ",
        x["PercentageWithin4HoursEpisode_12m"],
        "%, compared to ",
        x["PercentageWithin4HoursEpisode_12m_scot"],
        "% nationally. Please interpret figures for ",
        month_text_2,
        " and comparisons with previous months with caution."
      )
      
    }
  )
  
  paste(warnings, collapse = "\n\n")
  
}


# Helper function:
collapse_dates <- function(x) {
  
  if (length(x) == 1) {
    return(x)
  }
  
  if (length(x) == 2) {
    return(paste(x, collapse = " and "))
  }
  
  paste0(
    paste(head(x, -1), collapse = ", "),
    " and ",
    tail(x, 1)
  )
  
}