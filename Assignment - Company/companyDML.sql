/*
Archie Paredes
CSC 355, DATABASE SYSTEMS
Septemeber 28, 2018
Company DML
*/

-- 1. Retrieve the names of all employees in department 5 who work more than 14 hours per week on the ProductX project.
SELECT  Fname, Lname
FROM    EMPLOYEE INNER JOIN DEPT_LOCATIONS
        ON EMPLOYEE.dno = DEPT_LOCATIONS.Dnumber
        INNER JOIN WORKS_ON
        ON EMPLOYEE.Ssn = WORKS_ON.Essn
WHERE EMPLOYEE.Dno = 5 AND WORKS_ON.Pno = 1 AND WORKS_ON.Hours > 14.0
GROUP BY Lname, Fname;

-- 2. List the names of all employees who have a son with the same first name as themselves.
SELECT Fname, Lname
FROM    EMPLOYEE INNER JOIN DEPENDENT
        ON EMPLOYEE.Ssn = DEPENDENT.Essn
WHERE Relationship = 'Son' AND EMPLOYEE.Fname = DEPENDENT.Dependent_name;

-- 3. Find the names of all employees who are directly supervised by 'Franklin T Wong'. Note: You must use Franklin’s name. Do not try to use his SSN instead.
SELECT Fname, Lname
FROM    Employee LEFT JOIN DEPARTMENT
        ON EMPLOYEE.Ssn = DEPARTMENT.mgr_ssn
WHERE EMPLOYEE.Fname != 'Franklin' AND EMPLOYEE.Minit != 'T' AND EMPLOYEE.Lname != 'Wong' AND EMPLOYEE.Dno = 5;

-- 4.  For each project, list the project name, project number, and the total hours per week (by all employees) spent on that project.
SELECT PROJECT.Pname, WORKS_ON.Pno, SUM(WORKS_ON.Hours)
FROM    PROJECT INNER JOIN WORKS_ON
        ON PROJECT.Pnumber = WORKS_ON.Pno 
GROUP BY PROJECT.Pname, WORKS_ON.Pno;

-- 5. Retrieve the names of all employees who work on at least one of the projects. (In other words, look at the list of projects given in the PROJECT table, and retrieve the names of all employees who work on at least one of them.)
SELECT EMPLOYEE.Fname, EMPLOYEE.Lname --, COUNT(PROJECT.Pname)
FROM    EMPLOYEE INNER JOIN PROJECT
        ON EMPLOYEE.Dno = PROJECT.Dnum 
GROUP BY EMPLOYEE.Lname, EMPLOYEE.Fname
HAVING COUNT(PROJECT.Pname) >= 1;

-- 6. Retrieve the names of all employees who do not work on any project.  (In other words, look at the list of projects given in the PROJECT table, and retrieve the names of all employees who work on none of them.)
SELECT EMPLOYEE.Fname, EMPLOYEE.Lname --, COUNT(PROJECT.Pname)
FROM    EMPLOYEE LEFT OUTER JOIN PROJECT
        ON EMPLOYEE.Dno = PROJECT.Dnum 
GROUP BY EMPLOYEE.Fname, EMPLOYEE.Lname
HAVING COUNT(PROJECT.Pname) <= 0;

-- 7. For each department, retrieve the department name and the average salary of all employees working in that department.  Order the output by department number in ascending order.
SELECT DEPARTMENT.Dname, AVG(EMPLOYEE.Salary)
From    EMPLOYEE LEFT JOIN DEPARTMENT
        ON EMPLOYEE.Dno = DEPARTMENT.Dnumber 
GROUP by DEPARTMENT.Dname
ORDER BY AVG(EMPLOYEE.Salary) ASC; 

-- 8. Retrieve the average salary of all female employees.  
SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE SEX = 'F';

-- 9. List the last names of all department managers who have no dependents.
SELECT Lname
FROM    EMPLOYEE LEFT OUTER JOIN DEPENDENT 
        ON EMPLOYEE.Ssn = DEPENDENT.Essn
WHERE DEPENDENT.Essn IS null;
        
-- 10. Find the average salary for employees who have exactly 3 dependents.
CREATE VIEW Fizz as -- creat practice
SELECT Employee.Salary
FROM    EMPLOYEE Inner JOIN DEPENDENT
   ON EMPLOYEE.Ssn = DEPENDENT.Essn 
   group by Employee.Salary 
HAVING COUNT(DEPENDENT.Essn) = 3;

SELECT AVG(SALARY) 
FROM Fizz;

-- 11. For each department whose average salary is greater than $42,000, retrieve the department name and the number of employees in that department.
SELECT DEPARTMENT.Dname, COUNT(DEPARTMENT.Dnumber)
From    EMPLOYEE LEFT JOIN DEPARTMENT
        ON EMPLOYEE.Dno = DEPARTMENT.Dnumber 
GROUP by DEPARTMENT.Dname
HAVING AVG(EMPLOYEE.Salary) > 42000; 

-- 12. Retrieve the names of all employees who work in the department that has the employee with the lowest salary among all employees.
SELECT EMPLOYEE.Fname, EMPLOYEE.Lname --, employee.dno
FROM    EMPLOYEE INNER JOIN DEPT_LOCATIONS
        ON EMPLOYEE.dno = DEPT_LOCATIONS.Dnumber
WHERE EMPLOYEE.dno =    (SELECT EMPLOYEE.Dno
                        FROM EMPLOYEE
                        WHERE Salary = (SELECT MIN(SALARY) 
                                        FROM EMPLOYEE));
                
-- 13. Retrieve the names of all employees whose supervisor has '888665555' for his/her SSN.
SELECT EMPLOYEE.Fname, EMPLOYEE.Lname
FROM EMPLOYEE
WHERE   EMPLOYEE.dno =  (SELECT DEPARTMENT.Dnumber
                        FROM DEPARTMENT
                        WHERE MGR_ssn = 888665555)
        AND EMPLOYEE.ssn !=  888665555;

-- 14. Find the total number of employees and the total number of dependents for every department 
--(the dependents for the department are the dependents of all employees working for that department).
SELECT DEPARTMENT.Dnumber, COUNT(EMPLOYEE.Ssn), COUNT(DEPENDENT.Essn)
FROM    EMPLOYEE LEFT OUTER JOIN DEPARTMENT
        ON EMPLOYEE.Dno = DEPARTMENT.Dnumber
        FULL JOIN DEPENDENT
        ON EMPLOYEE.Ssn = DEPENDENT.Essn
GROUP BY DEPARTMENT.Dnumber;


-- 15. Retrieve the names of employees whose salary is within $32,000 of the salary of the employee who is paid the most in the company 
-- (e.g., if the highest salary in the company is $85,000, retrieve the names of all employees that make at least $50,000.  Note that you don't 
-- have to worry about anyone making more than $82,000 because in this case $82,000 is the highest salary.). 
SELECT Fname, Lname, Salary
FROM EMPLOYEE
WHERE Salary < (SELECT MAX(SALARY) FROM EMPLOYEE) AND SALARY > (SELECT MAX(SALARY) FROM EMPLOYEE) - 32000
GROUP BY Lname, Fname, Salary;
