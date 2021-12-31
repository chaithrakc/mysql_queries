/*
https://www.hackerrank.com/challenges/symmetric-pairs/problem
*/

select f1.x, f1.y
from functions f1 inner join functions f2 on f1.x=f2.y and f1.y=f2.x
group by f1.x, f1.y  -- to remove duplicates
having f1.x < f1.y or count(f1.x)>1
order by f1.x;


/* output
2 24
4 22
5 21
6 20
8 18
9 17
11 15
13 13
*/