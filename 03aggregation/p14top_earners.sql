/*
total earnings = monthly  salary *  months worked. 

Write a query to find the maximum total earnings as well as the total number of employees who have maximum total earnings. Then print these values as 2  space-separated integers.

Input Format

The Employee table containing employee data for a company is described as follows:
+-------------+---------+
|   Column    |  Type   |
+-------------+---------+
| employee_id | Integer |
| name        | Integer |
| months      | Integer |
| salary      | Integer |
+-------------+---------+

solution: https://nifannn.github.io/2017/10/23/SQL-Notes-Hackerrank-Top-Earners/
1. compute earnings ==> SELECT (months*salary) as earnings
2. output number of employees ==> COUNT(*) in Employee table ==> FROM Employee
3. group employees by earnings ==> GROUP BY earnings
4. sort by earnings in descending order ==> ORDER BY earnings DESC
5. output the one having the maximum earnings ==> LIMIT 1
*/

select (months*salary) as earnings, count(*)
from employee
group by earnings
order by earnings desc
limit 1;
