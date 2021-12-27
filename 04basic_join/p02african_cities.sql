/*
Difficulty: Easy

https://www.hackerrank.com/challenges/african-cities/problem

Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

select city.name
from city inner join country on city.countrycode = country.code
where country.continent = 'Africa';

/*
output
Qina 
Warraq al-Arab 
Kempton Park 
Alberton 
Klerksdorp 
Uitenhage 
Brakpan 
Libreville
*/