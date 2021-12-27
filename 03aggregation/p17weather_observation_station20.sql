/*

Difficulty: Medium

https://www.hackerrank.com/challenges/weather-observation-station-20/problem

A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal
places.

Median https://en.wikipedia.org/wiki/Median

*/

select round(lat_n,4) 
from (select lat_n, row_number() over (order by lat_n desc) as rnum2 from station) as temp2
where rnum2 = (select 
               case when mod(max(rnum1),2) = 0 then max(rnum1)/2
               else ceil(max(rnum1/2))
               end
               from (select row_number() over (order by lat_n desc) as rnum1 from station) as temp1);

-- 83.8913
