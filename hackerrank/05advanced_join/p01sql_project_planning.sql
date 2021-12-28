-- https://www.hackerrank.com/challenges/sql-projects/problem

/*step1: two sub queries in from clause
1) Choose start dates that are not end dates of other projects (if a start date is an end date, it is part of the same project)
2) Choose end dates that are not end dates of other projects

two sub queries result in cross join : mxn rows

2015-10-01 2015-10-05
2015-10-01 2015-10-13
2015-10-01 2015-10-16
2015-10-01 2015-10-18
2015-10-01 2015-10-20
2015-10-01 2015-10-22
2015-10-01 2015-10-31
2015-10-01 2015-11-02
2015-10-01 2015-11-08
2015-10-01 2015-11-13
2015-10-01 2015-11-18
2015-10-11 2015-10-05
2015-10-11 2015-10-13
2015-10-11 2015-10-16
2015-10-11 2015-10-18
2015-10-11 2015-10-20
2015-10-11 2015-10-22
2015-10-11 2015-10-31
2015-10-11 2015-11-02
2015-10-11 2015-11-08
2015-10-11 2015-11-13
2015-10-11 2015-11-18
2015-10-15 2015-10-05
2015-10-15 2015-10-13
2015-10-15 2015-10-16
2015-10-15 2015-10-18
2015-10-15 2015-10-20
2015-10-15 2015-10-22
2015-10-15 2015-10-31
2015-10-15 2015-11-02
2015-10-15 2015-11-08
2015-10-15 2015-11-13
2015-10-15 2015-11-18
*/

select *
from 
--  Choose start dates that are not end dates of other projects
(select start_date from projects where start_date not in (select end_date from projects)) as st_temp,
-- Choose end dates that are not start dates of other projects
(select end_date from projects where end_date not in (select start_date from projects)) as ed_temp;
-- this results in cross join with m x n rows. eliminate a few of the records where start > end
where start_date < end_date;

/*
output after apply where condition
2015-10-01 2015-10-05
2015-10-01 2015-10-22
2015-10-01 2015-10-20
2015-10-01 2015-10-31
2015-10-01 2015-11-02
2015-10-01 2015-10-18
2015-10-01 2015-11-08
2015-10-01 2015-11-13
2015-10-01 2015-10-16
2015-10-01 2015-11-18
2015-10-01 2015-10-13

2015-10-11 2015-11-13
2015-10-11 2015-11-08
2015-10-11 2015-11-18
2015-10-11 2015-11-02
2015-10-11 2015-10-31
2015-10-11 2015-10-13
2015-10-11 2015-10-22
2015-10-11 2015-10-16
2015-10-11 2015-10-18
2015-10-11 2015-10-20

2015-10-15 2015-11-08
2015-10-15 2015-10-16
2015-10-15 2015-11-18
2015-10-15 2015-10-18
2015-10-15 2015-11-13
2015-10-15 2015-10-22
2015-10-15 2015-10-20
2015-10-15 2015-11-02
2015-10-15 2015-10-31
*/

/*
step 2: group by start date
output
2015-10-01 11
2015-10-11 10
2015-10-15 9
2015-10-17 8
2015-10-19 7
2015-10-21 6
2015-10-25 5
2015-11-01 4
2015-11-04 3
2015-11-11 2
2015-11-17 1
*/
select start_date, count(*)
from 
--  Choose start dates that are not end dates of other projects
(select start_date from projects where start_date not in (select end_date from projects)) as st_temp,
-- Choose end dates that are not start dates of other projects
(select end_date from projects where end_date not in (select start_date from projects)) as ed_temp;
-- this results in cross join with m x n rows. eliminate a few of the records where start > end
where start_date < end_date
group by start_date;

/* Step 3:
in order to choose end date among a list of possible end dates for a particular start_date
for example  '2015-10-01' has 11 possible end dates
2015-10-01 2015-10-05
2015-10-01 2015-10-13
2015-10-01 2015-10-16
2015-10-01 2015-10-18
2015-10-01 2015-10-20
2015-10-01 2015-10-22
2015-10-01 2015-10-31
2015-10-01 2015-11-02
2015-10-01 2015-11-08
2015-10-01 2015-11-13
2015-10-01 2015-11-18

we will choose end date that has minimum days of between start_date and end_date. This is because end dates for same project is consecutive and for each task difference between end date and start date is 1 day
*/

-- choose end date that has minimum days of between start_date and end_date
select start_date, min(end_date)
from 
--  Choose start dates that are not end dates of other projects
(select start_date from projects where start_date not in (select end_date from projects)) as st_temp,
-- Choose end dates that are not start dates of other projects
(select end_date from projects where end_date not in (select start_date from projects)) as ed_temp;
-- this results in cross join with m x n rows. eliminate a few of the records where start > end
where start_date < end_date
group by start_date;

/* 
output
2015-10-01 2015-10-05
2015-10-11 2015-10-13
2015-10-15 2015-10-16
2015-10-17 2015-10-18
2015-10-19 2015-10-20
2015-10-21 2015-10-22
2015-10-25 2015-10-31
2015-11-01 2015-11-02
2015-11-04 2015-11-08
2015-11-11 2015-11-13
2015-11-17 2015-11-18
*/

/*
step 4: sort according to criteria given in the problem
number of days it took to complete the project in ascending order.

 If there is more than one project that have the same number of completion days, then order by the start date of the project.
 */

 select start_date, min(end_date)
from 
(select start_date from projects where start_date not in (select end_date from projects)) as st_temp,
(select end_date from projects where end_date not in (select start_date from projects)) as ed_temp
where start_date < end_date
group by start_date
order by datediff(min(end_date), start_date), start_date;








