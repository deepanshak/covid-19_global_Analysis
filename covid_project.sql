select * 
from covid_project..CovidDeaths$
where continent is not null
order by 3,4

select* from covid_project..CovidVaccinations$
order by 3,4

--select needed data 
select Location, date,total_cases, new_cases,total_deaths,population
from covid_project..CovidDeaths$
order by 1,2


-- total cases vs total death 
select Location, date,total_cases ,total_deaths,(total_deaths/total_cases)*100 as Death_Percentage 
from covid_project..CovidDeaths$
--where location like '%India%'
order by 1,2

--total cases vs total deaths 
select Location, date,total_cases ,population,(total_cases/population)*100 as Totalcases_Percentage 
from covid_project..CovidDeaths$
where location like '%India%'
order by 1,2


-- countries with highest infection rate compared to population 
select Location, population, MAX(total_cases)  as HighestInfectionCount, Max(( total_cases/population))*100 as PercentagePopulationInfected
from covid_project..CovidDeaths$
--where location like '%India%'
group by location,population  
order by PercentagePopulationInfected desc



--  countries with Highest death Count per population
select Location,  MAX(cast(total_deaths as int))  as TotalDeathCount
from covid_project..CovidDeaths$
--where location like '%India%'
where continent is not null
group by location
order by TotalDeathCount desc

--  continents with highest death_count
select   continent, MAX(cast(total_deaths as int))  as TotalDeathCount
from covid_project..CovidDeaths$
where continent is not null
group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS 
select  SUM(new_cases) as total_cases , SUM(cast(new_deaths as int)) as total_deaths , SUM(cast(total_deaths as int))/SUM(new_cases)*100 as Death_Percentage 
from covid_project..CovidDeaths$
where continent is not null
order by 1,2


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


--USE CTE
with popvsvac (continent,Location,date,population,new_vaccinations, cummuative_people_vaccinated) as
(select dea.continent, dea .location, dea.date ,dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) Over (partition by dea.Location order by location ,dea.date) 
as cummulative_people_vaccinated 
from covid_project..CovidVaccinations$ vac
join covid_project..CovidDeaths$ dea 
  on dea.location = vac.location
  and  dea.date= vac.date
where dea.continent is not  null 
)
select *,(cummuative_people_vaccinated/population)*100
from popvsvac



--TEMP Table
DROP table if exists #percent_population_vaccinated
create table #percent_population_vaccinated
(
continent nvarchar(225),
Location nvarchar(225),
Date datetime,
Population numeric,
New_vaccinations numeric,
cummulative_people_vaccinated numeric )
 
 insert into #percent_population_vaccinated
 select dea.continent, dea .location, dea.date ,dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) Over (partition by dea.location order by location ,dea.date) 
as cummulative_people_vaccinated 
from covid_project..CovidVaccinations$ vac
join covid_project..CovidDeaths$ dea 
  on dea.location = vac.location
  and  dea.date= vac.date
select *,(cummulative_people_vaccinated /population)*100
from #percent_population_vaccinated


--creating views
create view percent_population_vaccinated as
select dea.continent, dea .location, dea.date ,dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) Over (partition by dea.location order by location ,dea.date) 
as cummulative_people_vaccinated 
from covid_project..CovidVaccinations$ vac
join covid_project..CovidDeaths$ dea 
  on dea.location = vac.location
  and  dea.date= vac.date
where dea.continent is not null 

select * from percent_population_vaccinated
































