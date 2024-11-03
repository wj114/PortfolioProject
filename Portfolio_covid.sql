SELECT continent				#location, date, total_cases, new_cases, total_deaths
FROM Portfolio_Project.coviddeaths
where continent is not null and continent <> '';

#total cases vs total deaths
#filter by country
#shows likelihood of dying if you contract covid in your country 

SELECT location, date, total_cases, total_deaths, round((total_deaths *100 /total_cases),3) as death_percentage
FROM Portfolio_Project.coviddeaths
where location ='Malaysia';

# Break things dowm by continent
SELECT continent, sum(total_deaths) as Total_death_count
FROM Portfolio_Project.coviddeaths
where continent is not null and continent <> ''
group by continent
order by Total_death_count desc;

#checking on the higest cases on each country
SELECT location, max(total_cases) as HighestInfection_Count
FROM Portfolio_Project.coviddeaths
where continent is not null
group by location 
order by HighestInfection_Count desc

