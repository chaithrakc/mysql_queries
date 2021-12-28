/* 
Difficulty: Easy (if you have solved other problems under this section)

https://www.hackerrank.com/challenges/contest-leaderboard/problem

The total score of a hacker is the sum of their maximum scores for all of the challenges. 

Write a query to print the hacker_id, name, and total score of the hackers ordered by the 
descending score. If more than one hacker achieved the same total score, 
then sort the result by ascending hacker_id. 

Exclude all hackers with a total score of 0 from your result.
*/

-- step 1: group by hacker and again group by on challenges
select h.hacker_id,s.challenge_id, max(score) as max_score
from submissions as s inner join hackers as h on s.hacker_id=h.hacker_id
group by h.hacker_id,s.challenge_id

/*sample output
486 20594 45 
486 68420 29 
597 20594 107 
775 68420 31 
964 28665 55 
1700 14825 66 
1700 38705 49 
1746 28665 32 
1755 28665 58 
1869 38705 120 
2380 20594 71 
2380 99786 104 
2751 99786 97 
2938 34238 82 
3683 20594 112 
3683 38049 100 
3845 31012 73 
4404 20460 41 
4881 30109 79 
4881 68420 85 
*/

--step 2: sum up the max scores derived from inner sub query
--step 3: apply other conditions
select hackerId,hackerName, sum(max_score) as total_score
from 
    (select h.hacker_id as hackerId,h.name as hackerName, s.challenge_id, max(score) as max_score
        from submissions as s inner join hackers as h on s.hacker_id=h.hacker_id
        group by h.hacker_id,h.name,s.challenge_id
    ) as temp
group by hackerId, hackerName
having total_score > 0
order by total_score desc, hackerId asc;

/* sample output
76971 Ashley 760 
84200 Susan 710 
76615 Ryan 700 
82382 Sara 640 
79034 Marilyn 580 
78552 Harry 570 
74064 Helen 540 
78688 Sean 540 
83832 Jason 540 
72796 Jose 510 
76216 Carlos 510 
90304 Lillian 500 
88507 Patrick 490 
72505 Keith 480 
88018 Dennis 480 
78918 Julia 470 
85319 Shawn 470 
71357 Bobby 460 
72047 Elizabeth 460 
*/
