/*
	Description: This script contains CREATE statements of stored procedures
				regarding CRUD operations on tables:	- Revewer
														- Review_Certifications
														- Submission
														- Projects
	@author: Mostafa Elsheikh (@Sasa94s)
*/

-- Stored Procedure: CRUD Operations of [Reviewer] table
CREATE OR ALTER PROC sp_ReviewerInfo
(@type char(1),
@email varchar(150),
@name varchar(150) = NULL,
@paypal varchar(150) = NULL)
/*
CRUD Reviewer Info
Required: @type & @email
*/
AS
BEGIN
	/*
	Create Reviewer Info (Insert a row)
	Required: @email & @name & @paypal
	*/
	IF @type = 'C'
	BEGIN
		IF @email IS NULL OR @name IS NULL OR @paypal IS NULL
		BEGIN
			RETURN
		END

		INSERT INTO Reviewer (email, name, paypal)
		VALUES (@email, @name, @paypal)
	END

	/*
	Read Reviewer Info (Retrieve a row)
	Required: @email
	*/
	IF @type = 'R'
	BEGIN
		IF @email = NULL
		BEGIN
			RETURN
		END

		IF @name IS NULL AND @paypal IS NULL
		BEGIN
			SELECT	r.email,
					r.name,
					r.paypal
			FROM Reviewer AS r
			WHERE r.email = @email
		END
	END

	/*
	Update Reviewer Info (Modify a row)
	Required: @email & @name & @paypal
	*/
	IF @type = 'U' 
	BEGIN
		IF @email IS NULL OR @name IS NULL OR @paypal IS NULL
		BEGIN
			RETURN
		END
		
		UPDATE Reviewer
		SET name = ISNULL(@name, name),
			paypal = ISNULL(@paypal, paypal)
		WHERE email = @email
		AND (@name IS NOT NULL
			OR @paypal IS NOT NULL)
	END

	/*
	Delete Reviewer Info (Delete a row)
	Required: @email
	*/
	IF @type = 'D'
	BEGIN
		IF @email = NULL
		BEGIN
			RETURN
		END

		IF @name IS NULL AND @paypal IS NULL
		BEGIN
			DELETE FROM Reviewer
			WHERE email = @email
		END
	END
END
GO

--------------------------------------------------

-- Stored Procedure: CRUD Operations of [Reviewer_Certifications] table
CREATE OR ALTER PROC sp_ReviewerCertificationsInfo
(@type char(1),
@email varchar(150),
@project int
@date datetime = CURRENT_TIMESTAMP)
/*
CRUD Reviewer Certifications Info
Required: @type & @email & @project
*/
AS
BEGIN
	/*
	Create Reviewer Certification Info (Insert a row)
	Required: @email & @project
	*/
	IF @type = 'C'
	BEGIN
		IF @email IS NULL OR @project IS NULL
		BEGIN
			RETURN
		END

		INSERT INTO Reviewer_Certifications (reviewer_email, project_id, certified_date)
		VALUES (@email, @project, @date)
	END

	/*
	Read Reviewer Certification Info (Retrieve a row)
	Required: @email & @project
	*/
	IF @type = 'R'
	BEGIN
		IF @email IS NULL OR @project IS NULL
		BEGIN
			RETURN
		END

		SELECT	rc.reviewer_email,
				rc.project_id,
				rc.certified_date
		FROM Reviewer_Certifications AS rc
		WHERE rc.reviewer_email = @email
		AND rc.project_id = @project
	END

	/*
	Update Reviewer Certification Info (Modify a row)
	Required: @date
	*/
	IF @type = 'U' 
	BEGIN
		IF @date = NULL
		BEGIN
			RETURN
		END

		UPDATE Reviewer_Certifications
		SET certified_date = ISNULL(@date, certified_date)
		WHERE reviewer_email = @email
		AND project_id = @project
		AND @date IS NOT NULL
	END

	/*
	Delete Reviewer Certification Info (Delete a row)
	Required: @email
	*/
	IF @type = 'D' -- Delete Reviewer Info (Remove a row)
	BEGIN
		IF @email IS NULL
		BEGIN
			RETURN
		END

		DELETE FROM Reviewer_Certifications
		WHERE reviewer_email = @email
		AND project_id = @project
	END
END
GO

--------------------------------------------------

