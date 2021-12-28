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

--step1: join without common field
select * from Students join Grades;

select * from Students inner join Grades;

/*
Sample Output
19 Samantha 87 10 90 100
19 Samantha 87 9 80 89
19 Samantha 87 8 70 79
19 Samantha 87 7 60 69
19 Samantha 87 6 50 59
19 Samantha 87 5 40 49
19 Samantha 87 4 30 39
19 Samantha 87 3 20 29
19 Samantha 87 2 10 19
19 Samantha 87 1 0 9
21 Julia 96 10 90 100
21 Julia 96 9 80 89
21 Julia 96 8 70 79
21 Julia 96 7 60 69
21 Julia 96 6 50 59
21 Julia 96 5 40 49
21 Julia 96 4 30 39
21 Julia 96 3 20 29
21 Julia 96 2 10 19
21 Julia 96 1 0 9
11 Britney 95 10 90 100
11 Britney 95 9 80 89
11 Britney 95 8 70 79
11 Britney 95 7 60 69
11 Britney 95 6 50 59
11 Britney 95 5 40 49
11 Britney 95 4 30 39
11 Britney 95 3 20 29
11 Britney 95 2 10 19
11 Britney 95 1 0 9
32 Kristeen 100 10 90 100
32 Kristeen 100 9 80 89
32 Kristeen 100 8 70 79
32 Kristeen 100 7 60 69
32 Kristeen 100 6 50 59
32 Kristeen 100 5 40 49
32 Kristeen 100 4 30 39
32 Kristeen 100 3 20 29
32 Kristeen 100 2 10 19
32 Kristeen 100 1 0 9
*/

-- step 2: do the comparison for deciding the grade
select name, grade, marks
from students join grades
where marks between min_mark and max_mark;

select name, grade, marks
from students inner join grades
where marks between min_mark and max_mark;

/*
Samantha 9 87
Julia 10 96
Britney 10 95
Kristeen 10 100
Dyana 6 55
Jenny 7 66
Christene 9 88
Meera 3 24
Priya 8 76
Priyanka 8 77
Paige 8 74
Jane 7 64
Belvet 8 78
Scarlet 9 80
Salma 9 81
Amanda 4 34
Heraldo 10 94
Stuart 10 99
Aamina 8 77
Amina 9 89
Vivek 9 84
*/

--step 3: rest of the conditions
select if(grade<8, NULL, name), grade, marks
from students join grades
where marks between min_mark and max_mark
order by grade desc, name asc;


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