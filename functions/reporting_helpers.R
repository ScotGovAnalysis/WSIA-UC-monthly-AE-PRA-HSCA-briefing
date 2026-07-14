
up_down <- function(x) {
  case_when(
    x > 0 ~ "up",
    x < 0 ~ "down",
    TRUE ~ "unchanged"
  )
}

higher_lower <- function(x) {
  case_when(
    x > 0 ~ "higher than",
    x < 0 ~ "lower than",
    TRUE ~ "no change from"
  )
}

increase_decrease <- function(x) {
  case_when(
    x > 0 ~ "an increase",
    x < 0 ~ "a decrease",
    TRUE ~ "no change"
  )
}

above_below <- function(x) {
  case_when(
    x > 0 ~ "above",
    x < 0 ~ "below",
    TRUE ~ "same as"
  )
}