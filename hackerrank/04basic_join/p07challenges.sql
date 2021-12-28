-- https://www.hackerrank.com/challenges/challenges/problem

/* these are the columns we want to output */
select c.hacker_id, h.name ,count(c.hacker_id) as c_count

/* this is the join we want to output them from */
from Hackers as h
    inner join challenges as c on c.hacker_id = h.hacker_id

/* after they have been grouped by hacker */
group by c.hacker_id,h.name

/* but we want to be selective about which hackers we output */
/* having is required (instead of where) for filtering on groups */
having 

    /* output anyone with a count that is equal to... */
    c_count = 
        /* the max count that anyone has */
        (SELECT max(temp1.cnt)
        from (SELECT count(hacker_id) as cnt
             from challenges
             group by hacker_id) as temp1
        )

    /* or anyone who's count is in... */
    or c_count in 
        /* the set of counts... */
        (select t.cnt
         from (select count(*) as cnt 
               from challenges
               group by hacker_id)  as t
         /* who's group of counts... */
         group by t.cnt
         /* has only one element */
         having count(t.cnt) = 1)

/* finally, the order the rows should be output */
order by c_count DESC, c.hacker_id
;

/*
Part 1: Julia asked her students to create some coding challenges. 
Write a query to print the hacker_id, name, and the total number of challenges created by 
each student. Sort your results by the total number of challenges in descending order. 
If more than one student created the same number of challenges, then sort the result by hacker_id. 
*/

--step1: select the required columns
select h.hacker_id, h.name, count(h.name) as challenges_created
from challenges c inner join hackers h on h.hacker_id=c.hacker_id
group by h.name,h.hacker_id
order by challenges_created desc, h.hacker_id asc;

/*
Part 2:  If more than one student created the same number of challenges and 
the count is less than the maximum number of challenges_created, 
then exclude those students from the result.
*/

/*cond1: select the records if  challenges_created = maximum count of challenges_created
(or)
cond2: select the records if challenges_created = single count of challenges_created
*/

select h.hacker_id, h.name, count(h.name) as challenges_created
from challenges c inner join hackers h on h.hacker_id=c.hacker_id
group by h.name,h.hacker_id

having 
challenges_created = ( select max(temp.cnt) from (select count(*) as cnt from challenges c inner join hackers h on h.hacker_id=c.hacker_id group by h.hacker_id) as temp)
or 
challenges_created in ( select temp.cnt from  (select count(*) as cnt from challenges c inner join hackers h on h.hacker_id=c.hacker_id group by h.hacker_id) as temp group by temp.cnt having count(temp.cnt) = 1)

order by challenges_created desc, h.hacker_id asc;

