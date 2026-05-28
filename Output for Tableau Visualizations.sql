/*

Queries used for Tableau Project

*/


-- 1.


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as FatalityRate
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Where continent IS NOT NULL
--Group by date
Order by 1,2



-- 2.

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Where continent IS NULL
and location not in ('World', 'European Union', 'International')
Group by  location
Order by TotalDeathCount DESC



-- 3.

Select location,population, MAX (total_cases) as HighestInfenctionCount, 
MAX((total_cases/population))*100 as PercentPopulationInfected
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Group by location, population
Order by PercentPopulationInfected DESC



-- 4.

Select location,population,date, MAX (total_cases) as HighestInfenctionCount, 
MAX((total_cases/population))*100 as PercentPopulationInfected
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Group by location, population, date
Order by PercentPopulationInfected DESC
