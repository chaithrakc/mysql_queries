/*
Difficulty: Easy

https://www.hackerrank.com/challenges/weather-observation-station-4/problem 

Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

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

For example, if there are three records in the table with CITY values 'New York', 'New York', 'Bengalaru', there are 2 different city names: 'New York' and 'Bengalaru'. The query returns 1, because 
total number of records - number of unique city names = 3-2=1
*/

select count(city) - count(distinct(city)) 
from station;  -- resulting value is the number of duplicate records in the table

-- 13