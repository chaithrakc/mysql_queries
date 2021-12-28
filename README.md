# MYSQL QUERIES

https://ozh.github.io/ascii-tables/ for generating ascii tables

### 1. BASIC SELECT

1. We cannot have any other columns selected along with aggregate functions
for example: 
```
select city, max(length(city)) from station;
select city, count(city) from station;
```

2. Modulus operator in SQL<br>
`mod(id,2)` - select even number of ids.

https://www.hackerrank.com/challenges/weather-observation-station-3/problem

3. Finding the duplicate records in the table
```
select count(city) - count(distinct(city)) 
from station; 
```
https://www.hackerrank.com/challenges/weather-observation-station-4/problem 

4. To select the top row in sql oracle use rownum=1 and MySQL use limit 1
```
SELECT ...  
FROM mytable  
ORDER BY ... 
LIMIT 1
```
https://www.hackerrank.com/challenges/weather-observation-station-5/problem 

5. Subquery in the FROM clause (when should we use subqueries in the from/where clauses?)
When you use a subquery in the FROM clause, the result set returned from a subquery is 
used as a temporary table. This table is referred to as a derived table or materialized subquery.<br> **We need to alias the temporary table in mysql but its not required in case of oracle.**
```
select city, length(city) 
from (select city from station order by length(city) asc, city asc) 
where rownum = 1;
```
```
select shortest_city.city, length(shortest_city.city) 
from (select city from station order by length(city), city) as shortest_city
limit 1;
```
https://www.hackerrank.com/challenges/weather-observation-station-5/problem 

6. sorting multiple coulumns in opposite way
```
select city, length(city) 
from (select city from station order by length(city) desc, city asc) 
where rownum=1;
 ```

7. string operation: `length(), upper(), lower(), substr(), substr() from backwards`
```
SUBSTR(string, start, length) (or) SUBSTR(string FROM start FOR length)
```
```
select substr(Name from -3 for 3)  -- extracting last 3 chars
from students;
```
https://www.hackerrank.com/challenges/more-than-75-marks/problem

```
select distinct(city) from station where upper(substr(city,1,1)) in ('A','E','I','O','U'); staring with vowel
select distinct(city) from station where upper(substr(city,-1,1)) in ('A','E','I','O','U'); ending with vowel
```
https://www.oracletutorial.com/oracle-string-functions/oracle-substr/

8. order by is possible even with `substr(), length()`
```
select name 
from students 
where marks > 75
order by substr(name, -3, 3), id;
```
```
select city, length(city) 
from station
order by length(city), city
limit 1;
```
https://www.hackerrank.com/challenges/more-than-75-marks/problem
https://www.hackerrank.com/challenges/weather-observation-station-5/problem

---------------------------------------------------------------------------------------------------

### 2. ADVANCED SELECT

1. switch case (if...else if...else ladder) in SQL 
https://www.w3schools.com/sql/func_mysql_case.asp 
```
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
```
```
select
case
when (A+B)<= C then 'Not A Triangle'
when A=B and B=C then 'Equilateral'
when A=B or B=C or C=A then 'Isosceles'
else 'Scalene'
end
from triangles;
```
https://www.hackerrank.com/challenges/what-type-of-triangle/problem
https://www.hackerrank.com/challenges/occupations/problem


2. `||` String Concatenation Operator - only for Oracle 
```
select name || '(' || substr(occupation, 1, 1) || ')' 
from occupations
order by name;
```
```
select 'There are a total of ' || count(occupation) || ' ' || lower(occupation) || 's.'
from occupations
group by occupation
order by count(occupation), occupation;
```
https://www.hackerrank.com/challenges/the-pads/problem

3. The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions
```
syntax:
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);
```

4. We cannot have anyother columns in select clause other than the coulmns used in group by
but, you can have other aggregate functions like `count(), max()`. 
```
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
```
https://www.hackerrank.com/challenges/the-company/problem

