/*
Difficulty: Easy

https://www.hackerrank.com/challenges/weather-observation-station-3/problem 

Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

The STATION table is described as follows:
+--------+--------------+
| Field  |     Type     |
+--------+--------------+
| ID     | NUMBER       |
| CITY   | VARCHAR2(21) |
| STATE  | VARCHAR2(2)  |
| LAT_N  | NUMBER       |
| LONG_W | NUMBER       |
+--------+--------------+
where LAT_N is the northern latitude and LONG_W is the western longitude.

*/

select distinct(city) 
from station 
where mod(id,2)=0;  -- modulus operator in oracle

-- MS SQL Server 
SELECT DISTINCT(city)
FROM station
WHERE id % 2 = 0;