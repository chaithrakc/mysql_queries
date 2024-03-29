/*
Problem Descriton:

    https://leetcode.com/problems/nth-highest-salary/ 

    Table: Employee

    +-------------+------+
    | Column Name | Type |
    +-------------+------+
    | id          | int  |
    | salary      | int  |
    +-------------+------+
    id is the primary key column for this table.
    Each row of this table contains information about the salary of an employee.
    

    Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

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
    n = 2
    Output: 
    +------------------------+
    | getNthHighestSalary(2) |
    +------------------------+
    | 200                    |
    +------------------------+
    Example 2:

    Input: 
    Employee table:
    +----+--------+
    | id | salary |
    +----+--------+
    | 1  | 100    |
    +----+--------+
    n = 2
    Output: 
    +------------------------+
    | getNthHighestSalary(2) |
    +------------------------+
    | null                   |
    +------------------------+

*/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      select min(salary) as SecondHighestSalary
      from (select salary, dense_rank() over (order by salary desc) as rownum from employee) 
      as temp 
      where rownum=n -- given in the problem; nth highest salary
  );
END

-- using common table expression
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      with salary_rankings as (select salary , dense_rank() over (order by salary desc) as ranking from employee)
      select min(salary) from salary_rankings where ranking=N
      
  );
END
