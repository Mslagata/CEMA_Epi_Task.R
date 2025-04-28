# CEMA - Epidemiological Analysis Task

Author: Jackline Lagat  
Date: April 26, 2025

## Overview
This project analyzes Influenza-Like Illness (ILI) data across counties and years. It calculates mean ILI percentages, incidence rates per 100,000 population, conducts chi-square tests, and generates visualizations using R.

## Project Structure
- `CEMA_Epi_Task.R` — Main R script
- `data/` — Folder for datasets  `ILI.csv`
- `onplots/` — Folder for saved plots 

## How to Run
1. Open `CEMA_Epi_Task.R` in RStudio.
2. Install required libraries:
   ```r
   install.packages(c("dplyr", "ggplot2", "readr", "haven", "scales"))
