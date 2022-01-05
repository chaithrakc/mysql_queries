/*
Difficulty: Medium

https://www.hackerrank.com/challenges/binary-search-tree-1/problem 

You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
+--------+---------+
| Column |  Type   |
+--------+---------+
| N      | Integer |
| P      | Integer |
+--------+---------+

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.

Sample Input
+---+------+
| N |  P   |
+---+------+
| 1 | 2    |
| 3 | 2    |
| 6 | 8    |
| 9 | 8    |
| 2 | 5    |
| 8 | 5    |
| 5 | null |
+---+------+

Sample Output
1 Leaf
2 Inner
3 Leaf
5 Root
6 Leaf
8 Inner
9 Leaf

Explanation
The Binary Tree below illustrates the sample:
             5
            /  \
           2    8 
          / \   / \
         1   3  6  9 

*/

select N,
case
when P is null then 'Root'
when N in (select P from BST) then 'Inner'
else 'Leaf'
end as type
from BST
order by N


-- using concat function, switch case and sub-query concept
select 
case
when p is null then concat(n,' Root')
when n in (select p from bst) then concat(n,' Inner')
else concat(n, ' Leaf')
end
from bst
order by n;