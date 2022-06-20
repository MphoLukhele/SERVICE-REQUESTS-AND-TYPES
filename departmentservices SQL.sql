
SELECT *
FROM [PROJECT].[dbo].[311-SERVICE REQUESTS]
SELECT * 
FROM [PROJECT].[dbo].[311-SERVICE TYPES];
 

---- SEPARATING DEPARTMENT AND THEIR SERVICE REQUESTS
SELECT count(dept) as deptcount, dept
FROM  [PROJECT].[dbo].[311-SERVICE REQUESTS]
GROUP BY dept
order by count(dept) desc;

----SEPARATING DEPARTMENT AND THEIR SERVICE REQUESTS and thier service type
SELECT [PROJECT].[dbo].[311-SERVICE TYPES].name, [PROJECT].[dbo].[311-SERVICE REQUESTS].dept,
COUNT ([PROJECT].[dbo].[311-SERVICE REQUESTS].dept) as deptservicecount
FROM [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].dept=
[PROJECT].[dbo].[311-SERVICE TYPES].dept
GROUP BY name, [PROJECT].[dbo].[311-SERVICE REQUESTS].dept;

--separating by the year requests was created by
SELECT count(dept) as deptcount, dept, year(created_on) as yearcreated
FROM  [PROJECT].[dbo].[311-SERVICE REQUESTS]
where year(created_on)= 2016
GROUP BY DEPT, year(created_on) 
order by count(dept) desc;

--SEPARATING DEPARTMENT with THEIR SERVICE REQUESTS and their service type by year 2016
select year(created_on) as yearcreated,
[PROJECT].[dbo].[311-SERVICE TYPES].name, [311-SERVICE REQUESTS].dept,
COUNT ([311-SERVICE REQUESTS].dept) as deptservicecount
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].dept=
[311-SERVICE TYPES].dept
where year(created_on)= 2016
GROUP BY name, [311-SERVICE REQUESTS].dept, year(created_on);

-- separating projects according to their status 
SELECT count(status) as statuscount,status
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
group by status
order by count(status) desc;

--SEPARATING DEPARTMENT with THEIR SERVICE REQUESTS and their status
select count(status) as statuscount,status,
[PROJECT].[dbo].[311-SERVICE TYPES].name, [311-SERVICE REQUESTS].dept
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].dept=
[311-SERVICE TYPES].dept
GROUP BY name, [311-SERVICE REQUESTS].dept, status
order by count(status) desc;

-- separating services by origin in 2016
SELECT count(origin) as origincount, origin,
year(created_on) as yearcreated
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
where year(created_on)= 2016
group by origin, year(created_on)
order by count(origin) desc;

-- separating services by origin with their ancestor-id their service ancestor name by year 2016
select year(created_on) as yearcreated,
[PROJECT].[dbo].[311-SERVICE TYPES].ancestor_name, [311-SERVICE REQUESTS].ancestor,
count(origin) as origincount, origin
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].ancestor=
[311-SERVICE TYPES].ancestor_id
where year(created_on)= 2016
GROUP BY [311-SERVICE REQUESTS].ancestor, year(created_on), [PROJECT].[dbo].[311-SERVICE TYPES].ancestor_name ,origin
order by origin desc;

--creating view to store data for vizualization
create view Departmentsservicerequests as
SELECT count(dept) as deptcount, dept
FROM  [PROJECT].[dbo].[311-SERVICE REQUESTS]
GROUP BY dept
--order by count(dept) desc;

create view Departmentservicerequestsandtypes as
SELECT [PROJECT].[dbo].[311-SERVICE TYPES].name, [PROJECT].[dbo].[311-SERVICE REQUESTS].dept,
COUNT ([PROJECT].[dbo].[311-SERVICE REQUESTS].dept) as deptservicecount
FROM [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].dept=
[PROJECT].[dbo].[311-SERVICE TYPES].dept
GROUP BY name, [PROJECT].[dbo].[311-SERVICE REQUESTS].dept;

create view servicestatus as 
SELECT count(status) as statuscount,status
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
group by status
--order by count(status) desc;

create view servicestatusandtype as 
select count(status) as statuscount,status,
[PROJECT].[dbo].[311-SERVICE TYPES].name, [311-SERVICE REQUESTS].dept
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].dept=
[311-SERVICE TYPES].dept
GROUP BY name, [311-SERVICE REQUESTS].dept, status
--order by count(status) desc;


create view service2016 as 
SELECT count(dept) as deptcount, dept, year(created_on) as yearcreated
FROM  [PROJECT].[dbo].[311-SERVICE REQUESTS]
where year(created_on)= 2016
GROUP BY DEPT, year(created_on) 
order by count(dept) desc;

create view Departmentservicerequestsandtypes2016 as 
select year(created_on) as yearcreated,
[PROJECT].[dbo].[311-SERVICE TYPES].name, [311-SERVICE REQUESTS].dept,
COUNT ([311-SERVICE REQUESTS].dept) as deptservicecount
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].dept=
[311-SERVICE TYPES].dept
where year(created_on)= 2016
GROUP BY name, [311-SERVICE REQUESTS].dept, year(created_on);

create view serviceorigin2016 as
SELECT count(origin) as origincount, origin,
year(created_on) as yearcreated
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
where year(created_on)= 2016
group by origin, year(created_on)
--order by count(origin) desc;

create view originid2016 as
select year(created_on) as yearcreated,
[PROJECT].[dbo].[311-SERVICE TYPES].ancestor_name, [311-SERVICE REQUESTS].ancestor,
count(origin) as origincount, origin
from [PROJECT].[dbo].[311-SERVICE REQUESTS]
inner join [PROJECT].[dbo].[311-SERVICE TYPES] on 
[PROJECT].[dbo].[311-SERVICE REQUESTS].ancestor=
[311-SERVICE TYPES].ancestor_id
where year(created_on)= 2016
GROUP BY [311-SERVICE REQUESTS].ancestor, year(created_on), [PROJECT].[dbo].[311-SERVICE TYPES].ancestor_name ,origin
--order by origin desc;