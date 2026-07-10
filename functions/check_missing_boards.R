
check_missing_boards <- function(data) {
  
  date_column <- names(data)[1]
  
  expected_boards <- sort(unique(data$NHSBoardName))
  
  dates <- sort(unique(data[[date_column]]))
  
  map_dfr(dates, \(d) {
    
    present_boards <- data %>%
      filter(.data[[date_column]] == d) %>%
      distinct(NHSBoardName) %>%
      pull(NHSBoardName)
    
    missing_boards <- setdiff(expected_boards, present_boards)
    
    if (length(missing_boards) == 0) {
      return(NULL)
    }
    
    tibble(
      !!date_column := rep(d, length(missing_boards)),
      MissingBoards = missing_boards
    )
    
  })
  
}
