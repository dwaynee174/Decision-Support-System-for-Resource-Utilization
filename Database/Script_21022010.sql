IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'TimeTableManagement')
	DROP DATABASE [TimeTableManagement]
GO

CREATE DATABASE [TimeTableManagement]  ON (NAME = N'TimeTableManagement_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL$SERVER\data\TimeTableManagement_Data.MDF' , SIZE = 1, FILEGROWTH = 10%) LOG ON (NAME = N'TimeTableManagement_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL$SERVER\data\TimeTableManagement_Log.LDF' , SIZE = 1, FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO

exec sp_dboption N'TimeTableManagement', N'autoclose', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'bulkcopy', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'trunc. log', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'torn page detection', N'true'
GO

exec sp_dboption N'TimeTableManagement', N'read only', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'dbo use', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'single', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'autoshrink', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'ANSI null default', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'recursive triggers', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'ANSI nulls', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'concat null yields null', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'cursor close on commit', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'default to local cursor', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'quoted identifier', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'ANSI warnings', N'false'
GO

exec sp_dboption N'TimeTableManagement', N'auto create statistics', N'true'
GO

exec sp_dboption N'TimeTableManagement', N'auto update statistics', N'true'
GO

if( (@@microsoftversion / power(2, 24) = 8) and (@@microsoftversion & 0xffff >= 724) )
	exec sp_dboption N'TimeTableManagement', N'db chaining', N'false'
GO

use [TimeTableManagement]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_generateTimetable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_generateTimetable]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_generateTimetable_bak]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_generateTimetable_bak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_search_subject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_search_subject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TTM_FacultyInformation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TTM_FacultyInformation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TTM_FacultySubjectMapping]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TTM_FacultySubjectMapping]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TTM_Semester]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TTM_Semester]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TTM_Subject]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TTM_Subject]
GO

if not exists (select * from dbo.sysusers where name = N'guest' and hasdbaccess = 1)
	EXEC sp_grantdbaccess N'guest'
GO

CREATE TABLE [dbo].[TTM_FacultyInformation] (
	[FacultyID] [int] NULL ,
	[Facultycode] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Facultyname] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Qualification] [int] NULL ,
	[Username] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Pasword] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WorkExperience] [decimal](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TTM_FacultySubjectMapping] (
	[MappingID] [int] NULL ,
	[FacultyID] [int] NULL ,
	[SemesterID] [int] NULL ,
	[SubjectID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TTM_Semester] (
	[SemesterID] [int] NULL ,
	[Semestercode] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Semestername] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Lectureperweek] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TTM_Subject] (
	[SubjectID] [int] IDENTITY (1, 1) NOT NULL ,
	[Subjectcode] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Subjectname] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SemesterID] [int] NULL ,
	[Marks] [numeric](18, 2) NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TTM_Subject] WITH NOCHECK ADD 
	CONSTRAINT [PK_TTM_Subject] PRIMARY KEY  CLUSTERED 
	(
		[SubjectID]
	)  ON [PRIMARY] 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*
