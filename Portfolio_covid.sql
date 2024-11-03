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
order by HighestInfection_Count desc;


#Global numbers
select date, sum(new_cases) as total_cases, sum(new_deaths) as total_death, round(sum(new_deaths)*100/sum(new_cases),3) as total_death_percentage
FROM Portfolio_Project.coviddeaths
where continent is not null
group by date;


#Total number of case, deaths and percentage
select sum(new_cases) as total_cases, sum(new_deaths) as total_death, round(sum(new_deaths)*100/sum(new_cases),3) as total_death_percentage
FROM Portfolio_Project.coviddeaths
where continent is not null;
#group by date


#Looking at total polulation vs vaccinations

select d.continent, d.location, d.date, v.population, v.new_vaccinations,
	sum(new_vaccinations) over (partition by d.location order by d.location, d.date) as Cumulative_people_vaccinated
from Portfolio_Project.coviddeaths d
join  Portfolio_Project.covidvaccination v
	on d.location= v.location and d.date=v.date
where d.continent is not null;

# use CTE

with cte as 
(select d.continent, d.location, d.date, v.population, v.new_vaccinations,
	sum(new_vaccinations) over (partition by d.location order by d.location, d.date) as Cumulative_people_vaccinated
from Portfolio_Project.coviddeaths d
join  Portfolio_Project.covidvaccination v
	on d.location= v.location and d.date=v.date
where d.continent is not null)

select *,
	Cumulative_people_vaccinated *100/population as percentatge_vaccination
from cte;

#create view
create view percentatge_vaccination as
select d.continent, d.location, d.date, v.population, v.new_vaccinations,
	sum(new_vaccinations) over (partition by d.location order by d.location, d.date) as Cumulative_people_vaccinated
from Portfolio_Project.coviddeaths d
join  Portfolio_Project.covidvaccination v
	on d.location= v.location and d.date=v.date
where d.continent is not null;


select *
from percentatge_vaccination