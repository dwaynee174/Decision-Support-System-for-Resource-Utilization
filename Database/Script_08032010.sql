IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'TimeTableManagement')
	DROP DATABASE [TimeTableManagement]
GO

CREATE DATABASE [TimeTableManagement]  ON (NAME = N'TimeTableManagement_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL$SERVER\data\TimeTableManagement_Data.MDF' , SIZE = 2, FILEGROWTH = 10%) LOG ON (NAME = N'TimeTableManagement_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL$SERVER\data\TimeTableManagement_Log.LDF' , SIZE = 5, FILEGROWTH = 10%)
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateusernameandpassword]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[updateusernameandpassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getWorkExperience]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[getWorkExperience]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getfacultyfortimetable]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[getfacultyfortimetable]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getfacultyqualification]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[getfacultyqualification]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getsubjectnamefortimetble]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[getsubjectnamefortimetble]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getsubjectnamefortimetble_bak]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[getsubjectnamefortimetble_bak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[checkfacultyallocation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[checkfacultyallocation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getfacultylogin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getfacultylogin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getlogincorrect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getlogincorrect]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_delete_FacultyInformation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_delete_FacultyInformation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_delete_Semester]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_delete_Semester]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_delete_facultysubjectmapping]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_delete_facultysubjectmapping]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_delete_subject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_delete_subject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_generateTimetable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_generateTimetable]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_generateTimetable_bak]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_generateTimetable_bak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_insert_FacultyInformation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_insert_FacultyInformation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_insert_Semester]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_insert_Semester]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_insert_facultysubjectmapping]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_insert_facultysubjectmapping]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_insert_subject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_insert_subject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_search_FacultyInformation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_search_FacultyInformation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_search_semester]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_search_semester]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_search_subject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_search_subject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_update_FacultyInformation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_update_FacultyInformation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_update_Semester]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_update_Semester]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_update_subject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ttm_update_subject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_get_subject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_get_subject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TTM_Auto_Qualification]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TTM_Auto_Qualification]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[temp1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[temp1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tempTimetable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tempTimetable]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ttm_login]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ttm_login]
GO

if not exists (select * from dbo.sysusers where name = N'guest' and hasdbaccess = 1)
	EXEC sp_grantdbaccess N'guest'
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE function getWorkExperience (@subjectid int, @semesterid int)
returns decimal
as
	begin
		declare @WorkExperience decimal
		
		select top 1 @WorkExperience = max(WorkExperience)
		from ttm_facultysubjectmapping map
		inner join ttm_facultyinformation fac
		on fac.facultyid = map.facultyid
		where semesterid = @semesterid
		and subjectid = @subjectid
--		order by WorkExperience desc
		
		return (isnull(@WorkExperience,0))
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE function getfacultyfortimetable (@subjectname varchar(200), @semesterid int)
returns nvarchar(200)
as
	begin
		declare @name varchar(200)
		declare @subjectid int
		
		select @Subjectid = subjectid from ttm_subject where subjectname =  @subjectname
		
		select top 1 @name = facultyname from ttm_facultysubjectmapping map
		inner join ttm_facultyinformation fac
		on fac.facultyid = map.facultyid
		where semesterid = @semesterid
		and subjectid = @subjectid
		and fac.qualification = dbo.getfacultyqualification(@subjectid, @semesterid)
		and fac.WorkExperience = dbo.getWorkExperience(@subjectid, @semesterid)
		
		return (isnull(@name, ''))
	end





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE function getfacultyqualification (@subjectid int, @semesterid int)
returns int
as
	begin
		declare @qualification int
		
		select @qualification = max(qualification) 
		from ttm_facultysubjectmapping map
		inner join ttm_facultyinformation fac
		on fac.facultyid = map.facultyid
		where semesterid = @semesterid
		and subjectid = @subjectid
		
		return (isnull(@qualification, 0))
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

