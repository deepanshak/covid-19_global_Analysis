# Covid-19_Global_Analysis

## Overview

This documentation provides a detailed explanation of the COVID-19 global Analysis project. The project aims to analyze and visualize COVID-19 data using SQL queries and Power BI, presenting key insights and trends related to the pandemic.


## Introduction

The COVID-19 Analysis project is designed to provide insights into the global impact of the COVID-19 pandemic. Leveraging SQL queries and Power BI, the project extracts, analyzes, and visualizes relevant data to present a comprehensive overview of the pandemic's progression.
The primary goals of this analysis are to:

- Explore the temporal and geographical patterns of COVID-19 cases.
- Identify trends in confirmed cases, deaths, and recoveries.
- Create an interactive Power BI dashboard for visualizing key metrics.

## Dataset Description

The project uses a COVID-19 dataset sourced as excel workbook.The dataset includes information such as date, confirmed cases, deaths, recovered cases, country-wise data and much more.

## Technologies Used

- SQL Server for EDA ,data storage and retrieval.
- Power BI Desktop for data visualization.
  

## Data Exploration

The exploratory data analysis (EDA) phase involved:

- Examining summary statistics and distribution of COVID-19 cases.
- Visualizing trends using line charts, bar graphs etc.

### SQL Queries

The `directory contains SQL queries used to extract relevant data for analysis. Sample queries include:
<pre>
  <code>
--select needed data 
select Location, date,total_cases, new_cases,total_deaths,population
from covid_project..CovidDeaths$
order by 1,2

-- total cases vs total death 
select Location, date,total_cases ,total_deaths,(total_deaths/total_cases)*100 as Death_Percentage 
from covid_project..CovidDeaths$
-- where location like '%India%'
order by 1,2

    
-- continents with highest death_count
select   continent, MAX(cast(total_deaths as int))  as TotalDeathCount
from covid_project..CovidDeaths$
where continent is not null
group by continent
order by TotalDeathCount desc
 
    
-- vaccinated population vs total population 
select dea.continent, dea .location, dea.date ,dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) Over (partition by dea.location order by location ,dea.date) 
as cummulative_people_vaccinated 
from covid_project..CovidVaccinations$ vac
join covid_project..CovidDeaths$ dea 
  on dea.location = vac.location
  and  dea.date= vac.date
where dea.continent is not  null 
order by 2,3 

  </code>
</pre>

## Power BI Visualization
### Dashboard Preview

Results and Findings
Key findings from the analysis include:

[Brief summary of important insights]
[Visualizations highlighting significant trends]
[Any patterns or anomalies observed]
Usage Instructions
