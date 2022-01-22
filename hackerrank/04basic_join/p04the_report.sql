/*
Difficulty: Medium

https://www.hackerrank.com/challenges/the-report/problem

You are given two tables: Students and Grades. 

Students contains three columns ID, Name and Marks.

Grades contains the following data: Grade, min_mark, max_mark

Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
The report must be in descending order by grade -- i.e. higher grades are entered first. 
If there is more than one student with the same grade (8-10) assigned to them, order those 
particular students by their name alphabetically. 
Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in 
descending order. If there is more than one student with the same grade (1-7) assigned to them, 
order those particular students by their marks in ascending order.
*/

select if(grade<8, NULL, name), grade, marks
from students inner join grades
where marks between min_mark and max_mark
order by grade desc, name asc;

/*
Britney 10 95
Heraldo 10 94
Julia 10 96
Kristeen 10 100
Stuart 10 99
Amina 9 89
Christene 9 88
Salma 9 81
Samantha 9 87
Scarlet 9 80
Vivek 9 84
Aamina 8 77
Belvet 8 78
Paige 8 74
Priya 8 76
Priyanka 8 77
NULL 7 64
NULL 7 66
NULL 6 55
NULL 4 34
NULL 3 24
*/

select if(grade<8, null, name), grade, marks
from students inner join grades on marks between min_mark and max_mark
order by grade desc, name asc, marks asc;

/*
As null, particularly not a legit value, is a pointer pointing to some invalid address, 
woud not get compared which is why even using DESC after MARKS will get you same result i.e 
in ascending order.
*/