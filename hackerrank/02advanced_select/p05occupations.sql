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

-- using if condition
select 
min(if(occupation='Doctor',name,null)),
min(if(occupation='Professor',name,null)),
min(if(occupation='Singer',name,null)),
min(if(occupation='Actor',name,null))
from (select name, occupation, row_number() over (partition by occupation order by name) as id
from occupations) as temp
group by id;

-- using pivot function of MS SQL Server

-- step1: setup the pivot source
with pivot_source as (
    select name, occupation, row_number() over (partition by occupation order by name) as rn
     from occupations
)

-- step2: pivot the table
select Doctor, Professor, Singer, Actor from pivot_source pivot(
    max(name) for occupation in (Doctor, Professor, Singer, Actor)
) as pivot_table
