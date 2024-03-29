# MYSQL QUERIES

https://ozh.github.io/ascii-tables/ for generating ascii tables.

### 1. BASIC SELECT

1. We cannot have any other columns selected along with aggregate functions. For example:
```
select city, max(length(city)) from station;
select city, count(city) from station;
```

2. Modulus operator in SQL<br>
`mod(id,2)` - select even number of ids.
`id % 2 = 0` in MS SQL Server

https://www.hackerrank.com/challenges/weather-observation-station-3/problem

3. Finding the number of duplicate records in the table
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

5. Subquery in the FROM clause. 

When you use a subquery in the FROM clause, the result set returned from a subquery is 
used as a temporary table. This table is referred to as a derived table or materialized subquery.<br> **We need to alias the temporary table in MYSQL but its not required in case of ORACLE.**

MYSQL query
```
select shortest_city.city, length(shortest_city.city)
from (select city from station order by length(city), city) as shortest_city
limit 1;
```


ORACLE query
```
select city, length(city) 
from (select city from station order by length(city) asc, city asc) 
where rownum = 1;
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
SUBSTR(col_name, start, length) (or) SUBSTR(col_name FROM start FOR length)
```
```
select substr(Name from -3 for 3)  -- extracting last 3 chars
from students;
```
https://www.hackerrank.com/challenges/more-than-75-marks/problem

8. `in` operator
```
-- staring with vowel
select distinct(city) from station where upper(substr(city,1,1)) in ('A','E','I','O','U');

--  ending with vowel
select distinct(city) from station where upper(substr(city,-1,1)) in ('A','E','I','O','U');
```
https://www.hackerrank.com/challenges/weather-observation-station-6/problem

https://www.hackerrank.com/challenges/weather-observation-station-7/problem

9. order by is possible even with `substr(), length()`
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

10. The `DISTINCT` keyword is applied to both the "city" and "state" columns. This means that the query will return a list of distinct city-state pairs from the "station" table.

```
SELECT DISTINCT city, state FROM station
```

11. Where clause with a query inside it

Example: List of student names, gpa where the student gpa is bigger than the average overall gpa

```
select student_firstname, student_lastname, student_gpa
from students
where student_gpa > (select avg(student_gpa) from students);
```
we do not see the overall average to understand the results.

We can get overall gpa as one of the columns but the query is messy.
```
select student_firstname, student_lastname, student_gpa, 
(select avg(student_gpa) from students) as overall_avg_gpa
from students
where student_gpa > (select avg(student_gpa) from students);
```

We can use a CTE to get the overall average gpa and use it in the where clause.
```
with avg_gpa as(
    select avg(student_gpa) as overall_avg from students
)
select student_firstname, student_lastname, student_gpa, 
(select * from avg_gpa)
from students
where student_gpa < (select * from avg_gpa);
```
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

2. `concat()` String Concatenation: https://www.w3schools.com/sql/func_sqlserver_concat.asp
```
select concat(name,  '(' , substr(occupation, 1, 1) , ')' )
from occupations
order by name;

select concat('There are a total of ' , count(occupation) , ' ' , lower(occupation) , 's.')
from occupations
group by occupation
order by count(occupation), occupation;
```
https://www.hackerrank.com/challenges/the-pads/problem

3. The `HAVING` clause was added to SQL because the `WHERE` keyword cannot be used with aggregate functions
```
syntax:
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);
```

Find the average GPA for each major, but only include majors with an average GPA greater than 3.0.

Sample Table:

Table: students
```
+-------------------+-------------------+--------------------+-------------------+--------------+---------------------+
| student_firstname |  student_lastname |  student_year_name |  student_major_id |  student_gpa |    student_notes    |
+-------------------+-------------------+--------------------+-------------------+--------------+---------------------+
| 'Robin'           | 'Banks'           | 'Freshman'         | 3                 |        4.000 | ''                  |
+-------------------+-------------------+--------------------+-------------------+--------------+---------------------+

Table: major
+----------+-------------+------------------------------------------+
| major_id |  major_code |                major_name                |
+----------+-------------+------------------------------------------+
|        1 |  'IMT'      |  'Information Management and Technology' |
+----------+-------------+------------------------------------------+
```

