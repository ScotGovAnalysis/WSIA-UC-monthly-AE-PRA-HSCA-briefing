
# ============================================================
# Script name:   monthly_ae_pra_hsca_briefing.R
# Purpose:       Process for producing HSCA monthly A&E PRA briefing
# Author:        Sophie Quinn
# Date created:  2026-07-06
# Last updated:  2026-07-09 by SQ
# ============================================================

# Inputs: Pre-release access data from PHS (monthly)
# Outputs: HSCA A&E briefing for monthly PRA data
# Depends on: All files within the scripts/functions/inputs/templates folders


# 0 ---- Set up ----

source(here::here("scripts", "0_setup.R"))


# 1 ---- PRA data processing ----

source(here::here("scripts", "1_pra_data_processing.R"))


# 2 ---- HSCA briefing outputs ----

source(here::here("scripts", "2_briefing_outputs.R"))