-- select * From tempTimetable
CREATE function getsubjectnamefortimetble (@weekid int, @Lectureperday int, @id int, @remainiglecture int)
returns varchar(200)
as
	begin
		declare @subName varchar(200)
		
		if @remainiglecture <> 0
			begin
				if @weekid = 1
		   			begin
						select top 1 @subName = SubjectName from tempTimetable 
						where weekid = @weekid and id = @id + (@Lectureperday * 4)
					end
					
				if @weekid = 2
		   			begin
						select @subName = SubjectName from tempTimetable 
						where weekid = @weekid and id = @id + (@Lectureperday * 4) + 1
					end
				if @weekid = 3
		   			begin
						select @subName = SubjectName from tempTimetable 
						where weekid = @weekid and id = @id +  (@Lectureperday * 4) + 2
					end
				if @weekid = 4
		   			begin
						select @subName = SubjectName from tempTimetable 
						where weekid = @weekid and id = @id + (@Lectureperday * 4) + 3
					end
			end
			
		if @weekid = 1
   			begin
				select top 1 @subName = SubjectName from tempTimetable 
				where weekid = @weekid and id = @id
			end
			
		if @weekid = 2
   			begin
				select @subName = SubjectName from tempTimetable 
				where weekid = @weekid and id = @id + @Lectureperday
			end
		if @weekid = 3
   			begin
				select @subName = SubjectName from tempTimetable 
				where weekid = @weekid and id = @id + (@Lectureperday * 2)
			end
		if @weekid = 4
   			begin
				select @subName = SubjectName from tempTimetable 
				where weekid = @weekid and id = @id + (@Lectureperday * 3)
			end
		if @weekid = 5
   			begin
				select @subName = SubjectName from tempTimetable 
				where weekid = @weekid and id = @id + (@Lectureperday * 4)
			end
		
		return(@subName)
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

