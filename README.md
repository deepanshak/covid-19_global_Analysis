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
  Firstly the data from excel workbook is imported to SQL server then using various sql queries the EDA was carried out relevant stats were calculated then thes queries were imported to power bi and visualizations were made. 
### SQL Queries

The `directory contains SQL queries used to extract relevant data for analysis.  here are some sample queries the complete analysis can be found in the above document:
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


<img width="382" alt="Screenshot 2024-01-04 172116" src="https://github.com/deepanshak/covid-19_global_Analysis/assets/139687677/a1746279-b8f8-45da-a47a-558d1bdeae78">







<img width="380" alt="Screenshot 2024-01-04 172202" src="https://github.com/deepanshak/covid-19_global_Analysis/assets/139687677/3a0c36da-ee0c-4c0d-870c-5754403e13ae">






<img width="194" alt="Screenshot 2024-01-04 172400" src="https://github.com/deepanshak/covid-19_global_Analysis/assets/139687677/166837ba-8ef2-4bed-b976-e036488cd834">



## Power BI Visualization
### Dashboard Preview

<img width="640" alt="covid_dashboard" src="https://github.com/deepanshak/covid-19_global_Analysis/assets/139687677/8fa7d870-2173-48b4-8387-bdde2496755a">




## Results and Findings
Key findings from the analysis include:
- Total Recorded cases of covid-19 marked upto 151M
-  ﻿At 151399480, World had the highest Sum of HighestInfectionCount and was 15,13,99,47,900.00% higher than Micronesia (country), which had the lowest Sum of HighestInfectionCount at 1.
-  ﻿Cumulative vaccination count trended up, resulting in a 1,875.41% increase between December 2020 and April 2021.
-  The cumulative death record globally was 3M
