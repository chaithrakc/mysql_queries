/*
Problem Description:

    https://leetcode.com/problems/second-highest-salary/

    Table: Employee

    +-------------+------+
    | Column Name | Type |
    +-------------+------+
    | id          | int  |
    | salary      | int  |
    +-------------+------+
    id is the primary key column for this table.
    Each row of this table contains information about the salary of an employee.
    

    Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

    The query result format is in the following example.

    Example 1:

    Input: 
    Employee table:
    +----+--------+
    | id | salary |
    +----+--------+
    | 1  | 100    |
    | 2  | 200    |
    | 3  | 300    |
    +----+--------+
    Output: 
    +---------------------+
    | SecondHighestSalary |
    +---------------------+
    | 200                 |
    +---------------------+
    Example 2:

    Input: 
    Employee table:
    +----+--------+
    | id | salary |
    +----+--------+
    | 1  | 100    |
    +----+--------+
    Output: 
    +---------------------+
    | SecondHighestSalary |
    +---------------------+
    | null                |
    +---------------------+

*/

-- Query 1: with sorting and selecting top two rows
select min(salary) as SecondHighestSalary
from employee
order by salary desc
limit 2;

/*
input: {"headers":{"Employee":["id","salary"]},"rows":{"Employee":[[1,100],[2,200],[3,300]]}}
output: {"headers": ["SecondHighestSalary"], "values": [[100]]}
expected: {"headers": ["SecondHighestSalary"], "values": [[200]]}

Above query results in '100' because, as per the order of execution select executes first before sorting the data using order by and limit
(1) from
(2) where
(3) group by
(4) having
(5) select
(6) order by
(7) limit
*/
---------------------------------------------------------------------------------------------------

-- Query 2: row_number() will not satisfy the use case when multiple employees have same salary
select min(salary) as SecondHighestSalary
from (select salary, row_number() over (order by salary desc) as rownum from employee) as temp
where rownum=2; -- given in the problem; second highest salary

-- min() aggregate function is used to handle the use case: If there is no second highest salary, the query should report null

/*
input {"headers":{"Employee":["id","salary"]},"rows":{"Employee":[[1,100],[2,100]]}}
output {"headers": ["SecondHighestSalary"], "values": [[100]]}
expected {"headers": ["SecondHighestSalary"], "values": [[null]]}
*/

---------------------------------------------------------------------------------------------------

-- Query 3: Final Solution using dense_rank() which works even if multiple employees have same salary

select min(salary) as SecondHighestSalary
from (select salary, dense_rank() over (order by salary desc) as rownum from employee) as temp
where rownum=2; -- given in the problem; second highest salary

/* min() aggregate function is used to handle the use case: If there is no second highest 
salary, the query should report null 

if condition within the select clause was not working in leetcode platform
```
select if(salary is null, null, salary) as SecondHighestSalary
from (select salary, dense_rank() over (order by salary desc) as rownum from employee) as temp
where rownum=2; -- given in the problem; second highest salary

```
https://www.hackerrank.com/challenges/the-report/problem 

*/

/* external reading about dense_rank(): 
http://www.sql-tutorial.ru/en/book_rank_dense_rank_functions.html 
*/

-- using common table expression
with salary_rankings as (select salary , dense_rank() over (order by salary desc) as ranking from employee)
select min(salary) as SecondHighestSalary from salary_rankings where ranking=2;