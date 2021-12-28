/*
Difficulty: Medium

https://www.hackerrank.com/challenges/weather-observation-station-6/problem

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

select distinct(city) 
from station
where upper(substr(city,1,1)) in ('A','E','I','O','U');

/*
Acme 
Addison 
Agency 
Aguanga 
Alanson 
Alba 
Albany 
Albion 
Algonac 
Aliso Viejo 
Allerton 
Alpine 
Alton 
Amazonia 
Amo 
Andersonville 
Andover 
Anthony 
Archie 
Arispe 
Arkadelphia 
Arlington 
Arrowsmith 
Athens 
Atlantic Mine 
Auburn 
East China 
East Haddam 
East Irvine 
Eastlake 
Edgewater 
Effingham 
Eleele 
Elkton 
Elm Grove 
Emmett 
Equality 
Eriline 
Ermine 
Eros 
Eskridge 
Esmond 
Eufaula 
Eureka Springs 
Eustis 
Everton 
Irvington 
Oakfield 
Oconee 
Odin 
Ojai 
Olmitz 
Onaway 
Orange City 
Orange Park 
Osage City 
Osborne 
Oshtemo 
Ottertail 
Ozona 
Udall 
Ukiah 
Union Star 
Upperco 
Urbana
*/