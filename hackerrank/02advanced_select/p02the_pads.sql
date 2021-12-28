/*
Difficulty: Easy

https://www.hackerrank.com/challenges/the-pads/problem 

Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.

The OCCUPATIONS table is described as follows:
+------------+--------+
|   Column   |  Type  |
+------------+--------+
| Name       | String |
| Occupation | String |
+------------+--------+
Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

Sample Input
An OCCUPATIONS table that contains the following records:
+-----------+------------+
|   Name    | Occupation |
+-----------+------------+
| Samantha  | Doctor     |
| Julia     | Actor      |
| Maria     | Actor      |
| Meera     | Singer     |
| Ashley    | Professor  |
| Ketty     | Professor  |
| Christeen | Professor  |
| Jane      | Actor      |
| Jenny     | Doctor     |
| Priya     | Singer     |
+-----------+------------+

Sample Output
Ashely(P)
Christeen(P)
Jane(A)
Jenny(D)
Julia(A)
Ketty(P)
Maria(A)
Meera(S)
Priya(S)
Samantha(D)
There are a total of 2 doctors.
There are a total of 2 singers.
There are a total of 3 actors.
There are a total of 3 professors.

*/


--mysql syntax
select concat(name,  '(' , substr(occupation, 1, 1) , ')' )
from occupations
order by name;

select concat('There are a total of ' , count(occupation) , ' ' , lower(occupation) , 's.')
from occupations
group by occupation
order by count(occupation), occupation;



--oracle syntax
-- sort the names in ascending order, immediately followed by the first letter of each profession enclosed in parentheses. For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
select name || '(' || substr(occupation, 1, 1) || ')' 
from occupations
order by name;

--number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order
--[occupation] is the lowercase occupation name. 
-- If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
select 'There are a total of ' || count(occupation) || ' ' || lower(occupation) || 's.'
from occupations
group by occupation
order by count(occupation), occupation;

