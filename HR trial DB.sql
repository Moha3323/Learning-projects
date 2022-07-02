use master 
go

create database  HR_TRIAL
go

use HR_TRIAL
go


if (exists (SELECT * 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_NAME = 'Regions'))
begin
	   PRINT 'Database Table Exists' 
end
else
  begin
create table Regions
(region_id  int primary key identity(1,1),
 region_name   nvarchar(20) unique  not null)
 end

if (exists (SELECT * 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_NAME = 'Countries'))
begin
	   PRINT 'Database Table Exists' 
end
else
  begin
create table Countries
(country_id  int primary key identity(1,1),
 country_name   nvarchar(20) unique  not null
 ,region_id int  not null
 )
 end


if (exists (SELECT * 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_NAME = 'Locations'))
begin
	   PRINT 'Database Table Exists' 
end
else
  begin
create table Locations
(location_id  int primary key identity(1,1),
 street_address  nvarchar(50) ,
 posta_code   int not null   ,
 city           nvarchar(30)  not null,
 state_province  nvarchar(30),
 country_id       int not null )
 end



if (exists (SELECT * 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_NAME = 'Departments'))
begin
	   PRINT 'Database Table Exists' 
end
else
  begin
create table Departments
(department_id  int primary key identity(1,1),
 department_name   nvarchar(20) unique  not null,
 location_id      int not null 
 )
 
 end





if (exists (SELECT * 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_NAME = 'Jobs'))
begin
	   PRINT 'Database Table Exists' 
end
else
  begin
create table Jobs
(job_id  int primary key identity(1,1),
 job_title   nvarchar(20) unique  not null,
 min_salary     int not null,
 max_salary     int not null )
 end



if (exists (SELECT * 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_NAME = 'Employees'))
begin
	   PRINT 'Database Table Exists' 
end
else
  begin
create table Employees
(employee_id  int primary key identity(1,1),
 first_name   nvarchar(20)   not null,
 last_name   nvarchar(20)   not null,
 email         nvarchar(50)   not null,
 phone_number  nvarchar(20)    not null ,
 hire_date      date,
 job_id        int    not null,
 salary        int not null,
 manager_id     int  not null,
 department_id  int  not null   )
 end




if (exists (SELECT * 
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE'
	AND TABLE_NAME = 'Dependents'))
begin
	   PRINT 'Database Table Exists' 
end
else
  begin
create table Dependents
(dependent_id  int primary key identity(1,1),
 first_name   nvarchar(20) unique  not null,
 last_name     nvarchar(20) unique  not null,
 relations     nvarchar(1) ,
 employee_id    int not null unique )
 end

ALTER TABLE Countries
ADD FOREIGN KEY (region_id) REFERENCES Regions(region_id); 

ALTER TABLE Locations
ADD FOREIGN KEY (country_id) REFERENCES Countries(country_id); 

ALTER TABLE Departments
ADD FOREIGN KEY (location_id) REFERENCES Locations(location_id); 


ALTER TABLE Employees
ADD FOREIGN KEY (department_id) REFERENCES Departments(department_id); 

ALTER TABLE Employees
ADD FOREIGN KEY (job_id) REFERENCES Jobs(job_id); 

ALTER TABLE Employees
ADD FOREIGN KEY (manager_id) REFERENCES Employees(employee_id); 
 
 ALTER TABLE Dependents
ADD FOREIGN KEY (employee_id) REFERENCES Employees(employee_id); 


alter table jobs add constraint check_job_salary
check(min_salary<max_salary)

alter table Dependents add constraint check_relations
check(relations in('m','s'))


/*
use master 
go
drop database HR_TRIAL
*/


/*alter table yourTableName AUTO_INCREMENT=1;
truncate table Regions; */