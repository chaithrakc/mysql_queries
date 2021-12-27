/*
https://www.hackerrank.com/challenges/full-score/problem
*/

select *
from submissions as subm inner join hackers as hack on subm.hacker_id = hack.hacker_id;

/* sample output
43954 40226 69855 40 40226 Anna 
89007 85039 44764 14 85039 Linda 
38171 32172 25419 80 32172 Jonathan 
95655 95822 63530 47 95822 Wayne 
67667 61885 55235 16 61885 Gerald 
608 72 93294 0 72 Rose 
*/

select *
from submissions as sub inner join hackers as hack on sub.hacker_id = hack.hacker_id
inner join challenges on sub.challenge_id = challenges.challenge_id;

/*
43954 40226 69855 40 40226 Anna 69855 48984 3 
89007 85039 44764 14 85039 Linda 44764 14863 2 
38171 32172 25419 80 32172 Jonathan 25419 49307 5 
95655 95822 63530 47 95822 Wayne 63530 39771 4 
67667 61885 55235 16 61885 Gerald 55235 59853 4 
608 72 93294 0 72 Rose 93294 59907 4 
48950 47641 51898 30 47641 Patricia 51898 5720 2 
14835 13762 44764 30 13762 Gloria 44764 14863 2 
*/

select *
from submissions as sub inner join hackers as hack on sub.hacker_id = hack.hacker_id
inner join challenges on sub.challenge_id = challenges.challenge_id
inner join difficulty on challenges.difficulty_level = difficulty.difficulty_level;

/*
43954 40226 69855 40 40226 Anna 69855 48984 3 3 40 
89007 85039 44764 14 85039 Linda 44764 14863 2 2 30 
38171 32172 25419 80 32172 Jonathan 25419 49307 5 5 80 
95655 95822 63530 47 95822 Wayne 63530 39771 4 4 60 
67667 61885 55235 16 61885 Gerald 55235 59853 4 4 60 
608 72 93294 0 72 Rose 93294 59907 4 4 60 
48950 47641 51898 30 47641 Patricia 51898 5720 2 2 30 
14835 13762 44764 30 13762 Gloria 44764 14863 2 2 30 
*/

select s.hacker_id,name
from submissions as s inner join hackers as h on s.hacker_id = h.hacker_id
inner join challenges as c on s.challenge_id = c.challenge_id
inner join difficulty as d on c.difficulty_level = d.difficulty_level
where s.score = d.score and c.difficulty_level = d.difficulty_level
group by name,s.hacker_id
having count(s.hacker_id)>1
order by count(s.hacker_id) desc, s.hacker_id asc;
