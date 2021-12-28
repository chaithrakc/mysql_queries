/*
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

select min(salary) as SecondHighestSalary
from employee
order by salary desc
limit 2;

/*
input: {"headers":{"Employee":["id","salary"]},"rows":{"Employee":[[1,100],[2,200],[3,300]]}}
output: {"headers": ["SecondHighestSalary"], "values": [[100]]}
expected: {"headers": ["SecondHighestSalary"], "values": [[200]]}

-- above query results in 100 because, as per the order of execution:
(1) from
(2) where
(3) group by
(4) having
(5) select
(6) order by
(7) limit
*/

-- row_number() will not satisfy below use case

select min(salary) as SecondHighestSalary
from (select salary, row_number() over (order by salary desc) as rownum from employee) as temp
where rownum=2; -- given in the problem; second highest salary

-- min() aggregate function is used to just to handle the use case: If there is no second highest salary, the query should report null

/*
input {"headers":{"Employee":["id","salary"]},"rows":{"Employee":[[1,100],[2,100]]}}
output {"headers": ["SecondHighestSalary"], "values": [[100]]}
expected {"headers": ["SecondHighestSalary"], "values": [[null]]}
*/

-- use dense_rank()
select min(salary) as SecondHighestSalary
from (select salary, dense_rank() over (order by salary desc) as rownum from employee) as temp
where rownum=2; -- given in the problem; second highest salary

/* min() aggregate function is used to just to handle the use case: If there is no second highest 
salary, the query should report null */

/* external reading about dense_rank(): 
http://www.sql-tutorial.ru/en/book_rank_dense_rank_functions.html 
*/