5. using `concat()` function, switch case and sub-query concept
```
select 
case
when p is null then concat(n,' Root')
when n in (select p from bst) then concat(n,' Inner')
else concat(n, ' Leaf')
end
from bst
order by n;
```
https://www.hackerrank.com/challenges/binary-search-tree-1/problem 

6. Transposing the table - using switch case, partition by, group by

multiple if...else conditions

```
select 
min(case when occupation = 'doctor'      then name else null end) ,
min(case when occupation = 'professor'   then name else null end) ,
min(case when occupation = 'singer'      then name else null end) ,
min(case when occupation = 'actor'       then name else null end)
from (select occupation, name, row_number() over (partition by occupation order by name) as id
from occupations) as temp
group by id
```
https://www.hackerrank.com/challenges/occupations/problem 

***Extra References:***

Between operator https://www.techonthenet.com/mysql/between.php

Joins using ascii standard
https://www.techonthenet.com/mysql/joins.php

Multiple Inner Joins 
https://www.sqlshack.com/sql-multiple-joins-for-beginners-with-examples/

Partition By
https://www.sqlshack.com/sql-partition-by-clause-overview/

-----------------

### 3. AGGREGATION

1. `ceil()` function to round up to nearest whole number
```
select ceil(avg(salary) - avg(replace(salary, '0', ''))) from employees;
```

to round down to nearest whole number - `floor()`
```
select floor(avg(population)) from city;
```

https://www.hackerrank.com/challenges/average-population-of-each-continent/problem 
https://www.hackerrank.com/challenges/average-population/problem

2. `replace()` can be used with integer also in sql
```
select ceil(avg(salary) - avg(replace(salary, '0', ''))) from employees;
```
```
SELECT REPLACE(123, '1', '9');  - 923
```
https://www.hackerrank.com/challenges/the-blunder/problem

3. truncate function - `TRUNCATE(number, decimals)`
```
select trunc(sum(lat_n),4)
from station
where lat_n between 38.7880 and 137.2345;
```
```
select trunc(max(lat_n),4)
from station
where lat_n < 137.2345;
```
https://www.hackerrank.com/challenges/weather-observation-station-13/problem

***Note:*** Whenever problem asks for max/min, go with sorting (or) `max()/min()` functions. Whenever problem statement has "each" keyword then group by can be used

4. `power()` function to square the numbers and sqrt() to square root
https://www.w3schools.com/sql/func_mysql_power.asp 

---------------------------------------------------------------------------------------------
### 4. BASIC JOIN

1. CROSS JOIN or INNER JOIN without common field
```
select * from Students inner join Grades;
```
https://www.hackerrank.com/challenges/the-report/problem

2. if condition within the select clause
```
select if(grade<8, NULL, name), grade, marks
from students join grades
where marks between min_mark and max_mark
order by grade desc, name asc;
```
https://www.hackerrank.com/challenges/the-report/problem

3. correlated sub query
extra reading https://learnsql.com/blog/correlated-sql-subquery-5-minutes/ 
Example: https://www.hackerrank.com/challenges/harry-potter-and-wands/problem
```
select w.id, p.age, w.coins_needed, w.power 
from Wands as w join Wands_Property as p on w.code = p.code
where p.is_evil = 0 
and w.coins_needed = (select min(coins_needed) from Wands as w1 join Wands_Property as p1 on (w1.code = p1.code) where w1.power = w.power and p1.age = p.age) 
order by w.power desc, p.age desc;
```
--------------

### ADVANCED JOIN


--------------
self joins https://www.w3resource.com/sql/joins/perform-a-self-join.php
```
SELECT a.column_name, b.column_name... 
FROM table1 a, table1 b 
WHERE a.common_filed = b.common_field;
```

order of execution
(1) From <br>
(2) Where <br>
(3) Group By <br>
(4) Having <br>
(5) Select <br>
(6) Order By <br>
(7) Limit <br>
