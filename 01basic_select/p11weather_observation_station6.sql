/*
Difficulty: easy

Query the list of CITY names starting with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

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

select distinct(city) from station where upper(substr(city,1,1)) in ('A','E','I','O','U');