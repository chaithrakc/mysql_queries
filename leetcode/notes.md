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

Using common table expression and correlated sub-query

```
with dept_max_sal as( 
    select departmentId, max(salary) as highest_sal 
    from employee 
    group by departmentId
    )
select d.name as Department, e.name as Employee, e.salary as Salary
from employee e inner join department d on e.departmentId = d.id
where e.salary = (select highest_sal from dept_max_sal c where e.departmentId = c.departmentId)
```

https://leetcode.com/problems/department-highest-salary/

