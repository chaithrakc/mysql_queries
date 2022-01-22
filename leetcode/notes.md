Easy


Medium


comparing list to another list using `in` operator
```
select dept.name as "Department", emp.name as "Employee", emp.salary as "Salary"
from employee emp inner join department dept on emp.departmentId = dept.id
where (emp.departmentId, emp.salary) in (select departmentId, max(salary)
                                        from employee
                                        group by departmentId);
```
https://leetcode.com/problems/department-highest-salary/

