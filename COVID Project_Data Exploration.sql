Select *
From PortifolioProject..CovidDeaths
Where continent IS NOT NULL
Order by 3, 4

--Select *
--From PortifolioProject..CovidVaccinations
--Order by 3, 4

--Selecting relevant data for analysis

Select location, date, total_cases, new_cases, total_deaths, population
From PortifolioProject..CovidDeaths
Where continent IS NOT NULL
Order by 1,3

--Looking at the Total Cases vs Total Deaths
-- Showcase the probability of death post infection

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as FatalityRate
From PortifolioProject..CovidDeaths
Where location like '%States%'
and continent IS NOT NULL
Order by 1,3

-- Total Cases vs Population Analysis
-- Infection rate as % of population

Select location, date, population, total_cases,  (total_cases/population)*100 as InfectionRate
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Where continent IS NOT NULL
Order by 1,3

-- Show countries ranked by infection rate vs. population

Select location,population, MAX (total_cases) as HighestInfenctionCount, 
MAX((total_cases/population))*100 as InfectionRate
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Group by location, population
Order by InfectionRate DESC

-- Showcase Countries with the Highest Fatality Rate vs Population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Where continent IS NOT NULL
Group by location
Order by TotalDeathCount DESC

--BREAK DOWN DATA BY CONTINENT

-- Showing the continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Where continent IS NOT NULL
Group by  continent
Order by TotalDeathCount DESC

-- GLOBAL NUMBERS


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as FatalityRate
From PortifolioProject..CovidDeaths
--Where location like '%States%'
Where continent IS NOT NULL
--Group by date
Order by 1,2


