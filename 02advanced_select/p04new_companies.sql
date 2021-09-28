/*
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy:
Founder
|
Lead Manager
|
Senior Manager
|
Manager
|
Employee

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.

*/

select Company.company_code, founder, 
 count(distinct Lead_Manager.lead_manager_code) as leads, 
 count(distinct Senior_Manager.senior_manager_code) as sr_manager, 
 count(distinct Manager.manager_code) as manager,
 count(*) as employee
from Company, Lead_Manager, Senior_Manager, Manager, Employee
where Company.company_code = Lead_Manager.company_code
and Lead_Manager.lead_manager_code = Senior_Manager.lead_manager_code
and Senior_Manager.senior_manager_code = Manager.senior_manager_code
and Manager.manager_code = Employee.manager_code
group by Company.company_code, founder
order by Company.company_code;