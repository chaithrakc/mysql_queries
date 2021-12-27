/*

Difficulty: Easy

https://www.hackerrank.com/challenges/japan-population/problem

Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

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

select sum(population) from city where countrycode='JPN';