```
select  major_name, avg(student_gpa) as avg_gpa_by_major,
        count(*) as count_of_students_by_majpr
from students left join majors on student_major_id = major_id
group by major_name
having avg(student_gpa) > 3;
```

`having` can be applied to aggregate functions like `avg(), count(), max(), min()` similar to `where` clause.

4. using `concat()` function, switch case and sub-query concept
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
https://leetcode.com/problems/tree-node/
<br>
https://www.hackerrank.com/challenges/binary-search-tree-1/problem 

5. We cannot have any other column in select clause other than the coulmns used in group by
but we can have other aggregate functions like `count(), max()`
```
select c.company_code, c.founder,
count(distinct e.lead_manager_code) as total_lead_managers,
count(distinct e.senior_manager_code) as total_senior_managers,
count(distinct e.manager_code) as total_managers,
count(distinct e.employee_code) as total_employees
from company as c 
inner join employee as e on c.company_code = e.company_code
group by c.company_code, c.founder
order by c.company_code asc;
```
https://www.hackerrank.com/challenges/the-company/problem

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

```
-- using pivot function of MS SQL server
with pivot_source as (
    select name, occupation, row_number() over (partition by occupation order by name) as rn
     from occupations
)

select Doctor, Professor, Singer, Actor from pivot_source pivot(
    max(name) for occupation in (Doctor, Professor, Singer, Actor)
) as pivot_table
```

**PIVOT Syntax:**
```
SELECT <non-pivoted column>,
    [first pivoted column] AS <column name>,
    [second pivoted column] AS <column name>,
    ...
FROM
    (<source table>)
PIVOT
(
    <aggregation function>(<value column>)
    FOR <pivoted column>
    IN ([first pivoted column], [second pivoted column], ...)
) AS <alias for the pivot table>
```

https://www.hackerrank.com/challenges/occupations/problem <br>
https://leetcode.com/problems/reformat-department-table/

7. Correlated Subquery

Correlated subqueries are used when you need to use a value from the outer query in the subquery's WHERE clause. This means that the subquery is correlated with the outer query, and is executed once per row of the outer query.

Example: Find the names and salaries of all employees whose salary is greater than the average salary of their department.

```
SELECT name, salary
FROM employees e
WHERE salary > (
  SELECT AVG(salary)
  FROM employees
  WHERE department = e.department
);
```

The subquery calculates the average salary for each department, and the outer query selects employees whose salary is greater than their department's average salary.


***Further Reading:***

Between operator https://www.techonthenet.com/mysql/between.php

Joins using ascii standard
https://www.techonthenet.com/mysql/joins.php

Multiple Inner Joins
https://www.sqlshack.com/sql-multiple-joins-for-beginners-with-examples/

Partition By
https://www.sqlshack.com/sql-partition-by-clause-overview/

-----------------

### 3. AGGREGATION

1. `ceil()` function to **round up** to nearest whole number
```
select ceil(avg(salary) - avg(replace(salary, '0', ''))) from employees;
```

to **round down** to nearest whole number - `floor()`
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

**Note:** Whenever problem asks for max/min, go with sorting (or) `max()/min()` functions. Whenever problem statement has "each" keyword then group by can be used.

4. `power()` function to square the numbers and sqrt() to square root
https://www.w3schools.com/sql/func_mysql_power.asp

5. generating row numbers using `over()` function
```
select lat_n, row_number() over (order by lat_n desc) as rnum2 from station;
```
https://www.hackerrank.com/challenges/weather-observation-station-20/problem

https://leetcode.com/problems/second-highest-salary/

https://leetcode.com/problems/nth-highest-salary/

---------------------------------------------------------------------------------------------
### 4. BASIC JOIN

1. CROSS JOIN or INNER JOIN without common field
```
select * from Students inner join Grades;
```
https://www.hackerrank.com/challenges/the-report/problem

2. if condition within the select clause
```
select if(grade<8, null, name), grade, marks
from students inner join grades on marks between min_mark and max_mark
order by grade desc, name asc, marks asc;
```
https://www.hackerrank.com/challenges/the-report/problem

