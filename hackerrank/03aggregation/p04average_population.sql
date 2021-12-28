/*

Difficutly: Easy

https://www.hackerrank.com/challenges/average-population/problem


Query the average population for all cities in CITY, rounded down to the nearest integer.

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

*/

select floor(avg(population)) from city;
