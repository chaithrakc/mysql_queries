/*

Difficulty: Medium

https://www.hackerrank.com/challenges/the-company/problem 

Amber's conglomerate corporation just acquired some new companies. Each of the companies follows 
this hierarchy:
Founder
|
Lead Manager
|
Senior Manager
|
Manager
|
Employee

Given the table schemas below, write a query to print the company_code, founder name, 
total number of lead managers, total number of senior managers, total number of managers, 
and total number of employees. Order your output by ascending company_code.

Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the 
company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, 
and C_2.

*/

--using ascii standard
select c.company_code, c.founder,
count(distinct e.lead_manager_code) as total_lead_managers,
count(distinct e.senior_manager_code) as total_senior_managers,
count(distinct e.manager_code) as total_managers,
count(distinct e.employee_code) as total_employees
from company as c 
inner join employee as e on c.company_code = e.company_code
group by c.company_code, c.founder -- even though we do not require founder in grouping by, we shud add it. otherwise,we wont be able to project founder in output
order by c.company_code asc;

/*
output
C1 Angela 1 2 5 13 
C10 Earl 1 1 2 3 
C100 Aaron 1 2 4 10 
C11 Robert 1 1 1 1 
C12 Amy 1 2 6 14 
C13 Pamela 1 2 5 14 
C14 Maria 1 1 3 5 
C15 Joe 1 1 2 3 
C16 Linda 1 1 3 5 
C17 Melissa 1 2 3 7 
C18 Carol 1 2 5 6 
C19 Paula 1 2 4 7 
C2 Frank 1 1 1 3 
C20 Marilyn 1 1 2 2 
C21 Jennifer 1 1 3 7 
C22 Harry 1 1 3 6 
C23 David 1 1 1 2 
C24 Julia 1 1 2 6 
C25 Kevin 1 1 2 5 
C26 Paul 1 1 1 3 
C27 James 1 1 1 3 
C28 Kelly 1 2 5 9 
C29 Robin 1 2 4 9 
C3 Patrick 1 2 2 5 
C30 Ralph 1 1 2 5 
C31 Gloria 1 1 1 3 
C32 Victor 1 2 4 8 
C33 David 1 2 5 12 
C34 Joyce 1 2 6 10 
C35 Donna 1 2 6 12 
C36 Michelle 1 2 5 11 
C37 Stephanie 1 1 2 5 
C38 Gerald 1 2 4 6 
C39 Walter 1 1 3 7 
C4 Lisa 1 1 1 1 
C40 Christina 1 1 3 6 
C41 Brandon 1 2 3 7 
C42 Elizabeth 1 2 4 8 
C43 Joseph 1 2 4 6 
C44 Lawrence 1 1 3 4 
C45 Marilyn 1 1 1 3 
C46 Lori 1 2 3 9 
C47 Matthew 1 2 3 4 
C48 Jesse 1 1 3 3 
C49 John 1 1 3 8 
C5 Kimberly 1 2 3 9 
C50 Martha 1 1 2 5 
C51 Timothy 1 2 5 12 
C52 Christine 1 1 2 2 
C53 Anthony 1 1 1 1 
C54 Paula 1 2 4 7 
C55 Kimberly 1 2 2 3 
C56 Louise 1 1 1 3 
C57 Martin 1 1 2 5 
C58 Paul 1 2 4 8 
C59 Antonio 1 1 2 4 
C6 Bonnie 1 1 2 6 
C60 Jacqueline 1 1 1 2 
C61 Diana 1 1 1 1 
C62 John 1 2 5 11 
C63 Dorothy 1 2 5 7 
C64 Evelyn 1 1 1 2 
C65 Phillip 1 2 4 8 
C66 Evelyn 1 2 4 11 
C67 Debra 1 1 1 3 
C68 David 1 2 5 9 
C69 Willie 1 1 1 3 
C7 Michael 1 1 1 2 
C70 Brandon 1 2 4 7 
C71 Ann 1 2 5 10 
C72 Emily 1 2 3 7 
C73 Dorothy 1 1 1 2 
C74 Jonathan 1 2 4 7 
C75 Dorothy 1 1 2 4 
C76 Marilyn 1 2 5 12 
C77 Norma 1 2 5 10 
C78 Nancy 1 2 3 7 
C79 Andrew 1 1 2 2 
C8 Todd 1 1 1 3 
C80 Keith 1 1 1 2 
C81 Benjamin 1 1 3 9 
C82 Charles 1 1 2 3 
C83 Alan 1 2 3 4 
C84 Tammy 1 1 1 3 
C85 Anna 1 2 4 8 
C86 James 1 1 3 5 
C87 Robin 1 2 3 5 
C88 Jean 1 1 2 3 
C89 Andrew 1 2 4 7 
C9 Joe 1 1 3 6 
C90 Roy 1 1 2 3 
C91 Diana 1 2 2 2 
C92 Christina 1 1 1 3 
C93 Jesse 1 1 2 2 
C94 Joyce 1 2 5 13 
C95 Patricia 1 1 3 5 
C96 Gregory 1 1 2 2 
C97 Brian 1 1 1 1 
C98 Christine 1 1 2 5 
C99 Lillian 1 1 2 6 
*/