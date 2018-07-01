/*
	Description: This script contains CREATE statements of views/functions/stored procedures
	@author: Mostafa Elsheikh (@Sasa94s)
*/

-- A view of all certifications granted to each reviewer
CREATE OR ALTER VIEW Certification_Details
AS (
	SELECT	r.email AS [Reviewer],
			p.title AS [Project Name],
			p.earn AS [Earn]
			rc.certified_date AS [Certified]
	FROM Reviewer AS r
	JOIN Reviewer_Certifications AS rc
	ON r.email = rc.reviewer_email
	JOIN Projects AS p
	ON p.id = rc.project_id
)

-- A function for retrieving certification details of a specific reviewer
CREATE OR ALTER FUNCTION Get_Certifications_Of_Reviewer(@email varchar(150))
RETURNS TABLE
AS
RETURN (
	SELECT	cd.[Project Name],
			cd.[Earn],
			cd.[Certified]
	FROM Certification_Details cd
	WHERE cd.reviewer = @email
)

-- A view of all reviews of each project in each month of each year
CREATE OR ALTER VIEW Reviewer_Monthly_Earnings_Per_Project
AS (
	SELECT	DATE_PART('YEAR', s.submission_time) AS [Year],
			DATE_PART('MONTH', s.submission_time) AS [Month],
			s.reviewer_email AS [Reviewer Email],
			p.id AS [Project ID],
			SUM(p.earn) AS Earnings
	FROM Submissions AS s
	GROUP BY 1, 2, 3, 4
	ORDER BY 1 DESC, 2 DESC, 3 DESC, 4 DESC
)

-- Table-value Function: Returns Monthly earnings of a specific reviewer
CREATE OR ALTER FUNCTION Monthly_Earnings(@email varchar(150))
RETURNS TABLE
AS
RETURN (
	SELECT	rme.[Year],
			rme.[Month],
			rme.[Project ID],
			rme.[Earnings]
	FROM Reviewer_Monthly_Earnings_Per_Project AS rme
	WHERE rme.[Reviewer Email] = @email
)

-- Scalar Function: Returns Reviewer earnings of specific year, month
CREATE OR ALTER FUNCTION Total_Monthly_Earnings(@email varchar(150), @year int, @month int)
RETURNS SMALLMONEY
AS
BEGIN
	RETURN (
		SELECT SUM(rme.[Earnings]) AS Earnings
		FROM Reviewer_Monthly_Earnings_Per_Project AS rme
		WHERE	rme.[Year] = @year
		AND		rme.[Month] = @month
		AND		rme.[Reviewer Email] = @email
		GROUP BY rme.[Year], rme.[Month]
	)
END