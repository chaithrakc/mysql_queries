/*
Difficulty: Easy

https://www.hackerrank.com/challenges/weather-observation-station-8/problem

Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

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
where upper(substr(city,-1,1)) in ('A','E','I','O','U')
and upper(substr(city,1,1)) in ('A','E','I','O','U');