# SQL QUERIES

https://ozh.github.io/ascii-tables/ for generating tables

BASIC SELECT TAKE AWAYS:

1. we cannot have any other columns selected along with aggregate functions
for example: select city, max(length(city)) from station;
select city, count(city) from station;

2. modulus operator in sql
mod(id,2) - select even number of ids
Example Problem: https://www.hackerrank.com/challenges/weather-observation-station-3/problem

3. Finding the duplicate records in the table
select count(city) - count(distinct(city)) 
from station; 
https://www.hackerrank.com/challenges/weather-observation-station-4/problem 

4. to select the top row in sql oracle use rownum=1 and MySQL use limit 1
https://www.hackerrank.com/challenges/weather-observation-station-5/problem 
SELECT ...  
FROM mytable  
ORDER BY ... 
LIMIT 1

5. subquery in the FROM clause (when should we use subqueries in the from/where clauses?)
When you use a subquery in the FROM clause, the result set returned from a subquery is 
used as a temporary table. This table is referred to as a derived table or materialized subquery.

we need to alias the temporary table in mysql but its not required in case of oracle

select city, length(city) 
from (select city from station order by length(city) asc, city asc) 
where rownum = 1;

select shortest_city.city, length(shortest_city.city) 
from (select city from station order by length(city), city) as shortest_city
limit 1;

https://www.hackerrank.com/challenges/weather-observation-station-5/problem 

6. sorting multiple coulumns in opposite way
Example: select city, length(city) 
        from (select city from station order by length(city) desc, city asc) 
        where rownum=1;

7. string operation: length(), upper(), lower(), substr(), substr() from backwards
SUBSTR(string, start, length) (or) SUBSTR(string FROM start FOR length)

select substr(Name from -3 for 3)  -- extracting last 3 chars
from students;
https://www.hackerrank.com/challenges/more-than-75-marks/problem

select distinct(city) from station where upper(substr(city,1,1)) in ('A','E','I','O','U'); staring with vowel
select distinct(city) from station where upper(substr(city,-1,1)) in ('A','E','I','O','U'); ending with vowel
https://www.oracletutorial.com/oracle-string-functions/oracle-substr/

8. order by is possible even with substr(), length()
select name 
from students 
where marks > 75
order by substr(name, -3, 3), id;

select city, length(city) 
from station
order by length(city), city
limit 1;

https://www.hackerrank.com/challenges/more-than-75-marks/problem
https://www.hackerrank.com/challenges/weather-observation-station-5/problem

---------------------------------------------------------------------------------------------------

ADVANCED SELECT

1. switch case in sql
select
case
when (A+B)<= C then 'Not A Triangle'
when A=B and B=C then 'Equilateral'
when A=B or B=C or C=A then 'Isosceles'
else 'Scalene'
end
from triangles;

https://www.hackerrank.com/challenges/what-type-of-triangle/problem



9. || String Concatenation Operator - only for Oracle 
select name || '(' || substr(occupation, 1, 1) || ')' 
from occupations
order by name;

select 'There are a total of ' || count(occupation) || ' ' || lower(occupation) || 's.'
from occupations
group by occupation
order by count(occupation), occupation;

https://www.hackerrank.com/challenges/the-pads/problem

8. The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions
syntax:
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

9. we cannot have anyother columns in select clause other than the coulmns used in group by
but, you can have other aggregate functions like count, max 

select comp.company_code, founder,
count(distinct lm.lead_manager_code),
count(distinct sm.senior_manager_code),
count(distinct mn.manager_code),
count(distinct employee_code)
from company as comp
inner join lead_manager as lm on lm.company_code=comp.company_code
inner join senior_manager as sm on sm.lead_manager_code = lm.lead_manager_code
inner join manager as mn on mn.senior_manager_code = sm.senior_manager_code
inner join employee as emp on emp.manager_code = mn.manager_code
group by comp.company_code, founder
order by comp.company_code;

https://www.hackerrank.com/challenges/the-company/problem

10. self joins https://www.w3resource.com/sql/joins/perform-a-self-join.php
SELECT a.column_name, b.column_name... 
FROM table1 a, table1 b 
WHERE a.common_filed = b.common_field;

11. using concat function, switch case and sub-query concept
select 
case
when p is null then concat(n,' Root')
when n in (select p from bst) then concat(n,' Inner')
else concat(n, ' Leaf')
end
from bst
order by n;

12. while using group by, same column should be projected

13. ceil function to round off to nearest whole number
select ceil(avg(salary) - avg(replace(salary, '0', ''))) from employees;

14. replace can be used with integer also in sql
select ceil(avg(salary) - avg(replace(salary, '0', ''))) from employees;
SELECT REPLACE(123, '1', '9');  - 923

Between operator
https://www.techonthenet.com/mysql/between.php 

Joins using ascii standard
https://www.techonthenet.com/mysql/joins.php

Multiple Inner Joins 
https://www.sqlshack.com/sql-multiple-joins-for-beginners-with-examples/ 

Partition By
https://www.sqlshack.com/sql-partition-by-clause-overview/