---
title: "CEMA_Epi_Task"
author: "Jackline Lgat"
date: "2025-04-26"
output: html_document

# --- Load Required Libraries
library(dplyr)
library(ggplot2)
library(readr)

# --- Load the Dataset
library(haven)
ILI<- read.csv("C:\\Users\\ELITEBOOK\\Downloads\\ILI.csv")
View(ILI)
head(ILI) #viewing data in brief
names(ILI)

# --- Calculate Mean ILI Percentage Per County Per Year
library(dplyr)

mean_ILI <- ILI %>%
  group_by(county, year) %>%
  summarise(mean_ILI_percentage = mean(ili_percentage, na.rm = TRUE)) %>%
  arrange(desc(mean_ILI_percentage))
print(mean_ILI)

## --- Plot Smoothed Weekly ILI Trends
library(ggplot2)

ggplot(data, aes(x = epi_week, y = ili_percentage, color = county)) +
  geom_smooth(se = FALSE, method = "loess") +
  facet_wrap(~ year) +
  labs(title = "Smoothed ILI Trend by County",
       x = "Epidemiological Week",
       y = "ILI Percentage") +
  theme_minimal()

# --- Calculate Incidence Rates Per 100,000 Population
incidence_rates <- ILI %>%
  filter(county %in% c("Nairobi", "Mombasa", "Kisumu")) %>%
  mutate(ili_cases = (ili_percentage/100) * population) %>%
  group_by(county, year) %>%
  summarize(
    total_cases = sum(ili_cases),
    total_population = sum(population),
    incidence_rate = (total_cases / total_population) * 100000
  ) %>%
  arrange(county, year)

#--- View the results
print(incidence_rates)

#---Plot Incidence Rates
library(ggplot2)
ggplot(incidence_rates, aes(x = county, y = incidence_rate, fill = factor(year))) +
  geom_col(position = "dodge") +
  labs(
    title = "ILI Incidence Rates per 100,000 Population",
    x = "County", 
    y = "Cases per 100,000",
    fill = "Year"
  ) +
  theme_minimal()

library(dplyr)

# Create binary 'high_ili' variable (e.g., >5% is "high")
ili_binary <- ILI %>%
  filter(county %in% c("Nairobi", "Mombasa", "Kisumu")) %>%
  mutate(high_ili = ifelse(ili_percentage > 5, "High", "Low"))

# Make contingency table
table_data <- table(ili_binary$high_ili, ili_binary$county)
print(table_data)

chi_test <- chisq.test(table_data)
print(chi_test)

library(ggplot2)

# Recreate  binary dataset
ili_binary <- ILI %>%
  filter(county %in% c("Nairobi", "Mombasa", "Kisumu")) %>%
  mutate(high_ili = ifelse(ili_percentage > 5, "High", "Low"))

#--- Plot High vs Low ILI Weeks by County
ggplot(ili_binary, aes(x = county, fill = high_ili)) +
  geom_bar(position = "fill") + 
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Proportion of High/Low ILI Weeks by County",
    subtitle = "Chi-square test: p = 0.855 (no significant difference)",
    x = "County",
    y = "Proportion of Weeks",
    fill = "ILI Level"
  ) +
  theme_minimal()
library(ggplot2)

#--- Plot High vs Low ILI Weeks by County
ggplot(ili_binary, aes(x = county, fill = high_ili)) +
  geom_bar(position = "dodge") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "High vs Low ILI Weeks by County",
    subtitle = "Chi-square test: p = 0.855 (no significant difference)",
    x = "County",
    y = "Proportion of Weeks",
    fill = "ILI Level"
  ) +
  theme_minimal()