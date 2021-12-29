/*

https://www.hackerrank.com/challenges/placements/problem

*/

select s.name
from students as s inner join packages p on s.id=p.id
inner join friends as f on s.id=f.id
inner join packages as fp on f.friend_id=fp.id
where p.salary < fp.salary
order by fp.salary;

/* output
Stuart 
Priyanka 
Paige 
Jane 
Julia 
Belvet 
Amina 
Kristeen 
Scarlet 
Priya 
Meera
*/
