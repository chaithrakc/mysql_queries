/*

180. Consecutive Numbers

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
 

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

The query result format is in the following example.

 
Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.

*/
--Step 1:
select * 
from logs as log1 inner join logs as log2 on log1.id=log2.id-1
inner join logs as log3 on log2.id = log3.id - 1;

/*
output
{"headers": ["id", "num", "id", "num", "id", "num"], 
"values": [ [1, 1, 2, 1, 3, 1], 
            [2, 1, 3, 1, 4, 2], 
            [3, 1, 4, 2, 5, 1], 
            [4, 2, 5, 1, 6, 2], 
            [5, 1, 6, 2, 7, 2]]}
*/

--Step 2: applying filters
select * 
from logs as log1 inner join logs as log2 on log1.id=log2.id-1
inner join logs as log3 on log2.id = log3.id - 1
where log1.num = log2.num and log2.num=log3.num;

/*
{"headers": ["id", "num", "id", "num", "id", "num"], 
"values": [ [1, 1, 2, 1, 3, 1]  ]}
*/

--step 3: selecting required column
select log1.num as ConsecutiveNums 
from logs as log1 inner join logs as log2 on log1.id=log2.id-1
inner join logs as log3 on log2.id = log3.id - 1
where log1.num = log2.num and log2.num=log3.num;

-- {"headers": ["ConsecutiveNums"], "values": [[1]]}

/*
adding distinct to handle below use case: Write an SQL query to find all numbers that appear 
at least three times consecutively. Below use case has more than thrice which should be considered 
as same number appearing more than thrice.

{"headers": {"Logs": ["id", "num"]}, 
"rows": {"Logs": [    [1, 3], 
                      [2, 3], 
                      [3, 3], 
                      [4, 3]
                ]}}

output: {"headers": ["ConsecutiveNums"], 
            "values": [ [3], 
                        [3]
                       ]}

expected: {"headers":["ConsecutiveNums"],
            "values":[[3]]}

*/

select distinct(log1.num) as ConsecutiveNums 
from logs as log1 inner join logs as log2 on log1.id=log2.id-1
inner join logs as log3 on log2.id = log3.id - 1
where log1.num = log2.num and log2.num=log3.num;
