
create_three_nations_pra_workbook <- function(three_nations_data){

  workbook <- loadWorkbook(
    here(
      "..",
      "7. A&E Three Nations Comparison",
      "templates",
      "three_nations_base_sheets.xlsx"
    )
  )
    
    # --- Workbook styles ---
  
    header_style <- createStyle(halign = "center", textDecoration = "bold", wrapText = TRUE, valign = "top")
    
    highlight_style <- createStyle(fontColour = "black", bgFill = "#B0EB9F")
    
    date_style <- createStyle(numFmt = "mmm/yy")
  
    
    # --- Create performance comparisons ---
    
    three_nations_comparison_all <- three_nations_data %>%
      filter(
        DepartmentType == "All"
      ) %>%
      select(MonthEndingDate, LocationName, PercentageWithin4Hours) %>%
      pivot_wider(
        names_from = LocationName,
        values_from = PercentageWithin4Hours
      ) %>%
      mutate(`Scotland minus England` = `Scotland` - `England`,
             `Scotland minus Wales` = `Scotland` - `Wales`)
    
    
    three_nations_comparison_core <- three_nations_data %>%
      filter(
        DepartmentType %in% c("Type 1", "Major")
      ) %>%
      select(MonthEndingDate, LocationName, PercentageWithin4Hours) %>%
      pivot_wider(
        names_from = LocationName,
        values_from = PercentageWithin4Hours
      ) %>%
      mutate(`Scotland minus England` = `Scotland` - `England`,
             `Scotland minus Wales` = `Scotland` - `Wales`)

    
    
    # --- Add the performance comparison sheets to the workbook ---
    
    all_rows <- nrow(three_nations_comparison_all) + 1
    core_rows <- nrow(three_nations_comparison_core) + 1
    
    addWorksheet(workbook, "All Sites Comparison")
    addWorksheet(workbook, "Core Sites Comparison")
    
    writeData(workbook, "All Sites Comparison", three_nations_comparison_all, headerStyle = header_style)
    writeData(workbook, "Core Sites Comparison", three_nations_comparison_core, headerStyle = header_style)
    
    freezePane(workbook, "All Sites Comparison", firstRow = TRUE)
    freezePane(workbook, "Core Sites Comparison", firstRow = TRUE)
    
    addStyle(workbook, "All Sites Comparison", style = createStyle(numFmt = "#,##0.0"), 
             rows = 2:all_rows, cols = c(2:6), gridExpand = T)
    addStyle(workbook, "Core Sites Comparison", style = createStyle(numFmt = "#,##0.0"), 
             rows = 2:core_rows, cols = c(2:6), gridExpand = T)
    
    addStyle(workbook, "All Sites Comparison", style = date_style, 
             rows = 2:all_rows+1, cols = 1, gridExpand = TRUE)
    addStyle(workbook, "Core Sites Comparison", style = date_style, 
             rows = 2:core_rows+1, cols = 1, gridExpand = TRUE)
    
    setColWidths(workbook, "All Sites Comparison", cols = 1:ncol(three_nations_comparison_all), 
                 widths = c(10, 10, 10, 10, 10, 10))
    setColWidths(workbook, "Core Sites Comparison", cols = 1:ncol(three_nations_comparison_core), 
                 widths = c(10, 10, 10, 10, 10, 10))
    
    conditionalFormatting(workbook, "All Sites Comparison", cols=c(5,6), rows=2:all_rows, 
                          rule=">0", style = highlight_style)
    conditionalFormatting(workbook, "Core Sites Comparison", cols=c(5,6), rows=2:core_rows, 
                          rule=">0", style = highlight_style)

    
    # --- Add the core performance chart to the workbook ---
    
    addWorksheet(workbook, "Core Sites Performance Chart")

    insertImage(workbook, "Core Sites Performance Chart", 
                here("outputs", "pra-three-nations-core-chart.png"), 
                startRow = 5, 
                startCol = 3, 
                width = 12, 
                height = 9
                )
    
    
    # --- Save the workbook ---
    
    saveWorkbook(workbook,
                 file = here("outputs", "pra-three-nations-comparison.xlsx"), 
                 overwrite = TRUE
                 )

}