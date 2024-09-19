-- Lab10 Exercise (22/2/24)

Create Database Lab10;

Use Lab10;
 
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


--Q1)	List all female students enroll in Degree course, order in descending by student’s name. 
--a) Use Subquery
SElect * from Student where CourseID 
in (Select CourseID from Course 
where Course.Name = 'Degree') and 
(Student.Gender = 'Female')
Order by Student.Name DESC;

--or this way to join columns from course table 
Select * from Student, Course where Student.CourseID = Course.CourseID
and Student.CourseID in (Select CourseID from Course where Name = 'Degree')
and (Student.Gender = 'Female') Order by Student.Name DESC;

--b) Use join (with / without the keyword 'join')
Select * from Student inner join Course 
on Student.CourseID = Course.CourseID
where Course.Name = 'Degree' and Student.Gender = 'Female'
order by student.Name DESC;

--without join

Select * from Student S, Course C 
where S.CourseID = C.CourseID
and S.Gender = 'Female' and C.Name = 'Degree'
order by S.Name DESC;




--Q2)	List all subjects where entry qualification is ‘5 credits in O Level’?order in ascending order 
--a) Use subquery
Select * from Subject where CourseId 
in (Select CourseID from Course 
where EntryQualification like '5 credits in 0 level')
order by Subeject.Name

--or this way to join columns from course table
Select * from Subject S, Course C 
where S.CourseID = C.CourseID and S.CourseID
in (Select C.CourseID from Course 
where C.EntryQualification = '5 credits in 0 level') 
order by Subject.Name;

--b) Use join (with / without the keyword 'join') 
--Without 'join'

Select * from Course, Subject
where Subject.Courseid = Course.Courseid
and Course.EntryQualification like '5 credits in 0 level'
order by Subject.Name;




--Q3)	List all subjects which belong to Degree or Master Course. 
--a) Use subquery
Select * from Subject where CourseID 
in (Select CourseID from Course where Name = 'Degree')
or CourseID in (Select CourseID from Course where Name = 'Master');

--or 

Select * from Subject where CourseID 
in (Select CourseID form Course where Name = 'Degree')
or CourseID in (Select CourseID from Course Where Name = 'Master');

--or

Select * from Subject where CourseID in
(Select CourseId from Course where Name in ('Degree', 'Master')):

--b)Use join (with / without the keyword 'join')
--Join
Select * from Subject 
inner join Course on Subject.CourseID = Course.CourseID
where Course.Name = 'Degree' or Course.Name = 'Master';

--Without join

Select * from course, Subject where Course.CourseID = Subject.CourseID
and (Course.Name = 'Degree' or Course.Name = 'Master');




--Q4)	Calculate the total number of subjects for each course. (*Hint: use Count & Group by)
Select CourseID, COUNT(SubjectID) as NumOfSubjectPerCourse 
from Subject group by CourseID;

--use join and group by course name as well if you want to show course name too,
--because course name column is in course tbale, not in subject table
Select C.CourseID, C.Name, COUNT(S.SubjectID)
as NumOfSubjectPerCourse from Course C join Subject S 
on S.CourseID = C.CourseID group by C.CourseID, C.Name;




--Q5)	Calculate the total number of students for each course. (*Hint: use Count & Group by)
Select CourseID COUNT(StudentID)
as NumOfStudentPerCourse from Student group by CourseID;

--use join and group by course.name as well if u want to show course name too
Select C.CourseID, C.Name, COUNT(S.StudentID) 
as NumOfStudentPerCourse
from Course C, Student S where C.CourseID = S.CourseId 
group by C.CourseID, C.Name;




--Q6)	Show a list of students whose age is more than the average age of all students.
Select * from Student 
where YEAR(GETDATE()) - YEAR(DOB) > 
(Select AVG(YEAR(GETDATE()) - YEAR(DOB)) from StudentID);

--or
Select * from Student where DATEDIFF(YEAR, DOB, GETDATE()) >
(Select AVG (DATEDIFF(YEAR, DOB, GETDATE())) from Student);



--Q7)	List all students in descending order of age.
Select *, DATEDIFF(YEAR,DOB, GETDATE()) as Age from Student
order by DATEDIFF(YEAR,DOB, GETDATE()) DESC;




--Q8)	Show a list of course which has more than 1 student. (*Hint: use Count & Group by & Having)
--Use join to show course name as well
Select C.CourseID, CName, COUNT(S.StudentID) as NumOfStudent
from Student S join Course C on S.CourseID = C.CourseID
Group by C.CourseID, C.Name having COUNT(S.SubjectID) > 1;




--Q9)	Show a list of course which has exactly 1 subject. (*Hint: use Count & Group by & Having)
Select C.CourseID,C.Name, COUNT(S.SubjectID) as SubjectNumber
from Course C inner join Subject S on C.CourseID = S.CourseID
Group by C.CourseID, C.Name having COUNT(S.SubjectID) = 1;






























