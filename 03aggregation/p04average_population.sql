/*
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

select round(avg(population),0) from city;
select round(avg(population),1) from city;