-- select * From tempTimetable
CREATE function getsubjectnamefortimetble_bak (@weekid int)
returns varchar(200)
as
	begin
		declare @subName varchar(200)
		
		if @weekid = 1
   			begin
				select top 1 @subName = SubjectName from tempTimetable 
				where weekid = @weekid and SubjectName not in (select [monday] from temp1)
			end
			
		if @weekid = 2
   			begin
				select top 1 @subName = SubjectName from tempTimetable 
				where weekid = @weekid and SubjectName not in (select [TUESDAY] from temp1)
			end
		if @weekid = 3
   			begin
				select top 1 @subName = SubjectName from tempTimetable 
				where weekid = @weekid and SubjectName not in (select [WEDNESDAY] from temp1)
			end
		if @weekid = 4
   			begin
				select top 1 @subName = SubjectName from tempTimetable 
				where weekid = @weekid and SubjectName not in (select [THURSDAY] from temp1)
			end
		if @weekid = 5
   			begin
				select top 1 @subName = SubjectName from tempTimetable 
				where weekid = @weekid and SubjectName not in (select [FRIDAY] from temp1)
			end
		return(@subName)
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE TABLE [dbo].[TTM_Auto_Qualification] (
	[QualificationID] [int] NULL ,
	[Qualification] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TTM_FacultyInformation] (
	[FacultyID] [int] IDENTITY (1, 1) NOT NULL ,
	[Facultycode] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Facultyname] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Age] [int] NULL ,
	[Qualification] [int] NULL ,
	[Contactinformation] [int] NULL ,
	[Username] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Password] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WorkExperience] [decimal](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TTM_FacultySubjectMapping] (
	[MappingID] [int] IDENTITY (1, 1) NOT NULL ,
	[FacultyID] [int] NULL ,
	[SemesterID] [int] NULL ,
	[SubjectID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TTM_Semester] (
	[SemesterID] [int] IDENTITY (1, 1) NOT NULL ,
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

CREATE TABLE [dbo].[temp1] (
	[MONDAY] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Faculty1] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TUESDAY] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Faculty2] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WEDNESDAY] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Faculty3] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[THURSDAY] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Faculty4] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FRIDAY] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Faculty5] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tempTimetable] (
	[weekid] [int] NULL ,
	[autoid] [int] NULL ,
	[subjectid] [int] NULL ,
	[subjectname] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ttm_login] (
	[username] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[password] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TTM_FacultyInformation] WITH NOCHECK ADD 
	CONSTRAINT [PK_TTM_FacultyInformation] PRIMARY KEY  CLUSTERED 
	(
		[FacultyID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TTM_FacultySubjectMapping] WITH NOCHECK ADD 
	CONSTRAINT [PK_TTM_FacultySubjectMapping] PRIMARY KEY  CLUSTERED 
	(
		[MappingID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TTM_Semester] WITH NOCHECK ADD 
	CONSTRAINT [PK_TTM_Semester] PRIMARY KEY  CLUSTERED 
	(
		[SemesterID]
	)  ON [PRIMARY] 
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

CREATE procedure checkfacultyallocation (@semesterid int)
as
	begin
		declare @isexits bit
		set @isexits = 1
		
		IF EXISTS (
				select sub.subjectid
				from ttm_subject sub
				left join TTM_FacultySubjectMapping map
				on map.subjectid = sub.subjectid
				and map.semesterid= sub.semesterid
				where sub.semesterid = @semesterid
				and map.subjectid is null
			)
			begiN
				set @isexits = 0
			end 	
		select @isexits as [isexits]
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure getfacultylogin (@username varchar(200), @password varchar(200))
as
	begin
		declare @loginwithfaculty bit
		set @loginwithfaculty = 0
		if exists (
				select ln.username from ttm_login ln 
				inner join ttm_facultyinformation fi
				on fi.username = ln.username and fi.password = ln.password
				where ln.username = @username and ln.[password] = @password)
			begin
				set @loginwithfaculty = 1
			end
		select @loginwithfaculty as [loginwithfaculty]
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure getlogincorrect (@username varchar(200), @password varchar(200))
as
	begin
		declare @correctlogin bit
		set @correctlogin = 0
		if exists (select username from ttm_login where username = @username and [password] = @password)
			set @correctlogin = 1

		select @correctlogin as [correctlogin]
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure ttm_delete_FacultyInformation
(
	@FacultyID   	int
)
AS
	Begin
		Set nocount on
		
		delete from ttm_login 
		where username = (select username from  ttm_FacultyInformation where FacultyID = @FacultyID)
		and password  = (select password from  ttm_FacultyInformation where FacultyID = @FacultyID)
		
		delete from ttm_FacultyInformation 
		where FacultyID = @FacultyID
	End



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure ttm_delete_Semester
(
	@SemesterID   	int
)
AS
	Begin
		Set nocount on
		
		delete from ttm_Semester 
		where SemesterID = @SemesterID
	End



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure ttm_delete_facultysubjectmapping
(
	@FacultyID 	int,
	@SemesterID  	int,
	@Subjectname	varchar(200))
AS
	Begin
		Set nocount on
		
		
		declare @SubjectID int
		Select 	@SubjectID = SubjectID from ttm_Subject where subjectname = @Subjectname
		
		delete from ttm_facultysubjectmapping
		where facultyid = @facultyid and SemesterID = @SemesterID and subjectid = @subjectID

	End




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure ttm_delete_subject
(
	@SubjectID   	int
)
AS
	Begin
		Set nocount on
		
		delete from ttm_subject 
		where SubjectID = @SubjectID
	End

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
select * From tempTimetable
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
		Declare @remainiglecture int
		
		Set @noofweekdays = 1
		set @totalsubject = 1
		Set @lecturecount = 1
		set @totalsubjectcount = 1
		
		Select @lectureperweek = lectureperweek from ttm_semester where semesterid = @SemesterID
		Select @lectureperday = @lectureperweek / 5
		select @remainiglecture = @lectureperweek % 5
		-- select @remainiglecture
		Create table #temp (autoid int, subjectid int, subjectname varchar(200))	
		
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
										insert into tempTimetable 
										Select @noofweekdays, * from #temp where autoid = @lecturecount
-- 										select @lecturecount
									END
								else
									begin
										IF (@totalsubject > (@autoid-1))
											BEGIn
												set @totalsubject = 1
											end
-- 										select @totalsubject , '@totalsubject'
										insert into tempTimetable 
										Select @noofweekdays, * from #temp where autoid = @totalsubject
-- 										select * from tempTimetable
										
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
										insert into tempTimetable
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
		
		Declare @extralecture int
		set @extralecture = 1
		if @remainiglecture <> 0 
			BEGIN
				set @noofweekdays = 1
				while @extralecture < (@remainiglecture + 1)
					begin
						insert into tempTimetable
						Select @extralecture, * from #temp where autoid = @totalsubject
						set @extralecture = @extralecture + 1
						set @totalsubject = @totalsubject + 1
						if @totalsubject = @autoid
							begin
								set @totalsubject = 1
							end
					end 
			end
---- actual time table creation		
		truncate table temp1
		declare @timetablecount int
		declare @getsubjectcout int
		set @timetablecount = 0
		set @getsubjectcout = 1
		
		While @timetablecount < @lectureperday
			Begin
				if @getsubjectcout = @autoid
					begin
						set @getsubjectcout = 1 
					end 
				insert into temp1 values
				
				(dbo.getsubjectnamefortimetble(1, @lectureperday, @getsubjectcout, 0), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(1, @lectureperday, @getsubjectcout, 0), @semesterid), 
				dbo.getsubjectnamefortimetble(2, @lectureperday, @getsubjectcout, 0), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(2, @lectureperday, @getsubjectcout, 0), @semesterid), 
				dbo.getsubjectnamefortimetble(3, @lectureperday, @getsubjectcout, 0), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(3, @lectureperday, @getsubjectcout, 0), @semesterid), 
				dbo.getsubjectnamefortimetble(4, @lectureperday, @getsubjectcout, 0), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(4, @lectureperday, @getsubjectcout, 0), @semesterid),
				dbo.getsubjectnamefortimetble(5, @lectureperday, @getsubjectcout, 0), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(5, @lectureperday, @getsubjectcout, 0), @semesterid))	
				
				set @getsubjectcout = @getsubjectcout + 1 
				set @timetablecount  = @timetablecount + 1
			end
		
