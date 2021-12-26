# SQL QUERIES

1. we cannot have any other columns selected along with aggregate functions
for example: select city, max(length(city)) from station;

2. modulus operator in sql
mod(id,2) - select even number of ids

3. The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions
syntax:
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

4. to select the top row in sql oracle use rownum=1

5. sorting multiple coulumns in opposite way
Example: select city, length(city) 
        from (select city from station order by length(city) desc, city asc) 
        where rownum=1;

6. string operation: upper(), lower(), substr(), substr() from backwards

select distinct(city) from station where upper(substr(city,1,1)) in ('A','E','I','O','U'); staring with vowel
select distinct(city) from station where upper(substr(city,-1,1)) in ('A','E','I','O','U'); ending with vowel
https://www.oracletutorial.com/oracle-string-functions/oracle-substr/

7. switch case in sql
select
case
when (A+B)<= C then 'Not A Triangle'
when A=B and B=C then 'Equilateral'
when A=B or B=C or C=A then 'Isosceles'
else 'Scalene'
end
from triangles;

8. || String Concatenation Operator - Oracle 
select name || '(' || substr(occupation, 1, 1) || ')' 
from occupations
order by name;

select 'There are a total of ' || count(occupation) || ' ' || lower(occupation) || 's.'
from occupations
group by occupation
order by count(occupation), occupation;

9. self joins https://www.w3resource.com/sql/joins/perform-a-self-join.php
SELECT a.column_name, b.column_name... 
FROM table1 a, table1 b 
WHERE a.common_filed = b.common_field;

10. using concat function, switch case and sub-query concept
select 
case
when p is null then concat(n,' Root')
when n in (select p from bst) then concat(n,' Inner')
else concat(n, ' Leaf')
end
from bst
order by n;

11. while using group by, same column should be projected

12. ceil function to round off to nearest whole number
select ceil(avg(salary) - avg(replace(salary, '0', ''))) from employees;

13. replace can be used with integer also in sql
select ceil(avg(salary) - avg(replace(salary, '0', ''))) from employees;
SELECT REPLACE(123, '1', '9');  - 923
