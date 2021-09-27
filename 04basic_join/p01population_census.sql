/*
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

The CITY table is described as follows:
+-------------+--------------+
|    Field    |     Type     |
+-------------+--------------+
| ID          | NUMBER       |
| NAME        | VARCHAR2(17) |
| COUNTRYCODE | VARCHAR2(3)  |
| DISTRICT    | VARCHAR2(20) |
| POPULATION  | NUMBER       |
+-------------+--------------+

COUNTRY tables are described as follows:
+-----------------+--------------+
|      Field      |     Type     |
+-----------------+--------------+
| CODE            | VARCHAR2(3)  |
| NAME            | VARCHAR2(44) |
| CONTINENT       | VARCHAR2(13) |
| REGION          | VARCHAR2(25) |
| SURFACE AREA    | NUMBER       |
| INDEPYEAR       | VARCHAR2(5)  |
| POPULATION      | NUMBER       |
| LIFE EXPECTANCY | VARCHAR2(4)  |
| GNP             | NUMBER       |
| GNPOLD          | VARCHAR2(9)  |
| LOCAL NAME      | VARCHAR2(44) |
| GOVERNMENT FORM | VARCHAR2(44) |
| HEAD OF STATE   | VARCHAR2(32) |
| CAPITAL         | VARCHAR2(4)  |
| CODE2           | VARCHAR2(2)  |
+-----------------+--------------+
*/

select sum(city.population)
from city, country
where city.countrycode = country.code
and country.continent = 'Asia';