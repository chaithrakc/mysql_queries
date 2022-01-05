/*
Difficulty: Medium

https://www.hackerrank.com/challenges/occupations/problem 

Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and 
displayed underneath its corresponding Occupation. The output column headers should be Doctor, 
Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Input Format

The OCCUPATIONS table is described as follows:
+-------------+--------+
|   Column    |  Type  |
+-------------+--------+
| Name        | String |
| Occupation  | String |
+-------------+--------+


Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

Sample Input
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
Jenny    Ashley     Meera  Jane
Samantha Christeen  Priya  Julia
NULL     Ketty      NULL   Maria

Explanation
The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation 
(in this case, the Professor and Actor columns) are filled with NULL values.

*/

-- row_number will assign ids within the partitioned subset of rows

--mysql query
select 
min(case when occupation = 'doctor'      then name else null end) ,
min(case when occupation = 'professor'   then name else null end) ,
min(case when occupation = 'singer'      then name else null end) ,
min(case when occupation = 'actor'       then name else null end)
from (select occupation, name, row_number() over (partition by occupation order by name) as id
from occupations) as temp
group by id

-- Group by is used to convert columns to rows. 
-- In the first statement it doesn't matter if Min or Max is used as long as the occupations 
-- are ordered by Name, they are used to select actual values rather than NULL.


--output of sub query 
select occupation, name, row_number() over (partition by occupation order by name) as id 
from occupations

/*Actor Eve 1
Actor Jennifer 2
Actor Ketty 3
Actor Samantha 4
Doctor Aamina 1
Doctor Julia 2
Doctor Priya 3
Professor Ashley 1
Professor Belvet 2
Professor Britney 3
Professor Maria 4
Professor Meera 5
Professor Naomi 6
Professor Priyanka 7
Singer Christeen 1
Singer Jane 2
Singer Jenny 3
Singer Kristeen 4 

Final Output:
--------------
Aamina Ashley Christeen Eve
Julia Belvet Jane Jennifer
Priya Britney Jenny Ketty
NULL Maria Kristeen Samantha
NULL Meera NULL NULL
NULL Naomi NULL NULL
NULL Priyanka NULL NULL

*/


--(Oracle Specific Query)
select doc.Name, prof.Name, sing.Name, act.Name
from (select Name, row_number() over (partition by occupation order by Name) id from occupations where occupation='Doctor') doc
full outer join (select Name, row_number() over (partition by occupation order by Name) id 
from occupations where occupation='Professor') prof on prof.id=doc.id
full outer join (select Name, row_number() over (partition by occupation order by Name) id 
from occupations where occupation='Singer') sing on sing.id=prof.id
full outer join (select Name, row_number() over (partition by occupation order by Name) id 
from occupations where occupation='Actor') act on act.id=sing.id;
