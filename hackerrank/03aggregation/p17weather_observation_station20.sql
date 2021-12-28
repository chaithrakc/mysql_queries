/*

Difficulty: Medium

https://www.hackerrank.com/challenges/weather-observation-station-20/problem

A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal
places.

Median https://en.wikipedia.org/wiki/Median

*/
-- this will not work for even number of rows
select round(avg(lat_n),4) 
from (select lat_n, row_number() over (order by lat_n desc) as rnum2 from station) as temp2
where rnum2 in (select ceil(max(rnum1)/2)
               from (select row_number() over (order by lat_n desc) as rnum1 from station) as temp1);
-- 83.8913

-- Incomplete
select round(avg(lat_n),4) 
from (select lat_n, row_number() over (order by lat_n desc) as rnum2 from station) as temp2
where rnum2 = (select 
                case when mod(max(rnum1),2) <> 0 then ceil(max(rnum1)/2)
                else (floor(max(rnum1)/2), ceil(max(rnum1)/2))
               from (select row_number() over (order by lat_n desc) as rnum1 from station) as temp1);

-- mysql
SET @row_index := 0;

SELECT round(AVG(subq.lat_n),4)
FROM (
    SELECT @row_index:=@row_index + 1 AS row_index, lat_n
    FROM station
    ORDER BY lat_n
  ) AS subq
  WHERE subq.row_index -- referring to column row_index
  IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2)); -- referring to variable @row_index


--oracle 
select round(median(lat_n),4) from station;