-- 		set @timetablecount = 0
-- 		set @getsubjectcout = 1
-- 		
-- 		While @timetablecount < @remainiglecture
-- 			Begin
-- 				if @getsubjectcout = @autoid
-- 					begin
-- 						set @getsubjectcout = 1 
-- 					end 
				insert into temp1 values
				
				(dbo.getsubjectnamefortimetble(1, @lectureperday, @getsubjectcout, @remainiglecture), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(1, @lectureperday, @getsubjectcout, @remainiglecture), @semesterid), 
				dbo.getsubjectnamefortimetble(2, @lectureperday, @getsubjectcout, @remainiglecture), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(2, @lectureperday, @getsubjectcout, @remainiglecture), @semesterid), 
				dbo.getsubjectnamefortimetble(3, @lectureperday, @getsubjectcout, @remainiglecture), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(3, @lectureperday, @getsubjectcout, @remainiglecture), @semesterid), 
				dbo.getsubjectnamefortimetble(4, @lectureperday, @getsubjectcout, @remainiglecture), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(4, @lectureperday, @getsubjectcout, @remainiglecture), @semesterid),
				dbo.getsubjectnamefortimetble(5, @lectureperday, @getsubjectcout, @remainiglecture), dbo.getfacultyfortimetable(dbo.getsubjectnamefortimetble(5, @lectureperday, @getsubjectcout, @remainiglecture), @semesterid))	
				
-- 				set @getsubjectcout = @getsubjectcout + 1 
-- 				set @timetablecount  = @timetablecount + 1
-- 			end
			
		select MONDAY + '  |' + Faculty1 AS [MONDAY | FACULTY], 
		TUESDAY + '  |' + Faculty2 AS [TUESDAY | FACULTY],
		WEDNESDAY + '  |' + Faculty2 AS [WEDNESDAY | FACULTY],
		THURSDAY + '  |' + Faculty2 AS [THURSDAY | FACULTY],
		FRIDAY + '  |' + Faculty2 AS [FRIDAY | FACULTY]
		from temp1
		truncate table tempTimetable
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

CREATE procedure ttm_insert_FacultyInformation
(
	@Facultycode 		varchar(20),
	@Facultyname 		varchar(200),
	@Age			int,
	@Qualification		int,
	@Contactinformation	int,
	@username		varchar(150),
	@Password		varchar(150),
	@WorkExperience		decimal
)
AS
	Begin
		Set nocount on
		
		insert into ttm_FacultyInformation
		(
		Facultycode,
		Facultyname,
		Age,
		Qualification,
		Contactinformation,
		username,
		[Password],
		WorkExperience
		)
		values
		(
		@Facultycode,
		@Facultyname,
		@Age,
		@Qualification,
		@Contactinformation,
		@username,	
		@Password,
		@WorkExperience
		)
		
		insert into ttm_login (username, password) values (@username, @password)
	End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure ttm_insert_Semester
(
	@Semestercode 		varchar(20),
	@Semestername 		varchar(200),
	@LecturePerWeek	     numeric(18,2)
)
AS
	Begin
		Set nocount on
		
		insert into ttm_Semester
		(
		Semestercode,
		Semestername,
		LecturePerWeek
		)
		values
		(
		@Semestercode,
		@Semestername,
		@LecturePerWeek
		)
	End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure ttm_insert_facultysubjectmapping
(
	@FacultyID 	int,
	@SemesterID  	int,
	@Subjectname	varchar(200))
AS
	Begin
		Set nocount on
		
-- 		delete from ttm_facultysubjectmapping
-- 		where facultyid = @facultyid and SemesterID = @SemesterID
		
		declare @SubjectID int
		Select 	@SubjectID = SubjectID from ttm_Subject where subjectname = @Subjectname
		
		insert into ttm_facultysubjectmapping
		(
		SubjectID,
		facultyid,
		SemesterID
		)
		values
		(
		@SubjectID,
		@facultyid,
		@SemesterID
		)
	End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure ttm_insert_subject
(
	@Subjectcode varchar(20),
	@Subjectname varchar(200),
	@SemesterID  int,
	@Marks	     numeric(18,2)
)
AS
	Begin
		Set nocount on
		
		insert into ttm_subject
		(
		Subjectcode,
		Subjectname,
		SemesterID,
		Marks
		)
		values
		(
		@Subjectcode,
		@Subjectname,
		@SemesterID,
		@Marks
		)
	End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE ttm_search_FacultyInformation