ttm_generateTimetable 2
*/
CREATE procedure ttm_generateTimetable (@SemesterID	int)
AS
	BEGIN
		set nocount on 
		Declare @lectureperweek int
		Declare @lectureperday int
		Declare @totalsubject int
		Declare @noofweekdays int
		Declare @lecturecount int
		Declare @totalsubjectcount int
		
		Set @noofweekdays = 1
		set @totalsubject = 1
		Set @lecturecount = 1
		set @totalsubjectcount = 1
		
		Select @lectureperweek = lectureperweek from ttm_semester where semesterid = @SemesterID
		Select @lectureperday = @lectureperweek / 5
		
		Create table #temp (autoid int, subjectid int, subjectname varchar(200))	
		Create table #tempTimetable (weekid int, autoid int, subjectid int, subjectname varchar(200))
		
		DECLARE cursor_Subject CURSOR
		LOCAL fast_forward for 
		select subjectid, subjectname from ttm_subject where semesterid = @SemesterID
		
		Declare @subjectId int
		Declare @Subjectname varchar(200)
		Declare @autoid int
		
		set @autoid = 1
			
		open cursor_Subject
		fetch next from cursor_Subject
		into @subjectId, @Subjectname
		
		While @@Fetch_status <> -1
			Begin
				insert into #temp values(@autoid, @subjectID, @subjectname)
				
				set @autoid = @autoid + 1
				
				fetch next from cursor_Subject
				into @subjectId, @Subjectname	
			End
		deallocate cursor_Subject
		
		while @noofweekdays < 6
			begin
				if @lectureperday >= (@autoid - 1)
					begin
						while @lecturecount <= @lectureperweek
							BEGIN
								if exists (select autoid from #temp where autoid = @lecturecount)
									BEGIN
										insert into #tempTimetable 
										Select @noofweekdays, * from #temp where autoid = @lecturecount
									END
								else
									begin
										IF (@totalsubject > (@autoid-1))
											BEGIn
												set @totalsubject = 1
											end
										insert into #tempTimetable 
										Select @noofweekdays, * from #temp where autoid = @totalsubject
										
										Set @totalsubject = @totalsubject + 1
									end
									
								  if ((@lecturecount >= @lectureperday) AND ((@lecturecount % @lectureperday) = 0))
									begin
										set @noofweekdays = @noofweekdays + 1
									end
								Set @lecturecount = @lecturecount + 1
							END
						
						set @noofweekdays = @noofweekdays + 1
					end
				else
					begin
						while (@totalsubject <= (@autoid - 1)) AND (@noofweekdays < 6)
							BEGIN
								IF (@lecturecount <= @lectureperday) --AND (@noofweekdays < 6)
									begin
										insert into #tempTimetable 
										Select @noofweekdays, * from #temp where autoid = @totalsubject
										
										Set @totalsubject = @totalsubject + 1
									
										if @lecturecount = @lectureperday
											begin
												set @noofweekdays = @noofweekdays + 1
												Set @lecturecount = 0	
											end
										set @lecturecount = @lecturecount + 1
-- 										select @noofweekdays, @lecturecount
									end
								
							end
						if @totalsubject = @autoid
							begin
								set @totalsubject = 1
							end
-- 						set @noofweekdays = @noofweekdays + 1
					end
			end
		select CASE weekid 
			WHEN 1 THEN 'MONDAY'
			WHEN 2 THEN 'TUESDAY'
			WHEN 3 THEN 'WEDNESDAY'
			WHEN 4 THEN 'THURSDAY'
			WHEN 5 THEN 'FRIDAY' END AS [Day], [SubjectName]
		 from #tempTimetable 
	END	


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*
ttm_generateTimetable 1
*/
create procedure ttm_generateTimetable_bak (@SemesterID	int)
AS
	BEGIN
		set nocount on 
		Declare @lectureperweek int
		Declare @lectureperday int
		Declare @totalsubject int
		Declare @noofweekdays int
		Declare @lecturecount int
		Declare @totalsubjectcount int
		
		Set @noofweekdays = 1
		set @totalsubject = 0
		Set @lecturecount = 0
		set @totalsubjectcount = 1
		
		Select @lectureperweek = lectureperweek from ttm_semester where semesterid = @SemesterID
		Select @lectureperday = @lectureperweek / 5
		
		Create table #temp (autoid int, subjectid int, subjectname varchar(200))	
		Create table #tempTimetable (weekid int, autoid int, subjectid int, subjectname varchar(200))
		
		DECLARE cursor_Subject CURSOR
		LOCAL fast_forward for 
		select subjectid, subjectname from ttm_subject where semesterid = @SemesterID
		
		Declare @subjectId int
		Declare @Subjectname varchar(200)
		Declare @autoid int
		
		set @autoid = 1
			
		open cursor_Subject
		fetch next from cursor_Subject
		into @subjectId, @Subjectname
		
		While @@Fetch_status <> -1
			Begin
				insert into #temp values(@autoid, @subjectID, @subjectname)
				
				set @autoid = @autoid + 1
				
				fetch next from cursor_Subject
				into @subjectId, @Subjectname	
			End
		deallocate cursor_Subject
		
		while @noofweekdays <> 6
			begin
-- 				select @autoid, @lectureperday, @lecturecount, @lectureperday
				if @lectureperday >= (@autoid - 1)
					begin
						while @lecturecount < @lectureperweek
							BEGIN
								if exists (select autoid from #temp where autoid = (@lecturecount + 1))
									BEGIN
										insert into #tempTimetable 
										Select @noofweekdays, * from #temp where autoid = (@lecturecount + 1)
									END
								else
									begin
										insert into #tempTimetable 
										Select @noofweekdays, * from #temp where autoid = @totalsubject + 1
										
										IF (@totalsubject = (@autoid - 1))
											BEGIn
												set @totalsubject = 0
											end
										
										Set @totalsubject = @totalsubject + 1
									end
									
								  if ((@lecturecount >= @lectureperday) AND ((@lecturecount % @lectureperday) = 0))
									begin
										select @lecturecount
										set @noofweekdays = @noofweekdays + 1
									end
								Set @lecturecount = @lecturecount + 1
								
-- 								if @lecturecount > @lectureperday
-- 								begin
-- 									set @lecturecount = @lecturecount + @totalsubject
-- 								end
-- 								Select @lecturecount
-- 								select * from #tempTimetable
							END
						
-- 						select @noofweekdays, * from #tempTimetable
						set @noofweekdays = @noofweekdays + 1
					end
-- 				else
-- 					begin
-- 						while ((@totalsubject + 1) = (@autoid - 1))
-- 							BEGIN
-- 								if (@lecturecount >= @lectureperday)
-- 									begin
-- 										break
-- 									end
-- 								IF (@lecturecount < @lectureperday)
-- 									begin
-- 										insert into #tempTimetable 
-- 										Select @noofweekdays, * from #temp where autoid = @totalsubject + 1
-- 										Set @totalsubject = @totalsubject + 1
-- 										set @lecturecount = @lecturecount + 1
-- 									end
-- 							end
-- 						set @noofweekdays = @noofweekdays + 1						
-- 					end	
			end
		select * from #tempTimetable 
	END	


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create procedure ttm_search_subject
(@subjectcode	varchar(20),
@SubjectName	varchar(200),
@SemesterID	int,
@marks		numeric,	
@SubjectID	int
)
AS
	BEGIN
		Select * from ttm_subject
		Where (@SubjectID = 0
		OR [SubjectID]	= @SubjectID)
		AND (@SemesterID = 0
		OR [SemesterID]	= @SemesterID)
		AND (@marks = 0
		OR [marks]	= @marks)
		AND (@SubjectName = 0
		OR [SubjectName]	like '%' + @SubjectName + '%')
		AND (@subjectcode = 0
		OR [subjectcode]	like '%' + @subjectcode + '%')
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