-- Stored Procedure: CRUD Operations of [Projects] table
CREATE OR ALTER PROC sp_ProjectsInfo
(@type char(1),
@project_id int,
@project_title varchar(150) = NULL,
@course_id int = NULL,
@project_rubric varchar(max) = NULL,
@project_cost smallmoney = NULL)
/*
CRUD Project Info
Required: @type, @project_id
*/
AS
BEGIN
	/*
	Create Project Info (Insert a row)
	Required: @project_id & @project_title & @course_id & @project_cost
	*/
	IF @type = 'C'
	BEGIN
		IF @project_id IS NULL OR @project_title IS NULL
			OR @course_id IS NULL OR @project_cost IS NULL
		BEGIN
			RETURN
		END

		IF @project_rubric IS NULL
		BEGIN
			INSERT INTO Projects (id, title, course_id, rubric, earn)
			VALUES (@project_id, @project_title, @course_id, @project_rubric, @project_cost)
		END
		ELSE
		BEGIN
			INSERT INTO Projects (id, title, course_id, rubric, earn)
			VALUES (@project_id, @project_title, @course_id, @project_rubric, @project_cost)
		END
	END

	/*
	Read Project Info (Retrieve a row)
	Required: @project_id
	*/
	IF @type = 'R'
	BEGIN
		IF @project_id IS NULL
		BEGIN
			RETURN
		END

		SELECT	p.id,
				p.title,
				p.course_id,
				p.rubric,
				p.earn
		FROM Projects AS p
		WHERE p.id = @project_id
	END

	/*
	Update Reviewer Info (Modify a row)
	Required: @project_id & (@project_title | @course_id | @project_rubric | @project_cost)
	*/
	IF @type = 'U' 
	BEGIN
		IF @project_id IS NULL
		BEGIN
			RETURN
		END

		UPDATE Projects
		SET title = ISNULL(@project_title, title),
			course_id = ISNULL(@course_id, course_id),
			rubric = ISNULL(@project_rubric, rubric),
			earn = ISNULL(@project_cost, earn)
		WHERE id = @project_id
		AND (@project_title IS NOT NULL
			OR @course_id IS NOT NULL
			OR @project_rubric IS NOT NULL
			OR @project_cost IS NOT NULL)
	END

	/*
	Delete Project Info (Delete a row)
	Required: @project_id
	*/
	IF @type = 'D'
	BEGIN
		IF @project_title IS NULL AND @course_id IS NULL
			AND @project_rubric IS NULL AND @project_cost IS NULL
		BEGIN
			DELETE FROM Projects
			WHERE id = @project_id
		END
	END
END
GO

--------------------------------------------------

-- Stored Procedure: CRUD Operations of [Submission] table
CREATE OR ALTER PROC sp_SubmissionInfo
(@type char(1),
@submission_id int,
@project_id int = NULL,
@student_email varchar(150) = NULL,
@submission_time datetime = NULL,
@reviewer_email varchar(150) = NULL)
/*
CRUD Project Info
Required: @type, @submission_id
*/
AS
BEGIN
	/*
	Create Submission Info (Insert a row)
	Required: @submission_id & @project_id & @student_email
	*/
	IF @type = 'C'
	BEGIN
		IF @submission_id IS NULL OR @project_id IS NULL OR @student_email IS NULL
		BEGIN
			RETURN
		END

		-- When a student submit his project
		INSERT INTO Submission (id, project_id, student_email, submission_time)
		VALUES (@submission_id, @project_id, @student_email, @submission_time)
	END

	/*
	Read Submission Info (Retrieve a row)
	Required: @submission_id
	*/
	IF @type = 'R'
	BEGIN
		IF @submission_id IS NULL
		BEGIN
			RETURN
		END

		SELECT	s.id,
				s.project_id,
				s.student_email,
				s.submission_time,
				s.reviewer_email
		FROM Submission AS s
		WHERE s.id = @submission_id
	END

	/*
	Update Submission Info (Modify a row)
	Required: @submission_id & (@project_id | @student_email | @submission_time | @reviewer_email)
	*/
	IF @type = 'U'
	BEGIN
		IF @project_id IS NULL
		BEGIN
			RETURN
		END

		UPDATE Submission
		SET project_id = ISNULL(@project_id, project_id),
			student_email = ISNULL(@student_email, student_email),
			submission_time = ISNULL(@submission_time, submission_time),
			reviewer_email = ISNULL(@reviewer_email, reviewer_email)
		WHERE id = @submission_id
		AND (@project_id IS NOT NULL
			OR @student_email IS NOT NULL
			OR @submission_time IS NOT NULL
			OR @reviewer_email IS NOT NULL)
	END

	/*
	Delete Project Info (Delete a row)
	Required: @submission_id
	*/
	IF @type = 'D'
	BEGIN
		IF @project_id IS NULL AND @student_email IS NULL
			AND @submission_time IS NULL AND @reviewer_email IS NULL
		BEGIN
			DELETE FROM Submission
			WHERE id = @submission_id
		END
	END
END
GO