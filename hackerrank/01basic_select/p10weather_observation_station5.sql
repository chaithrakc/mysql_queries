/*
Difficulty: Medium

https://www.hackerrank.com/challenges/weather-observation-station-5/problem

Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

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

Sample Input

For example, CITY has four entries: DEF, ABC, PQRS and WXY.
Sample Output
ABC 3
PQRS 4

Explanation
When ordered alphabetically, the CITY names are listed as ABC, DEF, PQRS, and WXY, with lengths 3,3,4  and 3. The longest name is PQRS, but there are 3 options for shortest named city. Choose ABC, because it comes first alphabetically.

Note
You can write two separate queries to get the desired output. It need not be a single query.

*/

--mysql queries
/*SELECT ...  
FROM mytable  
ORDER BY ... 
LIMIT 1 */

select city, length(city) 
from station
order by length(city), city
limit 1;

select city, length(city) 
from station
order by length(city) desc, city asc
limit 1;

-- MySQL subquery in the FROM clause
/* When you use a subquery in the FROM clause, the result set returned from a subquery is 
used as a temporary table. This table is referred to as a derived table or materialized subquery.
*/
-- we need to alias the temporary table in mysql
select shortest_city.city, length(shortest_city.city) 
from (select city from station order by length(city), city) as shortest_city
limit 1;

select longest_city.city, length(longest_city.city) 
from (select city from station order by length(city) desc, city asc) as longest_city
limit 1;

/*
output
Amo 3
Marine On Saint Croix 21
*/

--oracle queries
-- from can be a table/query also
select city, length(city) 
from (select city from station order by length(city) asc, city asc) 
where rownum = 1;

select city, length(city) 
from (select city from station order by length(city) desc, city asc) 
where rownum=1;

-- MS SQL Server queries
SELECT top 1 city, len(city)
FROM station
ORDER BY len(city), city;

SELECT top 1 city, len(city)
FROM station
ORDER BY len(city) desc, city desc;

