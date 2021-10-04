-- a total analysis final using joins
select  A.LOCATION, A.POPULATION, A.total_cases, a.total_deaths, round(((B.total_vaccination_per_hundred/100)*a.population),2) as total_vaccine_given,
B.total_vaccination_per_hundred, round((A.total_cases/A.POPULATION)*100,2) percent_of_cases_per_population,
round((a.total_deaths/A.total_cases)*100,2) as percent_death_per_cases
from (select location, population, Max(total_cases) as total_cases, Max(total_deaths) as total_deaths
from covid_deaths
group by location, population) A
join
(Select entity, max(TOTAL_VACCINATIONS_PER_HUNDRED) as total_vaccination_per_hundred
from NATION_COVID_VACCINATION
group by entity) B
on A.location = B.entity
where a.population is not null
and total_cases is not null
order by a.population desc;

-- a total analysis final for continent 
select  A.LOCATION, A.POPULATION, A.total_cases, a.total_deaths, round(((B.total_vaccination_per_hundred/100)*a.population),2) as total_vaccine_given,
 B.total_vaccination_per_hundred,
round((A.total_cases/A.POPULATION)*100,2) percent_of_cases_per_population, round((a.total_deaths/A.total_cases)*100,2) as percent_death_per_cases
from (select location, population, Max(total_cases) as total_cases, Max(total_deaths) as total_deaths
from covid_deaths
where continent is null
group by location, population) A
join
(Select entity, max(TOTAL_VACCINATIONS_PER_HUNDRED) as total_vaccination_per_hundred
from NATION_COVID_VACCINATION
group by entity) B
on A.location = B.entity
where a.population is not null
and total_cases is not null
order by a.population desc;

-- final analysis for countries
select  A.LOCATION, A.POPULATION, A.total_cases, a.total_deaths, round(((B.total_vaccination_per_hundred/100)*a.population),2) as total_vaccine_given,
 B.total_vaccination_per_hundred,
round((A.total_cases/A.POPULATION)*100,2) percent_of_cases_per_population, round((a.total_deaths/A.total_cases)*100,2) as percent_death_per_cases
from (select location, population, Max(total_cases) as total_cases, Max(total_deaths) as total_deaths
from covid_deaths
where continent is not null
group by location, population) A
join
(Select entity, max(TOTAL_VACCINATIONS_PER_HUNDRED) as total_vaccination_per_hundred
from NATION_COVID_VACCINATION
group by entity) B
on A.location = B.entity
where a.population is not null
and total_cases is not null
order by a.population desc;

-- max total cases and max total deaths per continent, world and international 
select location, population, Max(total_cases) as total_cases, Max(total_deaths) as total_deaths
from covid_deaths
where continent is null
group by location, population
order by total_cases desc;

-- max total cases and max total deaths per country
select location, population, Max(total_cases) as total_cases, Max(total_deaths) as total_deaths
from covid_deaths
where continent is not null
and TOTAL_CASES is not null
and TOTAL_DEATHS is not null
group by location, population
order by total_cases desc;

-- data not available/repeated 
select location, population, Max(total_cases) as total_cases, Max(total_deaths) as total_deaths
from covid_deaths
where continent is not null
and TOTAL_CASES is  null
and TOTAL_DEATHS is  null
group by location, population
order by total_cases desc;

-- max total vaccination per 100 per continent and world
Select entity, max(TOTAL_VACCINATIONS_PER_HUNDRED) as total_vaccination_per_hundred
from NATION_COVID_VACCINATION
where entity in ('North America', 'Europe', 'Oceania', 'European Union', 'Asia', 'Africa', 'South America', 'World') 
group by entity
order by total_vaccination_per_hundred desc;

-- max total vaccination per 100 per country
Select entity, max(TOTAL_VACCINATIONS_PER_HUNDRED) as total_vaccination_per_hundred
from NATION_COVID_VACCINATION
where entity not in ('North America', 'Europe', 'Oceania', 'European Union', 'Asia', 'Africa', 'South America', 'World') 
group by entity
order by total_vaccination_per_hundred desc;

