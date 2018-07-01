-- Project_files Insert Procedure
create or alter proc sp_insert_project_files
@id int,
@path varchar(150),
@file_content varbinary(max),
@submission_id int
as
begin
INSERT INTO [dbo].[Project_Files]
           ([id]
           ,[path]
           ,[file_content]
           ,[submission_id])
VALUES(@id,@path,@file_content,@submission_id)         
end
go

-- Project_files update procedure
create or alter proc sp_update_project_files
@id int,
@path varchar(150),
@file_content varbinary(max), 
@submission_id int
as 
begin
UPDATE [dbo].[Project_Files]
SET [path] = @path,
    [file_content] = @file_content,
    [submission_id] = @submission_id
 WHERE id=@id
end
go

-- Project_files delete procedure
create or alter proc sp_delete_project_files
@id int
as 
begin
delete from [dbo].[Project_Files]
where id = @id
end
go

-- Project_files selectAll procedure
create or alter proc sp_selectAll_project_files
as 
begin
select * from [dbo].[Project_Files]
end
go

-- Project_files selectById procedure
create or alter proc sp_selectById_project_files
@id int
as
begin
select * from [dbo].[Project_Files]
where id=@id
end
go
 ----------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------
-- Code_Review Insert procedure
create or alter proc sp_insert_Code_Review
@line_number int,
@type int,
@comment varchar(max),
@file_id int
as 
begin
INSERT INTO [dbo].[Code_Review]
           ([line_number]
           ,[type]
           ,[comment]
           ,[file_id])
VALUES (@line_number,@type,@comment,@file_id)
end
go

-- Code_Review Update procedure
create or alter proc sp_update_Code_Review
@id int,
@type int,
@comment varchar(max),
@file_id int
as 
begin
UPDATE [dbo].[Code_Review]
SET	[type] = @type,
    [comment] = @comment,
    [file_id] = @file_id
WHERE [dbo].Code_Review.line_number = @id     
end
go

-- Code_Review delete procedure
create or alter proc sp_delete_code_review
@id int
as 
begin
DELETE FROM [dbo].[Code_Review]
WHERE line_number = @id
end
go

-- Code_Review select all Procedure
create or alter proc sp_selectAll_code_review
as
begin
select * from [dbo].[Code_Review]
end
go

-- Code_Review Select by id Procedure
create or alter proc sp_selectById_code_review
@id int
as
begin
select * from [dbo].[Code_Review]
where line_number = @id
end
go
-----------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
-- Courses insert procedure
create or alter proc sp_insert_coursers
@id int,
@title varchar(150),
@description varchar(150),
@prerequisites varchar(150),
@overview varchar(150)
as
begin
INSERT INTO [dbo].[Courses]
([id]
,[title]
,[description]
,[prerequisites]
,[overview])
VALUES
(@id
,@title
,@description
,@prerequisites
,@overview)
end
go

-- Coursers update procedure
create or alter proc sp_update_courses
@id int,
@title varchar(150),
@description varchar(150),
@prerequisites varchar(150),
@overview varchar(150)
as
begin
UPDATE [dbo].[Courses]
SET 
@title = @title,
@description = @description,
@prerequisites = @prerequisites,
@overview = @overview
WHERE id=@id
end
go

-- Courses or alter delete procedure
create proc sp_delete_courses
@id int
as 
begin
delete from [dbo].[Courses]
where id=@id
end
go

-- Courses selectAll procedure
create or alter proc sp_selectAll_courses
as
begin
select * from [dbo].[Courses]
end
go

-- Courses selectyId procedure
create or alter proc sp_selectById_courses
@id int
as
begin
select * from [dbo].[Courses]
where id= @id
end
go
----------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

-- Enrollments insert procedure
create or alter proc sp_insert_enrollments
@course_id int,
@student_email varchar(150),
@enrollment_date datetime,
@progress int
as
begin
INSERT INTO [dbo].[Enrollments]
           ([course_id]
           ,[student_email]
           ,[enrollment_date]
           ,[progress])
VALUES
(@course_id,
@student_email,
@enrollment_date,
@progress)
end
go

-- Enrollments update procedure
create or alter proc sp_update_enrollments
@student_email varchar(150),
@course_id int,
@enrollment_date datetime,
@progress int
as 
begin
update [dbo].[Enrollments] 
set
enrollment_date = @enrollment_date,
progress = @progress
where Enrollments.course_id = @course_id and Enrollments.student_email = @student_email
end
go

-- Enrollments delete procedure
create or alter proc sp_delete_enrollments
@course_id int,
@student_email varchar(150)
as
begin
delete from [dbo].[Enrollments]
where Enrollments.course_id = @course_id and Enrollments.student_email = @student_email
end
go

-- Enrollments selectAll procedure
create or alter proc sp_selectAll_Enrollments
as
begin
select * from [dbo].[Enrollments]
end
go

-- Enrollments selectById procedure
 create or alter proc sp_selectById_Enrollments
 @course_id int,
 @student_email varchar(150)
 as
 begin
 select * from [dbo].[Enrollments]
 where Enrollments.course_id =@course_id and Enrollments.student_email = @student_email
 end
 go