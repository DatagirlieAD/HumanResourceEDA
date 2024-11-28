Create database HR_Analytics;
Use HR_Analytics;

SELECT *
FROM
    human_resources;

-- EXPLORATORY DATA ANALYSIS and DATA CLEANING;
-- Changing some column and row names using the UPDATE and Alter table functions.

Alter Table human_resources
Change Column ï»¿id employee_id varchar(20) Null;

Update human_resources
Set Race = 'Mixed Race'
Where Race = 'Two or More Races';

Update human_resources
Set Race = 'African American'
Where Race = 'Black or African American';

Select race 
From human_resources;


-- Changing the dates coloumns from text to date format using string to date function then later use date function to change to SQL date format

Describe Human_Resources;

-- Changed the SQL security update to allow me to change formates in my table. After this security update would be changed to default settings
Set sql_safe_updates = 0;

Update Human_Resources
Set birthdate = Case
	When birthdate like '%/%' Then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d') 
    When birthdate like '%-%' Then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    Else Null
End;    

Select birthdate
From Human_Resources;

-- Now to actually change the column format to SQL date format:

Alter Table Human_Resources 
Modify Column hire_date Date;

Update Human_Resources
Set hire_date = Case
	When hire_date like '%/%' Then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d') 
    When hire_date like '%-%' Then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    Else Null
End;    

Select hire_date
From Human_Resources;

-- Now to actually change the column format to SQL date format:

Alter Table Human_Resources 
Modify Column hire_date Date;

-- The termdate coloumn is already having date values but with timestamps so I only need to remove the timstamps values and change the column format. 

Select termdate 
From Human_Resources;

Set sql_mode ='Allow_Invalid_Dates';

Update Human_Resources
Set termdate = if(termdate is not null and termdate != '',
				   Date(str_to_date(termdate, '%Y-%m-%d')),
                   Null)
Where termdate is not null;

Select termdate 
From Human_Resources;

Alter table Human_Resources
Modify Column termdate date;

Select termdate 
From Human_Resources;

Describe Human_Resources;

Select *
From Human_Resources;



-- Added an Age column to the table using the Alter table function:

Alter Table Human_Resources
Add Column age int;

Select *
From Human_Resources;

Update Human_Resources 
Set age = timestampdiff(Year, birthdate, curdate());

Select birthdate, age
From Human_Resources;



-- To remove outliers and anomalies in the table specifically age column:

Select 
      min(age) as youngest,
      max(age) as oldest
From Human_Resources;

Select count(*) 
From Human_Resources 
Where age< 18;




-- Data Analysis Questions and Answers:

Select * 
From Human_Resources;
-- Total number of active employees
    
     Select 
			department, 
            count(*) as Total_Employees,
            count( Case when termdate is null then 1 end) as Active_Employees
     From Human_Resources
     Group by department
     Order by Total_Employees;
     
-- 1. What is the gender breakdown of employees in the company?
      
      Select gender, count(*) as Headcount
      From Human_Resources
      Where age >= 18 and termdate is null
      Group by gender;
      
-- 2. What is the race/ethnicity breakdown of employees?

      Select race, count(*) as Headcount
      From Human_Resources
      Where age >= 18 and termdate is null
      Group by race
      Order by count(*) Desc;

-- 3. What is the age distribution of employees across the company by gender?

     Select min(age) as youngest,
            max(age) as oldest
	 From Human_Resources
	 Where age >= 18 and termdate is null;
     
	Select 
		Case
			When age>= 18 and age <= 25 then '18-24'
            When age>= 26 and age <= 35 then '26-35'
            When age>= 36 and age <= 45 then '36-45'
            When age>= 46 and age <= 55 then '46-55'
            When age>= 56 and age <= 65 then '56-65'
            Else '66+'
		End as age_bracket, count(*) as Headcount
	From Human_Resources
    Where age >= 18 and termdate is null
    Group by age_bracket
    Order by age_bracket;
    
     Select 
		Case
			When age>= 18 and age <= 25 then '18-24'
            When age>= 26 and age <= 35 then '26-35'
            When age>= 36 and age <= 45 then '36-45'
            When age>= 46 and age <= 55 then '46-55'
            When age>= 56 and age <= 65 then '56-65'
            Else '66+'
		End as age_bracket, gender, count(*) as Headcount
	From Human_Resources
    Where age >= 18 and termdate is null
    Group by age_bracket, gender
    Order by age_bracket;
    
-- 4. How many employees work at in-person (Headquarters) versus remote locations?
       
	 Select location, count(*) as Headcount
	 From Human_Resources
     Where age >= 18 and termdate is null
     Group by location;
       
-- 5. What is the average length of employment for terminated employees? 

      Select 
         avg(datediff(hire_date, termdate)/365) as employment_workspan
	  From Human_Resources
      Where termdate is not null 
        -- and hire_date is not null
        and age >= 18;
      
-- 6. How does the gender distribution vary across departments and job titles?
      
      Select  department, gender, count(*) as Headcount
      From Human_Resources
      Where age >= 18 and termdate is null
      Group by department, gender
      Order by department;
      
-- 7. What is the distribution of job titles across the company?
      
      Select jobtitle, count(*) as Headcount
      From Human_Resources
      Where age >= 18 and termdate is null
      Group by jobtitle
      Order by jobtitle Desc;
      
-- 8. Which department has the highest turnover rate?
      			
      Select 	
	    department, 
        count(case when termdate is not null then 1 end) as redundant_employees, 
             count(*) as total_employees,
             (count(case when termdate is not null then 1 end)/count(*)) * 100 as turnover_rate
      From Human_Resources
      Where age >= 18
      Group by department
      Order by turnover_rate Desc;
          
-- 9. What is the distribution of employees across locations by City and State?
	 
      Select location_state, count(*) as State_count
      From Human_Resources
      Where age >= 18 and termdate is null
      Group by location_state
      Order by State_count Desc;
      
-- 10. How has the company's employee count changed over time following the hire and term date patterns?

	   Select 
			Year(hire_date) as year,
            count(case when termdate is null then 1 end) as Active_employees,
            count(case when termdate is not null then 1 end) as redundant_employees
	   From Human_Resources
       Where age >= 18
       Group by year(hire_date)
       Order by year asc;
                
-- 11. What is the tenure distribution for each department?
		
		Select 
			  department, 
              avg(datediff(ifnull(termdate, curdate()), hire_date)/365.25) as average_tenure
        From Human_Resources
        Where age >=18
        Group by department
        Order by average_tenure desc;





