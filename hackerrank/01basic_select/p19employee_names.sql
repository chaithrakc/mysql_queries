/*
Difficulty: Easy
https://www.hackerrank.com/challenges/name-of-employees/problem

Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

*/

select name 
from employee 
order by name asc;