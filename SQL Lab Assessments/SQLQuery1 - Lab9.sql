--Lab 9 Exercise (22/2/24)

Create Database Lab9;

Use Lab9;
 
CREATE TABLE Course (
CourseID nvarchar(50) NOT NULL PRIMARY KEY,
Name nvarchar(50), 
EntryQualification nvarchar(50)
);
 
Create Table Student (
StudentID nvarchar(50) NOT NULL PRIMARY KEY,
Name nvarchar(50) NOT NULL, 
Gender nvarchar(50), DOB date,
CourseID nvarchar(50) FOREIGN KEY REFERENCES Course(CourseID)
);
 
Create Table Subject (
SubjectID nvarchar(50) NOT NULL PRIMARY KEY,
Name nvarchar(50) NOT NULL,
CourseID nvarchar(50) FOREIGN KEY REFERENCES Course(CourseID) 
);
 
insert into Course values
('C01','Diploma','3 credits in O Level'),
('C02','Degree','3 credits in A Level'),
('C03','Master','Degree in any computing field'),
('C04','Foundation','5 credits in O Level');
 
insert into Student values
('ST01','Helen','Female','2 Feb 1999','C01'),
('ST02','Karen','Female','15 September 2000','C02'),
('ST03','Peter','Male','28 April 1997','C02'),
('ST04','Shaun','Male','30 June 2001','C03');
 
insert into Subject values
('SU01','SAD','C01'),
('SU02','IDB','C01'),
('SU03','ISWE','C02'),
('SU04','CPP','C02'),
('SU05','Java','C03'),
('SU06','NNT','C04'),
('SU07','DAS','C04');
 

--Q4) Generate the database diagram
Alter Authorization on Database :: Lab9 to [sa];


--Q5)	Display StudentID, Name and Age (derive Age from DOB) hint: use getDate(), dateDiff()
Select StudentID, NAME, 
DATEDIFF(year,DOB,GETDATE()) as Age from Student;

-- v this is the more specific version

SELECT StudentID, Name, 
FLOOR(DATEDIFF(YEAR, DOB, GETDATE()) - CASE WHEN MONTH(DOB) > MONTH(GETDATE()) 
THEN 1 ELSE 0 END) AS Age FROM Student;

--Q6)	List all students whose age is more than 18
Select * from Student where 
DATEDIFF(YEAR, DOB GETDATE ()) > 18;

--or this to show the age as well

Select *, DATEDIFF(YEAR, DOB GETDATE ()) as Age from Student
where (DATEDIFF(YEAR, DOB, GETDATE ()) > 18);
--Execute both queries above to observe the difference 


--Q7)	Inner Join Course, Student and Subject table
Select * from Course 
INNER JOIN Student on Student.CourseID = Course.CourseID
INNER JOIN Subject on Course.CourseID = Subject.CourseID;
--inner join 3 tables will only show the matched values from ALL the 3 tables,
--therefore, C04 (Foundation) is not shown since there's no student for
--this course, thus the subjects (SU06 & SU07) for foundation are not shown as well


--Q8)	Join all columns from Course and Subject table without using the keyword ‘JOIN’
Select * from Course C, Subject s where C.CourseID = S.CourseID;

--or if using join

Select * from Course C, inner join Subject s
on C.CourseID = S.CourseID;
-- this will show the course and subject which belongs to that course


--Q9)	Join all columns from Course, Student and Subject table without using the keyword ‘JOIN’
--same with Q7 but no use 'join'
Select * from Subject, Course, Student
where Course.CourseID = Subject.CourseID and
Course.CourseID = Student.CourseID;

-- or

Select * from Course C, Subject S, Student Z
where C.CourseID = S.CourseID and
C.CourseID = Z.CourseID;


--Q10)	Left Join Course with Student table, order by Course name (Course is left, Student is right)
Select * from Course 
left join Student on Course.Name = Student.Name
-- left join will select everything from table 1(left table) which is Course
--nulls will be created because no student enrol in Foundation (C04)



--Q11)	Right Join Course with Student table, order by Student name (Course is left, Student is right)
Select * from Course right join Student
on Course.CourseID = Student.CourseID
order by Student.Name;
--right join will select everything from the table 2(right table) which is Student
--so foundation course won't be shown since there;s Student in this course
Select * from Course right join Student
on C.CourseID = S.CourseID
order by S.Name;



--Q12)	Show the course where no student enrolled in. (can use join / subquery)
Select * from Course left join Student
on Course.CourseID = Student.CourseID
where Student.StudentID is null;
--compare this result with the on in Q10 for better understanding

Select * from Course 
where CourseID not in (Select CourseID from Student);
--using sub-query with not exists
(Select * from Student 
where Course.CourseID = Student.CourseID);


--Q13)	Extra question - Show students who enrolled in diploma course (can use join / subquery)
Select * from course join Student
on Course.CourseID = Student.CourseID
where Course.Name = 'diploma'
--or 
Select * from Course C, Student S
where C.CourseID = S.CourseID and C.Name = 'diploma';
--or 
Select * from Student S where S.CourseID in
(Select C.CourseID from Course C where C.Name = 'diploma');


--Q14)	Extra question - Show the subjects which belongs to diploma course (can use join / subquery)
Select * from Subject
where CourseID in  
(Select course.courseID from course where course.name = 'Diploma');
--or 
Select * from Subject inner join course 
on Subject.courseID = course.courseID
where course.name = 'Diploma'












