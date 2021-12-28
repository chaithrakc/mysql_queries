/*
Difficulty: Easy

https://www.hackerrank.com/challenges/average-population-of-each-continent/problem 

Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) 
and their respective average city populations (CITY.Population) rounded down to the nearest integer.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

*/
select country.continent, floor(avg(city.population))
from city inner join country on countrycode = code
group by country.continent;

/*
Asia 693038
Oceania 109189
Europe 175138
South America 147435
Africa 274439
*/