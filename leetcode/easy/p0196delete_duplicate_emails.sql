/*
https://leetcode.com/problems/delete-duplicate-emails/

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id.

Return the result table in any order.

The query result format is in the following example.


Example 1:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.

*/


delete 
from person 
where id not in (select * from (select min(id) from person group by email) as temp);

/* mysql does not allow one to use a subquery with a table that is currently being updated in the 
outer query so we trick it by using it indirectly like so select * from (some_temp_table) as alias 
table 

input:
{"headers": {"Person": ["id", "email"]}, 
"rows": {"Person": [   [1, "john@example.com"], 
                       [2, "bob@example.com"], 
                       [3, "john@example.com"]
                    ]}}

output:
{"headers": ["id", "email"], 
"values": [ [1, "john@example.com"], 
            [2, "bob@example.com"]
        ]}

*/

-- Leet code solution

-- By joining this table with itself on the Email column, we can get the following code.

select *
from person as p1  inner join person p2 on p1.email = p2.email;

+-------+------------------+-------+------------------+
| p1.ID |     p1.email     | p2.ID |     p2.email     |
+-------+------------------+-------+------------------+
|     3 | john@example.com |     1 | john@example.com |
|     1 | john@example.com |     1 | john@example.com |
|     2 | bob@example.com  |     2 | bob@example.com  |
|     3 | john@example.com |     3 | john@example.com |
|     1 | john@example.com |     3 | john@example.com |
+-------+------------------+-------+------------------+

/* Then we need to find the bigger id having same email address with other records. 
So we can add a new condition to the WHERE clause like this. */

select *
from person as p1  inner join person p2 on p1.email = p2.email and p1.id>p2.id;


+-------+------------------+-------+------------------+
| p1.ID |     p1.email     | p2.ID |     p2.email     |
+-------+------------------+-------+------------------+
|     3 | john@example.com |     1 | john@example.com |
+-------+------------------+-------+------------------+

/*
As we already get the records to be deleted, we can alter this statement to DELETE in the end.
*/
delete p1 from person p1, person p2 where p1.email = p2.email and p1.id > p2.id;

