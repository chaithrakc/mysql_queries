/*

Difficulty: Easy

https://www.hackerrank.com/challenges/weather-observation-station-15/problem

Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345 . Truncate your answer to 4 decimal places.

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
--my approach
select round(long_w,4)
from (select * from station order by lat_n desc) as temp
where lat_n < 137.2345
limit 1;

--efficient way
select round(long_w, 4) from station 
where lat_n = (select max(lat_n) from station where lat_n < 137.2345);