3. correlated sub query
extra reading https://learnsql.com/blog/correlated-sql-subquery-5-minutes/ 
```
select w.id, p.age, w.coins_needed, w.power 
from Wands as w join Wands_Property as p on w.code = p.code
where p.is_evil = 0 
and w.coins_needed = (select min(coins_needed) from Wands as w1 join Wands_Property as p1 on (w1.code = p1.code) where w1.power = w.power and p1.age = p.age) 
order by w.power desc, p.age desc;
```
https://www.hackerrank.com/challenges/harry-potter-and-wands/problem

4. sub queries in having clause
https://www.hackerrank.com/challenges/challenges/problem

--------------

### ADVANCED JOIN

1. combining two sub queries in the from clause without common field - cross join
```
select * from 
(select start_date from projects where start_date not in (select end_date from projects)) as st_temp,
(select end_date from projects where end_date not in (select start_date from projects)) as ed_temp;
```
https://www.hackerrank.com/challenges/sql-projects/problem

2. self joins 
```
select emp.name as employee
from employee as emp inner join employee mgr on emp.managerId = mgr.id
where emp.salary > mgr.salary;
```
https://leetcode.com/problems/employees-earning-more-than-their-managers/

```
select s.name
from students as s inner join packages p on s.id=p.id
inner join friends as f on s.id=f.id
inner join packages as fp on f.friend_id=fp.id
where p.salary < fp.salary
order by fp.salary;
```
https://www.hackerrank.com/challenges/placements/problem

```
select f1.x, f1.y
from functions f1 inner join functions f2 on f1.x=f2.y and f1.y=f2.x
group by f1.x, f1.y  -- to remove duplicates
having f1.x < f1.y or count(f1.x)>1
order by f1.x;

```
https://www.hackerrank.com/challenges/symmetric-pairs/problem

```
select distinct(log1.num) as ConsecutiveNums 
from logs as log1 inner join logs as log2 on log1.id=log2.id-1
inner join logs as log3 on log2.id = log3.id - 1
where log1.num = log2.num and log2.num=log3.num;
```
https://leetcode.com/problems/consecutive-numbers/

Joining condition is different
``` datediff(w1.recordDate,w2.recordDate) = 1```

https://leetcode.com/problems/rising-temperature/

-------

### order of execution
(1) from <br>
(2) where <br>
(3) group by <br>
(4) having <br>
(5) select <br>
(6) order by <br>
(7) limit <br>

```
syntax:
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s)
LIMIT value;
```

Note: "query execution order" is called logical query processing, as opposed to physical query processing (that deals with compiling, caching, access methods, and so on). 

Do not mistake logical query execution for physical query execution, they are two different things. 

The easiest way to find what is executed first, just look at the **execution plan** - in Microsoft SQL Server you even have the option of looking at the data transfer between operators live.

---------
### Date Handling in MySQL

SQL Server MONTH() Function
https://www.w3schools.com/sql/func_sqlserver_month.asp

```
select month('2017/08/25') as mm;
```

SQL Server DATEDIFF() Function
https://www.w3schools.com/sql/func_sqlserver_datediff.asp
```
SELECT DATEDIFF(year, '2017/08/25', '2011/08/25') AS DateDiff;
```
```
+--------------+-------------------------------------------------------------------+
|  Parameter   |                            Description                            |
+--------------+-------------------------------------------------------------------+
| interval     | Required. The part to return. Can be one of the following values: |
|              | year, yyyy, yy = Year                                             |
|              | quarter, qq, q = Quarter                                          |
|              | month, mm, m = month                                              |
|              | dayofyear = Day of the year                                       |
|              | day, dy, y = Day                                                  |
|              | week, ww, wk = Week                                               |
|              | weekday, dw, w = Weekday                                          |
|              | hour, hh = hour                                                   |
|              | minute, mi, n = Minute                                            |
|              | second, ss, s = Second                                            |
|              | millisecond, ms = Millisecond                                     |
| date1, date2 | Required. The two dates to calculate the difference between       |
+--------------+-------------------------------------------------------------------+
```