(
@Facultycode		varchar(20),
@FacultyName		varchar(200),
@Age			int,
@Qualification		int,
@Contactinformation	int,
@WorkExperience		decimal
)
AS
	BEGIN
		Select * from ttm_FacultyInformation
		Where (@FacultyName = ''
		OR [FacultyName]	like '%' + @FacultyName + '%')
		AND (@Facultycode = ''
		OR [Facultycode]	like '%' + @Facultycode + '%')
		aND (@WorkExperience  = 0 
		or [WorkExperience] = @WorkExperience)
		aND (@Contactinformation =  0 
		or [Contactinformation] = @Contactinformation)
		aND (@Age =  0 
		or [Age] = @Age)
		
		
		
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

Create procedure ttm_search_semester
(@semestercode	varchar(20),
@SemesterName	varchar(200),
@LecturePerWeek	numeric,	
@SemesterID	int
)
AS
	BEGIN
		Select * from ttm_Semester
		Where (@SemesterID = 0
		OR [SemesterID]	= @SemesterID)
		AND (@LecturePerWeek = 0
		OR [LecturePerWeek]	= @LecturePerWeek)
		AND (@SemesterName = 0
		OR [SemesterName]	like '%' + @SemesterName + '%')
		AND (@Semestercode = 0
		OR [Semestercode]	like '%' + @Semestercode + '%')
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure ttm_update_FacultyInformation
(
	@FacultyID   		int,	
	@Facultycode 		varchar(20),
	@Facultyname 		varchar(200),
	@Age			int,
	@Qualification		int,
	@Contactinformation	int,
	@username		varchar(150),
	@Password		varchar(150),
	@WorkExperience		decimal
)
AS
	Begin
		Set nocount on
		
		update ttm_FacultyInformation 
		set Facultycode = @Facultycode, Facultyname = @Facultyname, 
		Age = @Age, Qualification = @Qualification, Contactinformation = @Contactinformation,
		username = @username, [Password] = @Password, WorkExperience = @WorkExperience
		where FacultyID = @FacultyID
	End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure ttm_update_Semester
(
	@SemesterID   		int,	
	@Semestercode 		varchar(20),
	@Semestername 		varchar(200),
	@LecturePerWeek	     	numeric(18,2)
)
AS
	Begin
		Set nocount on
		
		update ttm_Semester 
		set Semestercode = @Semestercode, Semestername = @Semestername, 
		LecturePerWeek = @LecturePerWeek
		where SemesterID = @SemesterID
	End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure ttm_update_subject
(
	@SubjectID   	int,	
	@Subjectcode 	varchar(20),
	@Subjectname 	varchar(200),
	@SemesterID  	int,
	@Marks	     	numeric(18,2)
)
AS
	Begin
		Set nocount on
		
		update ttm_subject 
		set Subjectcode = @Subjectcode, Subjectname = @Subjectname, SemesterID = @SemesterID,
		Marks = @Marks
		where SubjectID = @SubjectID
	End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure usp_get_subject
(
	@FacultyID		[int],
	@SemesterID		[int],
	@IsmappedSubjects	[bit]
)
as
	begin
		if @IsmappedSubjects = 1
			Begin
				Select su.Subjectname, su.subjectid
				from TTM_subject su
				inner join ttm_facultySubjectmapping mp
				on mp.Subjectid = su.subjectid
				and facultyid = @FacultyID
				where su.semesterID = @SemesterID
			end
		if @IsmappedSubjects = 0
			begin
				Select su.Subjectname, su.subjectid
				from TTM_subject su
				left join ttm_facultySubjectmapping mp
				on mp.Subjectid = su.subjectid
				and facultyid = @FacultyID
				where su.semesterID = @SemesterID
				and isnull(mp.mappingid,0)	= 0
			end
	end

-- select * From ttm_facultySubject

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create trigger updateusernameandpassword
on ttm_facultyinformation
for update
as
begin
	declare @username_new	varchar(200)
	declare @username_old	varchar(200)
	declare @password_new	varchar(200)
	declare @password_old	varchar(200)
	select @username_new = i.username, @username_old = d.username, @password_new = i.password, @password_old = d.password
	from inserted i
	inner join deleted d
	on i.facultyid = d.facultyid
	
	if (@username_new <> @username_old) or (@password_new <> @password_old)
		begin
			update ttm_login
			set username = @username_new, password = @password_new
			where username = @username_old and password = @password_old
		end 
	
end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

