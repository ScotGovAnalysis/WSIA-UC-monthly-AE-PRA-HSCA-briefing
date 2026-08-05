
# ============================================================
# Script name:   0_setup.R
# Purpose:       Set up for HSCA briefing processes
# Author:        Sophie Quinn
# Date created:  2026-07-06
# Last updated:  2026-07-07 by SQ
# ============================================================

# Inputs:  NA
# Outputs: NA
# Depends on: NA

# 1 ---- Load packages ----

library(here)
library(dplyr)
library(tidyverse)
library(readxl)
library(writexl)
library(lubridate)
library(rmarkdown)
library(knitr)
library(scales)
library(ggplot2)
library(ggExtra)
library(flextable)
library(ggrepel)
library(openxlsx)


# 2 ---- Load functions ----

walk(list.files(here("functions"), pattern = "\\.R$", full.names = TRUE), 
     source)


# ---- END OF SCRIPT ---- #