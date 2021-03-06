USE [PR]
GO
ALTER TABLE [dbo].[Submission] DROP CONSTRAINT [FK_Submission_Students]
GO
ALTER TABLE [dbo].[Submission] DROP CONSTRAINT [FK_Submission_Reviewer]
GO
ALTER TABLE [dbo].[Submission] DROP CONSTRAINT [FK_Submission_Projects]
GO
ALTER TABLE [dbo].[Submission] DROP CONSTRAINT [FK_Submission_Project_Review]
GO
ALTER TABLE [dbo].[Specifications] DROP CONSTRAINT [FK_Specifications_Projects]
GO
ALTER TABLE [dbo].[Reviewer_Certifications] DROP CONSTRAINT [FK_Reviewer_Certifications_Reviewer]
GO
ALTER TABLE [dbo].[Reviewer_Certifications] DROP CONSTRAINT [FK_Reviewer_Certifications_Projects]
GO
ALTER TABLE [dbo].[Ratings] DROP CONSTRAINT [FK_Ratings_Submission]
GO
ALTER TABLE [dbo].[Projects] DROP CONSTRAINT [FK_Projects_Courses]
GO
ALTER TABLE [dbo].[Project_Files] DROP CONSTRAINT [FK_Project_Files_Submission1]
GO
ALTER TABLE [dbo].[Opportunity] DROP CONSTRAINT [FK_Opportunity_Reviewer]
GO
ALTER TABLE [dbo].[Enrollments] DROP CONSTRAINT [FK_Enrollments_Students]
GO
ALTER TABLE [dbo].[Enrollments] DROP CONSTRAINT [FK_Enrollments_Courses]
GO
ALTER TABLE [dbo].[Code_Review] DROP CONSTRAINT [FK_Code_Review_Project_Files]
GO
/****** Object:  Table [dbo].[Submission]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Submission]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Students]
GO
/****** Object:  Table [dbo].[Specifications]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Specifications]
GO
/****** Object:  Table [dbo].[Reviewer_Certifications]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Reviewer_Certifications]
GO
/****** Object:  Table [dbo].[Reviewer]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Reviewer]
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Ratings]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Projects]
GO
/****** Object:  Table [dbo].[Project_Review]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Project_Review]
GO
/****** Object:  Table [dbo].[Project_Files]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Project_Files]
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Opportunity]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Enrollments]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Courses]
GO
/****** Object:  Table [dbo].[Code_Review]    Script Date: 7/1/2018 5:18:53 PM ******/
DROP TABLE [dbo].[Code_Review]
GO
/****** Object:  Table [dbo].[Code_Review]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Code_Review](
	[line_number] [int] NOT NULL,
	[type] [int] NOT NULL,
	[comment] [varchar](max) NOT NULL,
	[file_id] [int] NOT NULL,
 CONSTRAINT [PK_Code_Review] PRIMARY KEY CLUSTERED 
(
	[line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[id] [int] NOT NULL,
	[title] [varchar](150) NOT NULL,
	[description] [varchar](150) NOT NULL,
	[prerequisites] [varchar](150) NOT NULL,
	[overview] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[course_id] [int] NOT NULL,
	[student_email] [varchar](150) NOT NULL,
	[enrollment_date] [datetime] NULL,
	[progress] [int] NULL,
 CONSTRAINT [PK_Enrollments] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[student_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opportunity](
	[id] [int] NOT NULL,
	[reviewer_email] [varchar](150) NOT NULL,
	[duration] [int] NOT NULL,
	[end_date] [datetime] NOT NULL,
 CONSTRAINT [PK_Opportunity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project_Files]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project_Files](
	[id] [int] NOT NULL,
	[path] [varchar](150) NOT NULL,
	[file_content] [varbinary](max) NOT NULL,
	[submission_id] [int] NOT NULL,
 CONSTRAINT [PK_Project_Files] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project_Review]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project_Review](
	[id] [int] NOT NULL,
	[comment] [varchar](max) NOT NULL,
	[passed] [bit] NOT NULL,
 CONSTRAINT [PK_Project_Review] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[id] [int] NOT NULL,
	[title] [varchar](150) NOT NULL,
	[course_id] [int] NOT NULL,
	[rubric] [varchar](max) NULL,
	[earn] [smallmoney] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[id] [int] NOT NULL,
	[rate] [smallint] NULL,
	[comment] [nchar](10) NULL,
 CONSTRAINT [PK_Ratings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviewer]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviewer](
	[email] [varchar](150) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[paypal] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Reviewer] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviewer_Certifications]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviewer_Certifications](
	[reviewer_email] [varchar](150) NOT NULL,
	[project_id] [int] NOT NULL,
	[certified_date] [datetime] NOT NULL,
 CONSTRAINT [PK_Reviewer_Certifications_1] PRIMARY KEY CLUSTERED 
(
	[reviewer_email] ASC,
	[project_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specifications]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specifications](
	[id] [int] NOT NULL,
	[project_id] [int] NOT NULL,
	[requirement] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Specifications] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[email] [varchar](150) NOT NULL,
	[first_name] [nchar](10) NOT NULL,
	[last_name] [nchar](10) NOT NULL,
	[dob] [datetime] NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Submission]    Script Date: 7/1/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Submission](
	[id] [int] NOT NULL,
	[project_id] [int] NOT NULL,
	[student_email] [varchar](150) NOT NULL,
	[submission_time] [datetime] NOT NULL,
	[reviewer_email] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Submission] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Code_Review]  WITH CHECK ADD  CONSTRAINT [FK_Code_Review_Project_Files] FOREIGN KEY([file_id])
REFERENCES [dbo].[Project_Files] ([id])
GO
ALTER TABLE [dbo].[Code_Review] CHECK CONSTRAINT [FK_Code_Review_Project_Files]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Courses]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Students] FOREIGN KEY([student_email])
REFERENCES [dbo].[Students] ([email])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Students]
GO
ALTER TABLE [dbo].[Opportunity]  WITH CHECK ADD  CONSTRAINT [FK_Opportunity_Reviewer] FOREIGN KEY([reviewer_email])
REFERENCES [dbo].[Reviewer] ([email])
GO
ALTER TABLE [dbo].[Opportunity] CHECK CONSTRAINT [FK_Opportunity_Reviewer]
GO
ALTER TABLE [dbo].[Project_Files]  WITH CHECK ADD  CONSTRAINT [FK_Project_Files_Submission1] FOREIGN KEY([submission_id])
REFERENCES [dbo].[Submission] ([id])
GO
ALTER TABLE [dbo].[Project_Files] CHECK CONSTRAINT [FK_Project_Files_Submission1]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Courses]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [FK_Ratings_Submission] FOREIGN KEY([id])
REFERENCES [dbo].[Submission] ([id])
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [FK_Ratings_Submission]
GO
ALTER TABLE [dbo].[Reviewer_Certifications]  WITH CHECK ADD  CONSTRAINT [FK_Reviewer_Certifications_Projects] FOREIGN KEY([project_id])
REFERENCES [dbo].[Projects] ([id])
GO
ALTER TABLE [dbo].[Reviewer_Certifications] CHECK CONSTRAINT [FK_Reviewer_Certifications_Projects]
GO
ALTER TABLE [dbo].[Reviewer_Certifications]  WITH CHECK ADD  CONSTRAINT [FK_Reviewer_Certifications_Reviewer] FOREIGN KEY([reviewer_email])
REFERENCES [dbo].[Reviewer] ([email])
GO
ALTER TABLE [dbo].[Reviewer_Certifications] CHECK CONSTRAINT [FK_Reviewer_Certifications_Reviewer]
GO
ALTER TABLE [dbo].[Specifications]  WITH CHECK ADD  CONSTRAINT [FK_Specifications_Projects] FOREIGN KEY([project_id])
REFERENCES [dbo].[Projects] ([id])
GO
ALTER TABLE [dbo].[Specifications] CHECK CONSTRAINT [FK_Specifications_Projects]
GO
ALTER TABLE [dbo].[Submission]  WITH CHECK ADD  CONSTRAINT [FK_Submission_Project_Review] FOREIGN KEY([id])
REFERENCES [dbo].[Project_Review] ([id])
GO
ALTER TABLE [dbo].[Submission] CHECK CONSTRAINT [FK_Submission_Project_Review]
GO
ALTER TABLE [dbo].[Submission]  WITH CHECK ADD  CONSTRAINT [FK_Submission_Projects] FOREIGN KEY([project_id])
REFERENCES [dbo].[Projects] ([id])
GO
ALTER TABLE [dbo].[Submission] CHECK CONSTRAINT [FK_Submission_Projects]
GO
ALTER TABLE [dbo].[Submission]  WITH CHECK ADD  CONSTRAINT [FK_Submission_Reviewer] FOREIGN KEY([reviewer_email])
REFERENCES [dbo].[Reviewer] ([email])
GO
ALTER TABLE [dbo].[Submission] CHECK CONSTRAINT [FK_Submission_Reviewer]
GO
ALTER TABLE [dbo].[Submission]  WITH CHECK ADD  CONSTRAINT [FK_Submission_Students] FOREIGN KEY([student_email])
REFERENCES [dbo].[Students] ([email])
GO
ALTER TABLE [dbo].[Submission] CHECK CONSTRAINT [FK_Submission_Students]
GO
