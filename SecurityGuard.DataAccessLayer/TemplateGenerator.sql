USE [master]
GO

IF (EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = N'TemplateGeneratorDB'OR name = N'TemplateGeneratorDB')))
DROP DATABASE TemplateGeneratorDB

CREATE DATABASE TemplateGeneratorDB
GO

USE TemplateGeneratorDB
GO

IF OBJECT_ID('Users')  IS NOT NULL
DROP TABLE Users
GO

IF OBJECT_ID('Roles')  IS NOT NULL
DROP TABLE Roles
GO

IF OBJECT_ID('CollageTemplate')  IS NOT NULL
DROP TABLE CollageTemplate
GO

IF OBJECT_ID('CalendarTemplate')  IS NOT NULL
DROP TABLE CalendarTemplate
GO

IF OBJECT_ID('AdvertisementTemplate')  IS NOT NULL
DROP TABLE AdvertisementTemplate
GO

IF OBJECT_ID('CustomisedCollageTemplate')  IS NOT NULL
DROP TABLE CustomisedCollageTemplate
GO

IF OBJECT_ID('CustomisedCalendarTemplate')  IS NOT NULL
DROP TABLE CustomisedCalendarTemplate
GO


IF OBJECT_ID('usp_RegisterUser')  IS NOT NULL
DROP PROC usp_RegisterUser
GO

IF OBJECT_ID('usp_AddCollageTemplate')  IS NOT NULL
DROP PROC usp_AddCollageTemplate
GO

IF OBJECT_ID('usp_AddCalendarTemplate') IS NOT NULL
DROP PROC usp_AddCalendarTemplate
GO

IF OBJECT_ID('usp_AddAdvertisementTemplate')  IS NOT NULL
DROP PROC usp_AddAdvertisementTemplate
GO

IF OBJECT_ID('usp_AddFeedback')  IS NOT NULL
DROP PROC usp_AddFeedback
GO



IF OBJECT_ID('usp_AddCustomisedCollageTemplate')  IS NOT NULL
DROP PROC usp_AddCustomisedCollageTemplate
GO

IF OBJECT_ID('usp_AddCustomisedCalendarTemplate')  IS NOT NULL
DROP PROC usp_AddCustomisedCalendarTemplate
GO

IF OBJECT_ID('usp_UpdateCollageTemplate')  IS NOT NULL
DROP PROC usp_UpdateCollageTemplate
GO

IF OBJECT_ID('usp_UpdateCalendarTemplate')  IS NOT NULL
DROP PROC usp_UpdateCalendarTemplate
GO

IF OBJECT_ID('usp_UpdateAdvertisementTemplate')  IS NOT NULL
DROP PROC usp_UpdateAdvertisementTemplate
GO

IF OBJECT_ID('ufn_CheckEmailId')  IS NOT NULL
DROP FUNCTION ufn_CheckEmailId
GO

IF OBJECT_ID('ufn_ValidateUserCredentials')  IS NOT NULL
DROP FUNCTION ufn_ValidateUserCredentials
GO

IF OBJECT_ID('ufn_GenerateCollageTemplateId')  IS NOT NULL
DROP FUNCTION ufn_GenerateCollageTemplateId
GO

IF OBJECT_ID('ufn_GenerateCalendarTemplateId')  IS NOT NULL
DROP FUNCTION ufn_GenerateCalendarTemplateId
GO

IF OBJECT_ID('ufn_GenerateAdvertisementTemplateId')  IS NOT NULL
DROP FUNCTION ufn_GenerateAdvertisementTemplateId
GO

IF OBJECT_ID('ufn_GenerateCustomisedCollageTemplateId')  IS NOT NULL
DROP FUNCTION ufn_GenerateCustomisedCollageTemplateId
GO

IF OBJECT_ID('ufn_GenerateCustomisedCalendarTemplateId')  IS NOT NULL
DROP FUNCTION ufn_GenerateCustomisedCalendarTemplateId
GO



CREATE TABLE Roles
(
	[RoleId] TINYINT CONSTRAINT pk_RoleId PRIMARY KEY IDENTITY,
	[RoleName] VARCHAR(20) CONSTRAINT uq_RoleName UNIQUE
)
GO 

CREATE TABLE Users
( 	
	[EmailId] VARCHAR(50) CONSTRAINT pk_EmailId PRIMARY KEY,
	[UserPassword] VARCHAR(15) NOT NULL,
	[FirstName] VARCHAR(20) NOT NULL,
	[LastName] VARCHAR(20) NOT NULL,
	[PhoneNumber] BIGINT NOT NULL,
	[RoleId] TINYINT CONSTRAINT fk_RoleId REFERENCES Roles(RoleId),
)
GO

CREATE TABLE CollageTemplate
(
	[CollageTemplateId] VARCHAR(10) CONSTRAINT pk_collageTemplateId PRIMARY KEY,
	[CollageTemplateName] VARCHAR(50) NOT NULL,
	[BackGroundColor] VARCHAR(50) NOT NULL DEFAULT 'White',
	[FontSize] VARCHAR(200),
	[TextAlign] VARCHAR(200),
	[TextValue] VARCHAR(200),
	[TextColor] VARCHAR(200),
	[Border] VARCHAR(100), 
	[BorderColor] VARCHAR(200),
	[NumberOfImages] INT DEFAULT 2,
	[ImageURL] VARCHAR(200),
	[EmailId] VARCHAR(50) CONSTRAINT fk_email FOREIGN KEY REFERENCES Users(EmailId) ON DELETE CASCADE NOT NULL 
)
GO


CREATE TABLE CalendarTemplate
(
	[CalendarTemplateId] VARCHAR(50) CONSTRAINT pk_calendarTemplateId PRIMARY KEY,
	[CalendarTemplateName] VARCHAR(50) NOT NULL,
	[Holidays] VARCHAR(200),
	[BackGroundColor] VARCHAR(50) NOT NULL DEFAULT 'White',
	[FontSize] VARCHAR(50),
	[TextAlign] VARCHAR(50),
	[Padding] VARCHAR(50),
	[TextColor] VARCHAR(50),
	[BorderPadding] VARCHAR(50), 
	[EmailId] VARCHAR(50) CONSTRAINT fk_email2 FOREIGN KEY REFERENCES Users(EmailId) ON DELETE CASCADE NOT NULL
)
GO

CREATE TABLE AdvertisementTemplate
(
	[AdvertisementTemplateId] VARCHAR(50) CONSTRAINT pk_adTemplateId PRIMARY KEY,
	[AdvertisementTemplateName] VARCHAR(50) NOT NULL,
	[BackGroundColor] VARCHAR(50) NOT NULL DEFAULT 'White',
	[FontSize] VARCHAR(200),
	[TextAlign] VARCHAR(200),
	[Padding] VARCHAR(200),
	[TextColor] VARCHAR(200),
	[BorderPadding] VARCHAR(100), 
	[EmailId] VARCHAR(50) CONSTRAINT fk_email3 FOREIGN KEY REFERENCES Users(EmailId) ON DELETE CASCADE NOT NULL
)
GO

CREATE TABLE CustomisedCollageTemplate
(
	[CollageTemplateId] VARCHAR(10) CONSTRAINT pk_customisedcollageTemplateId PRIMARY KEY,
	[CollageTemplateName] VARCHAR(50) NOT NULL,
	[BackGroundColor] VARCHAR(50) NOT NULL DEFAULT 'White',
	[FontSize] VARCHAR(200),
	[TextAlign] VARCHAR(200),
	[TextValue] VARCHAR(200),
	[TextColor] VARCHAR(200),
	[Border] VARCHAR(100), 
	[BorderColor] VARCHAR(200),
	[NumberOfImages] INT DEFAULT 2,
	[ImageURL] VARCHAR(200),
	[EmailId] VARCHAR(50) CONSTRAINT fk_email4 FOREIGN KEY REFERENCES Users(EmailId) ON DELETE CASCADE NOT NULL
)
GO

CREATE TABLE CustomisedCalendarTemplate
(
	[CalendarTemplateId] VARCHAR(10) CONSTRAINT pk_customisedcalendarTemplateId PRIMARY KEY,
	[CalendarTemplateName] VARCHAR(50) NOT NULL,
	[Holidays] VARCHAR(200),
	[BackGroundColor] VARCHAR(50) NOT NULL DEFAULT 'White',
	[FontSize] VARCHAR(50),
	[TextAlign] VARCHAR(50),
	[Padding] VARCHAR(50),
	[TextColor] VARCHAR(50),
	[BorderPadding] VARCHAR(50), 
	[EmailId] VARCHAR(50) CONSTRAINT fk_email5 FOREIGN KEY REFERENCES Users(EmailId) NOT NULL
)
GO

CREATE TABLE CustomisedAdvertisementTemplate
(
	[AdvertisementTemplateId] VARCHAR(50) CONSTRAINT pk_customisedadvertisementTemplateId PRIMARY KEY,
	[AdvertisementTemplateName] VARCHAR(50) NOT NULL,
	[BackGroundColor] VARCHAR(50) NOT NULL DEFAULT 'White',
	[FontSize] VARCHAR(200),
	[TextAlign] VARCHAR(200),
	[Padding] VARCHAR(200),
	[TextColor] VARCHAR(200),
	[BorderPadding] VARCHAR(1000), 
	[EmailId] VARCHAR(50) CONSTRAINT fk_email6 FOREIGN KEY REFERENCES Users(EmailId) NOT NULL
)
GO

CREATE FUNCTION ufn_CheckEmailId
(
	@EmailId VARCHAR(50)
)
RETURNS BIT
AS
BEGIN	
	DECLARE @ReturnValue BIT
	IF NOT EXISTS (SELECT EmailId FROM Users WHERE EmailId=@EmailId)
		SET @ReturnValue=1
	ELSE 
		SET @ReturnValue=0
	RETURN @ReturnValue
END
GO

CREATE FUNCTION ufn_CheckCredentials
(
	@EmailId VARCHAR(50),
	@PhoneNumber BIGINT
)
RETURNS INT
AS
BEGIN
DECLARE @ReturnValue BIT
	IF NOT EXISTS (SELECT EmailId FROM Users WHERE EmailId=@EmailId AND PhoneNumber=@PhoneNumber)
		SET @ReturnValue=1
	ELSE 
		SET @ReturnValue=0
	RETURN @ReturnValue
END
GO

CREATE FUNCTION ufn_ValidateUserCredentials
(
	@EmailId VARCHAR(50),
    @UserPassword VARCHAR(15)
)
RETURNS INT
AS
BEGIN
	DECLARE @RoleId INT
	SELECT @RoleId=RoleId FROM Users WHERE EmailId=@EmailId AND UserPassword=@UserPassword
	RETURN @RoleId
END
GO

CREATE PROCEDURE usp_RegisterUser
(
	@EmailId VARCHAR(50),
	@UserPassword VARCHAR(15),
	@FirstName VARCHAR(10),
	@LastName VARCHAR(10),
	@PhoneNumber BIGINT
)
AS
BEGIN
	DECLARE @RoleId TINYINT
	BEGIN TRY
		IF (@EmailId IS NULL)
			RETURN -1

		DECLARE @CheckEmailId BIT
		SET @CheckEmailId = dbo.ufn_CheckEmailId(@EmailId)
		IF (@CheckEmailId = 0)
			RETURN -2

		IF (@UserPassword IS NULL)
			RETURN -3
		IF (@FirstName IS NULL)
			RETURN -4
		IF (@LastName IS NULL) 
			RETURN -5
		IF (@PhoneNumber IS NULL) 
			RETURN -6
		IF (LEN(@UserPassword)<8)
			RETURN -7
		IF (LEN(@UserPassword)>16)
			RETURN -8
		IF (@EmailId  NOT LIKE '[0-9a-zA-Z]%@__%.__%') 
			RETURN -9
		IF (@FirstName NOT LIKE '[A-Za-z]%') 
			RETURN -10
		IF (LEN(RTRIM(LTRIM(@FirstName))) - LEN(REPLACE(@FirstName, ' ', ''))>0)      
			RETURN -11
		IF (@LastName NOT LIKE '[A-Za-z]%')
			RETURN -12
		IF (LEN(RTRIM(LTRIM(@LastName))) - LEN(REPLACE(@LastName, ' ', ''))>0)      
			RETURN -13
		IF (@PhoneNumber  NOT LIKE '[1-9]%') 
			RETURN -14
		IF (LEN(@PhoneNumber)<> 10)
			RETURN -15

		SELECT @RoleId=RoleId FROM Roles WHERE RoleName='Customer'
		INSERT INTO Users VALUES 
		(@EmailId,@UserPassword, @FirstName, @LastName, @PhoneNumber, @RoleId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

--DECLARE @ReturnValue INT 
--EXEC @ReturnValue = usp_RegisterUser 'Ajay@gmail.com','BSBaaaaa','Ajay','X2yzjx','8988776659'
--SELECT @ReturnValue
--GO


--Functions and Stored procedure for CollageTemplate
CREATE FUNCTION ufn_GenerateCollageTemplateId()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @CollageTemplateId CHAR(10)	
	IF NOT EXISTS(SELECT CollageTemplateId FROM CollageTemplate)
		SET @CollageTemplateId='T100'		
	ELSE
		SELECT @CollageTemplateId='T'+CAST(CAST(SUBSTRING(MAX(CollageTemplateId),2,3) AS INT)+1 AS CHAR) FROM CollageTemplate
	RETURN @CollageTemplateId	
END
GO

CREATE PROCEDURE usp_AddCollageTemplate
(
	@CollageTemplateName VARCHAR(50),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(200),
	@TextAlign VARCHAR(200),
	@TextValue VARCHAR(200),
	@TextColor VARCHAR(200),
	@Border VARCHAR(100),
	@BorderColor VARCHAR(200),
	@NumberOfImages INT,
	@ImageUrl VARCHAR(200),
	@EmailId VARCHAR(50),
	@CollageTemplateId VARCHAR(50) OUT
)
AS
BEGIN
	--SET @CollageTemplateId = 'T-1'
	BEGIN TRY
		IF (@CollageTemplateName IS NULL)
			RETURN -1
		IF (@EmailId IS NULL)
			RETURN -2
		IF(@BackGroundColor IS NULL)
			RETURN -3
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4

		--DECLARE @CollageTemplateId VARCHAR(10)
		SET @CollageTemplateId = dbo.ufn_GenerateCollageTemplateId()

		INSERT INTO CollageTemplate VALUES 
		(@CollageTemplateId,@CollageTemplateName, @BackGroundColor, @FontSize, @TextAlign, @TextValue, @TextColor, @Border,
		@BorderColor, @NumberOfImages, @ImageUrl, @EmailId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

--DECLARE @ReturnValue INT
--EXEC @ReturnValue = usp_AddCollageTemplate 'Anneversary','blue','20px','center','20px','green','20px','mnop@gmail.com'
--SELECT @ReturnValue
--GO


CREATE PROCEDURE usp_UpdateCollageTemplate
(
    @CollageTemplateId VARCHAR(50),
	@CollageTemplateName VARCHAR(50),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(200),
	@TextAlign VARCHAR(200),
	@TextValue VARCHAR(200),
	@TextColor VARCHAR(200),
	@Border VARCHAR(100),
	@BorderColor VARCHAR(200),
	@NumberOfImages INT,
	@ImageUrl VARCHAR(200),
	@EmailId VARCHAR(50)
) 
AS 
BEGIN
      BEGIN TRY
        IF (@CollageTemplateId IS NULL)
			RETURN -1
		IF (@CollageTemplateName IS NULL)
			RETURN -2
		IF (@EmailId IS NULL)
			RETURN -3	
		IF(@BackGroundColor IS NULL)
			RETURN -4
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -5
		IF(LEN(@CollageTemplateId)<4)
			RETURN -6
		IF (@CollageTemplateId NOT LIKE 'T%')
			RETURN -7

        UPDATE CollageTemplate
		SET CollageTemplateId = @CollageTemplateId, CollageTemplateName = @CollageTemplateName,
		BackGroundColor = @BackGroundColor, FontSize = @FontSize, TextAlign = @TextAlign, 
		TextValue = @TextValue, TextColor = @TextColor, Border = @Border, BorderColor = @BorderColor, NumberOfImages = @NumberOfImages,
		ImageURL = @ImageURL
		WHERE (CollageTemplateId = @CollageTemplateId)
		IF EXISTS(
			SELECT CollageTemplateId FROM CollageTemplate
			WHERE CollageTemplateName = @CollageTemplateName AND 
			BackGroundColor = @BackGroundColor AND FontSize = @FontSize AND
			TextAlign = @TextAlign AND TextValue = @TextValue AND TextColor = @TextColor AND
			Border = @Border AND @BorderColor = @BorderColor AND NumberOfImages = @NumberOfImages AND ImageURL = @ImageUrl
			AND EmailId = @EmailId)

				RETURN 1

			ELSE
				RETURN -8

      END TRY
	  BEGIN CATCH	      
		  RETURN -99

	  END CATCH
END
GO

--Functions and Stored procedure for CalendarTemplate
CREATE FUNCTION ufn_GenerateCalendarTemplateId()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @CalendarTemplateId CHAR(10)	
	IF NOT EXISTS(SELECT CalendarTemplateId FROM CalendarTemplate)
		SET @CalendarTemplateId='C100'		
	ELSE
		SELECT @CalendarTemplateId='C'+CAST(CAST(SUBSTRING(MAX(CalendarTemplateId),2,3) AS INT)+1 AS CHAR) FROM CalendarTemplate
	RETURN @CalendarTemplateId	
END
GO

CREATE PROCEDURE usp_AddCalendarTemplate
(
	@CalendarTemplateName VARCHAR(50),
	@Holidays VARCHAR(200),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(50),
	@TextAlign VARCHAR(50),
	@Padding VARCHAR(50),
	@TextColor VARCHAR(50),
	@BorderPadding VARCHAR(50),
	@EmailId VARCHAR(50),
	@CalendarTemplateId VARCHAR(50) OUT
)
AS
BEGIN
	--SET @CalendarTemplateId = 'C-1'
	BEGIN TRY
		IF (@CalendarTemplateName IS NULL)
			RETURN -1
		IF (@EmailId IS NULL)
			RETURN -2
		IF(@BackGroundColor IS NULL)
			RETURN -3
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4
		
		SET @CalendarTemplateId = dbo.ufn_GenerateCalendarTemplateId()
		
		INSERT INTO CalendarTemplate (CalendarTemplateId, CalendarTemplateName, Holidays, BackGroundColor, FontSize, TextAlign, Padding, TextColor, BorderPadding, EmailId)VALUES 
		(@CalendarTemplateId, @CalendarTemplateName, @Holidays, @BackGroundColor, @FontSize, @TextAlign, @Padding, @TextColor, @BorderPadding, @EmailId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

--DECLARE @ReturnValue INT
--EXEC @ReturnValue = usp_AddCalendarTemplate 'Anneversary','20','blue','20px','center','20px','green','20px','mnop@gmail.com'
--SELECT @ReturnValue
--GO

CREATE PROCEDURE usp_UpdateCalendarTemplate
(
    @CalendarTemplateId VARCHAR(50),
	@CalendarTemplateName VARCHAR(50),
	@Holidays VARCHAR(200),
	@BackGroundColor VARCHAR(50),
	@FontSize  VARCHAR(50),
	@TextAlign VARCHAR(50),
	@Padding VARCHAR(50),
	@TextColor VARCHAR(50),
	@BorderPadding VARCHAR(50),
	@EmailId VARCHAR(50)
) 
AS 
BEGIN
      BEGIN TRY
        IF (@CalendarTemplateId IS NULL)
			RETURN -1
		IF (@CalendarTemplateId NOT LIKE 'C%' or LEN(@CalendarTemplateId)<>4)
			RETURN -2
		IF (@CalendarTemplateName IS NULL)
			RETURN -3
		IF ((@EmailId IS NULL) OR LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4	
		IF(@BackGroundColor IS NULL)
			RETURN -5

        UPDATE CalendarTemplate
		SET CalendarTemplateId = @CalendarTemplateId, CalendarTemplateName = @CalendarTemplateName, Holidays = @Holidays,
		BackGroundColor = @BackGroundColor, FontSize = @FontSize, TextAlign = @TextAlign, 
		Padding = @Padding, TextColor = @TextColor, BorderPadding = @BorderPadding
		WHERE (CalendarTemplateId = @CalendarTemplateId)
		RETURN 1
      END TRY

	  BEGIN CATCH	      
		  RETURN -99

	  END CATCH
END
GO

--Functions and Stored procedure for AdvertisementTemplate
CREATE FUNCTION ufn_GenerateAdvertisementTemplateId()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @AdvertisementTemplateId CHAR(10)	
	IF NOT EXISTS(SELECT AdvertisementTemplateId FROM AdvertisementTemplate)
		SET @AdvertisementTemplateId='A100'		
	ELSE
		SELECT @AdvertisementTemplateId='A'+CAST(CAST(SUBSTRING(MAX(AdvertisementTemplateId),2,3) AS INT)+1 AS CHAR) FROM AdvertisementTemplate
	RETURN @AdvertisementTemplateId	
END
GO

CREATE PROCEDURE usp_AddAdvertisementTemplate
(
	@AdvertisementTemplateName VARCHAR(50),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(200),
	@TextAlign VARCHAR(200),
	@Padding VARCHAR(200),
	@TextColor VARCHAR(200),
	@BorderPadding VARCHAR(100),
	@EmailId VARCHAR(50),
	@AdvertisementTemplateId VARCHAR(50) OUT
)
AS
BEGIN
	SET @AdvertisementTemplateId = 'A-1'
	BEGIN TRY
		IF (@AdvertisementTemplateName IS NULL)
			RETURN -1
		IF (@EmailId IS NULL)
			RETURN -2
		IF(@BackGroundColor IS NULL)
			RETURN -3
		IF (LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4
		--DECLARE @advertisementTemplateId CHAR(10)
		SET @advertisementTemplateId = dbo.ufn_GenerateAdvertisementTemplateId()
		
		INSERT INTO AdvertisementTemplate VALUES 
		(@AdvertisementTemplateId, @AdvertisementTemplateName, @BackGroundColor, @FontSize, @TextAlign, @Padding, @TextColor, 
		@BorderPadding, @EmailId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

--DECLARE @ReturnValue INT
--DECLARE @AdTemplateId VARCHAR(10)
--EXEC @ReturnValue = usp_AddAdvertisementTemplate 'Anneversary','blue','20px','center','20px','green','20px','Ajay@gmail.com', @AdTemplateId OUT
--SELECT @ReturnValue
--GO

CREATE PROCEDURE usp_Up
AdvertisementTemplate
(
    @AdvertisementTemplateId VARCHAR(10),
	@AdvertisementTemplateName VARCHAR(50),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(200),
	@TextAlign VARCHAR(200),
	@Padding VARCHAR(200),
	@TextColor VARCHAR(200),
	@BorderPadding VARCHAR(100),
	@EmailId VARCHAR(50)
) 

AS 
BEGIN
      BEGIN TRY
        IF (@AdvertisementTemplateId IS NULL)
			RETURN -1
		IF (@AdvertisementTemplateName IS NULL)
			RETURN -2
		IF (@EmailId IS NULL)
			RETURN -3
		IF(@BackGroundColor IS NULL)
			RETURN -4
		IF (LEN(@AdvertisementTemplateId)<>4)
			RETURN -5
		IF (LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -6
		IF (@AdvertisementTemplateId NOT LIKE 'A%')
			RETURN -7

        UPDATE AdvertisementTemplate
		SET AdvertisementTemplateId = @AdvertisementTemplateId, AdvertisementTemplateName = @AdvertisementTemplateName,
		BackGroundColor = @BackGroundColor, FontSize = @FontSize, TextAlign = @TextAlign, 
		Padding = @Padding, TextColor = @TextColor, BorderPadding = @BorderPadding
		WHERE (AdvertisementTemplateId = @AdvertisementTemplateId)
		IF EXISTS(
			SELECT AdvertisementTemplateId FROM AdvertisementTemplate
			WHERE AdvertisementTemplateName = @AdvertisementTemplateName AND 
			BackGroundColor = @BackGroundColor AND FontSize = @FontSize AND
			TextAlign = @TextAlign AND Padding = @Padding AND TextColor = @TextColor AND
			BorderPadding = @BorderPadding AND EmailId = @EmailId)
			RETURN 1
		ELSE
			RETURN -8

      END TRY

	  BEGIN CATCH
	      
		  RETURN -99

	  END CATCH
END
GO

CREATE FUNCTION ufn_GenerateCustomisedCollageTemplateId()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @CollageTemplateId CHAR(10)	
	IF NOT EXISTS(SELECT CollageTemplateId FROM CustomisedCollageTemplate)
		SET @CollageTemplateId='CT100'		
	ELSE
		SELECT @CollageTemplateId='CT'+CAST(CAST(SUBSTRING(MAX(CollageTemplateId),3,3) AS INT)+1 AS CHAR) FROM CustomisedCollageTemplate
	RETURN @CollageTemplateId	
END
GO

CREATE PROCEDURE usp_AddCustomisedCollageTemplate
(
	@CollageTemplateName VARCHAR(50),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(200),
	@TextAlign VARCHAR(200),
	@TextValue VARCHAR(200),
	@TextColor VARCHAR(200),
	@Border VARCHAR(100),
	@BorderColor VARCHAR(200),
	@NumberOfImages INT,
	@ImageUrl VARCHAR(200),
	@EmailId VARCHAR(50),
	@CollageTemplateId VARCHAR(10) OUT
)
AS
BEGIN
	--SET @CollageTemplateId = 'T-1'
	BEGIN TRY
		IF (@CollageTemplateName IS NULL)
			RETURN -1
		IF (@EmailId IS NULL)
			RETURN -2
		IF(@BackGroundColor IS NULL)
			RETURN -3
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4

		--DECLARE @CollageTemplateId VARCHAR(10)
		SET @CollageTemplateId = dbo.ufn_GenerateCustomisedCollageTemplateId()

		INSERT INTO CustomisedCollageTemplate VALUES 
		(@CollageTemplateId,@CollageTemplateName, @BackGroundColor, @FontSize, @TextAlign, @TextValue, @TextColor, @Border,
		@BorderColor, @NumberOfImages, @ImageUrl, @EmailId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

CREATE FUNCTION ufn_GenerateCustomisedCalendarTemplateId()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @CalendarTemplateId CHAR(10)	
	IF NOT EXISTS(SELECT CalendarTemplateId FROM CustomisedCalendarTemplate)
		SET @CalendarTemplateId='CC100'		
	ELSE
		SELECT @CalendarTemplateId='CC'+CAST(CAST(SUBSTRING(MAX(CalendarTemplateId),3,3) AS INT)+1 AS CHAR) FROM CustomisedCalendarTemplate
	RETURN @CalendarTemplateId	
END
GO

CREATE PROCEDURE usp_AddCustomisedCalendarTemplate
(
	@CalendarTemplateName VARCHAR(50),
	@Holidays VARCHAR(200),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(50),
	@TextAlign VARCHAR(50),
	@Padding VARCHAR(50),
	@TextColor VARCHAR(50),
	@BorderPadding VARCHAR(50),
	@EmailId VARCHAR(50),
	@CalendarTemplateId VARCHAR(50) OUT
)
AS
BEGIN
	--SET @CalendarTemplateId = 'C-1'
	BEGIN TRY
		IF (@CalendarTemplateName IS NULL)
			RETURN -1
		IF (@EmailId IS NULL)
			RETURN -2
		IF(@BackGroundColor IS NULL)
			RETURN -3
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4
		
		SET @CalendarTemplateId = dbo.ufn_GenerateCustomisedCalendarTemplateId()
		
		INSERT INTO CustomisedCalendarTemplate VALUES (@CalendarTemplateId, @CalendarTemplateName, @Holidays, @BackGroundColor, @FontSize, @TextAlign, @Padding, @TextColor, @BorderPadding, @EmailId)
		RETURN 1
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() as ErrorMessage
		RETURN -99
	END CATCH
END
GO

CREATE TABLE Feedback
( 	
	[EmailId] VARCHAR(50) NOT NULL,
	[FeedbackText] VARCHAR(20) NOT NULL,
	
)
GO


CREATE PROCEDURE usp_AddFeedback
(
	
	@EmailId VARCHAR(200),
	@FeedbackText VARCHAR(200)
)
AS
BEGIN
	BEGIN TRY
		IF (@EmailId IS NULL)
			RETURN -1
		IF(@FeedbackText IS NULL)
			RETURN -2
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -3
		DECLARE @CheckEmailId BIT
		SET @CheckEmailId = dbo.ufn_CheckEmailId(@EmailId)
		IF (@CheckEmailId = 1)
			RETURN -4
		INSERT INTO Feedback VALUES 
		(@EmailId,@FeedbackText)
			RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

DECLARE @ReturnResult INT
EXEC @ReturnResult = usp_AddFeedback 'Ajay@gmail.com','Website not working'
SELECT @ReturnResult

GO

SELECT * FROM Feedback


CREATE TABLE DownloadCalendar
( 	
	[EmailId] VARCHAR(50) NOT NULL,
	[Img] LONGBLOB NOT NULL,
	
)
GO



CREATE PROCEDURE usp_AddDownloadCalendar
(
	
	@EmailId VARCHAR(200),
	@Img LONGBLOB
)
AS
BEGIN
	BEGIN TRY
		IF (@EmailId IS NULL)
			RETURN -1
		IF(@Img IS NULL)
			RETURN -2
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -3
		DECLARE @CheckEmailId BIT
		SET @CheckEmailId = dbo.ufn_CheckEmailId(@EmailId)
		IF (@CheckEmailId = 1)
			RETURN -4
		INSERT INTO DownloadCalendar VALUES 
		(@EmailId,@Img)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

CREATE PROCEDURE usp_UpdateRegisteredCustomer
(
	@EmailId VARCHAR(50),
	@FirstName VARCHAR(10),
	@LastName VARCHAR(10),
	@PhoneNumber BIGINT
)
AS
BEGIN
	BEGIN TRY
		IF (@EmailId IS NULL)
			RETURN -1

		DECLARE @CheckEmailId BIT
		SET @CheckEmailId = dbo.ufn_CheckEmailId(@EmailId)
		IF (@CheckEmailId = 1)
			RETURN -2

		IF (@FirstName IS NULL)
			RETURN -4
		IF (@LastName IS NULL) 
			RETURN -5
		IF (@PhoneNumber IS NULL) 
			RETURN -6
		IF (@EmailId  NOT LIKE '[0-9a-zA-Z]%@__%.__%') 
			RETURN -9
		IF (@FirstName NOT LIKE '[A-Za-z]%') 
			RETURN -10
		IF (LEN(RTRIM(LTRIM(@FirstName))) - LEN(REPLACE(@FirstName, ' ', ''))>0)      
			RETURN -11
		IF (@LastName NOT LIKE '[A-Za-z]%')
			RETURN -12
		IF (LEN(RTRIM(LTRIM(@LastName))) - LEN(REPLACE(@LastName, ' ', ''))>0)      
			RETURN -13
		IF (@PhoneNumber  NOT LIKE '[1-9]%') 
			RETURN -14
		IF (LEN(@PhoneNumber)<> 10)
			RETURN -15

		DECLARE @RoleId TINYINT
		SELECT @RoleId=RoleId FROM Roles WHERE RoleName='Customer'
		
		UPDATE Users 
		SET EmailId = @EmailId, FirstName = @FirstName, LastName = @LastName, PhoneNumber = @PhoneNumber, RoleId = @RoleId
		WHERE (EmailId = @EmailId AND RoleId = @RoleId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

--DECLARE @ReturnValue INT 
--EXEC @ReturnValue = usp_UpdateRegisteredCustomer 'Vijay@gmail.com','BSBaaaaa','Ajay','X2yzjx','8988776659'
--SELECT @ReturnValue
--GO

IF OBJECT_ID('usp_ResetPassword')  IS NOT NULL 
DROP PROC usp_ResetPassword
GO

CREATE PROCEDURE usp_ResetPassword
(
	@EmailId VARCHAR(50),
	@PhoneNumber BIGINT,
	@UserPassword VARCHAR(16)
)
AS
BEGIN
	BEGIN TRY
		IF (@EmailId IS NULL)
			RETURN -1
		IF (@PhoneNumber IS NULL)
			RETURN -2
		IF (@UserPassword IS NULL)
			RETURN -3
		DECLARE @CheckEmailId BIT
		SET @CheckEmailId = dbo.ufn_CheckEmailId(@EmailId)
		IF (@CheckEmailId = 1)
			RETURN -4
		DECLARE @CheckCred BIT
		SET @CheckCred = dbo.ufn_CheckCredentials(@EmailId, @PhoneNumber)
		IF (@CheckCred = 1)
			RETURN -5
		IF (LEN(@UserPassword)<8) 
			RETURN -6
		IF (LEN(@UserPassword)>16)
			RETURN -7
		IF ( @UserPassword NOT LIKE '%[a-zA-Z0-9]%' OR @UserPassword NOT LIKE '%[~!@#$%^&*()_+-={}\[\]:"|\;,./<>?'']%' ESCAPE '\' OR LEN(@UserPassword) < 8)
			RETURN -8
		UPDATE Users 
		SET UserPassword = @UserPassword
		WHERE (EmailId = @EmailId AND PhoneNumber = @PhoneNumber)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END 
GO



CREATE PROCEDURE usp_UpdateCustomisedCollageTemplate
(
    @CollageTemplateId VARCHAR(50),
	@CollageTemplateName VARCHAR(50),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(200),
	@TextAlign VARCHAR(200),
	@TextValue VARCHAR(200),
	@TextColor VARCHAR(200),
	@Border VARCHAR(100),
	@BorderColor VARCHAR(200),
	@NumberOfImages INT,
	@ImageUrl VARCHAR(200),
	@EmailId VARCHAR(50)
) 
AS 
BEGIN
      BEGIN TRY
        IF (@CollageTemplateId IS NULL)
			RETURN -1
		IF (@CollageTemplateName IS NULL)
			RETURN -2
		IF (@EmailId IS NULL)
			RETURN -3	
		IF(@BackGroundColor IS NULL)
			RETURN -4
		IF(LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -5
		IF(LEN(@CollageTemplateId)<5)
			RETURN -6
		IF (@CollageTemplateId NOT LIKE 'CT%')
			RETURN -7

        UPDATE CustomisedCollageTemplate
		SET CollageTemplateId = @CollageTemplateId, CollageTemplateName = @CollageTemplateName,
		BackGroundColor = @BackGroundColor, FontSize = @FontSize, TextAlign = @TextAlign, 
		TextValue = @TextValue, TextColor = @TextColor, Border = @Border, BorderColor = @BorderColor, NumberOfImages = @NumberOfImages,
		ImageURL = @ImageURL
		WHERE (CollageTemplateId = @CollageTemplateId)
		IF EXISTS(
			SELECT CollageTemplateId FROM CustomisedCollageTemplate
			WHERE CollageTemplateName = @CollageTemplateName AND 
			BackGroundColor = @BackGroundColor AND FontSize = @FontSize AND
			TextAlign = @TextAlign AND TextValue = @TextValue AND TextColor = @TextColor AND
			Border = @Border AND @BorderColor = @BorderColor AND NumberOfImages = @NumberOfImages AND ImageURL = @ImageUrl
			AND EmailId = @EmailId)
				RETURN 1

			ELSE
				RETURN -8

      END TRY
	  BEGIN CATCH	      
		  RETURN -99

	  END CATCH
END
GO

CREATE PROCEDURE usp_UpdateCustomisedCalendar
(
    @CalendarTemplateId VARCHAR(50),
	@CalendarTemplateName VARCHAR(50),
	@Holidays VARCHAR(200),
	@BackGroundColor VARCHAR(50),
	@FontSize  VARCHAR(50),
	@TextAlign VARCHAR(50),
	@Padding VARCHAR(50),
	@TextColor VARCHAR(50),
	@BorderPadding VARCHAR(50),
	@EmailId VARCHAR(50)
) 
AS 
BEGIN
      BEGIN TRY
        IF (@CalendarTemplateId IS NULL)
			RETURN -1
		IF (@CalendarTemplateId NOT LIKE 'CC%' or LEN(@CalendarTemplateId)<5)
			RETURN -2
		IF (@CalendarTemplateName IS NULL)
			RETURN -3
		IF ((@EmailId IS NULL) OR LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4	
		IF(@BackGroundColor IS NULL)
			RETURN -5

        UPDATE CustomisedCalendarTemplate
		SET CalendarTemplateId = @CalendarTemplateId, CalendarTemplateName = @CalendarTemplateName, Holidays = @Holidays,
		BackGroundColor = @BackGroundColor, FontSize = @FontSize, TextAlign = @TextAlign, 
		Padding = @Padding, TextColor = @TextColor, BorderPadding = @BorderPadding
		WHERE (CalendarTemplateId = @CalendarTemplateId)
		RETURN 1
      END TRY

	  BEGIN CATCH	      
		  RETURN -99

	  END CATCH
END
GO

CREATE FUNCTION ufn_GenerateCustomisedAdvertisementTemplateId()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @AdvertisementTemplateId CHAR(10)	
	IF NOT EXISTS(SELECT AdvertisementTemplateId FROM CustomisedAdvertisementTemplate)
		SET @AdvertisementTemplateId='CA100'		
	ELSE
		SELECT @AdvertisementTemplateId='CA'+CAST(CAST(SUBSTRING(MAX(AdvertisementTemplateId),3,3) AS INT)+1 AS CHAR) FROM CustomisedAdvertisementTemplate
	RETURN @AdvertisementTemplateId	
END
GO

CREATE PROCEDURE usp_AddCustomisedAdvertisementTemplate
(
	@AdvertisementTemplateName VARCHAR(50),
	@BackGroundColor VARCHAR(50),
	@FontSize VARCHAR(200),
	@TextAlign VARCHAR(200),
	@Padding VARCHAR(200),
	@TextColor VARCHAR(200),
	@BorderPadding VARCHAR(1000),
	@EmailId VARCHAR(50),
	@AdvertisementTemplateId VARCHAR(50) OUT
)
AS
BEGIN
	--SET @AdvertisementTemplateId = 'A-1'
	BEGIN TRY
		IF (@AdvertisementTemplateName IS NULL)
			RETURN -1
		IF (@EmailId IS NULL)
			RETURN -2
		IF(@BackGroundColor IS NULL)
			RETURN -3
		IF (LEN(@EmailId)<4 OR LEN(@EmailId)>50)
			RETURN -4
		--DECLARE @advertisementTemplateId CHAR(10)
		SET @AdvertisementTemplateId = dbo.ufn_GenerateCustomisedAdvertisementTemplateId()
		
		INSERT INTO CustomisedAdvertisementTemplate VALUES 
		(@AdvertisementTemplateId, @AdvertisementTemplateName, @BackGroundColor, @FontSize, @TextAlign, @Padding, @TextColor, 
		@BorderPadding, @EmailId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO


----insertion scripts for roles
SET IDENTITY_INSERT Roles ON
INSERT INTO Roles (RoleId, RoleName) VALUES (1, 'Admin')
INSERT INTO Roles (RoleId, RoleName) VALUES (2, 'Customer')
SET IDENTITY_INSERT Roles OFF

----insertion scripts for Users
INSERT INTO Users( EmailId,UserPassword,FirstName,LastName,PhoneNumber,RoleId) VALUES('Ajay@gmail.com','BSBEV@1234','Ajay','sk','9988776659','1')
INSERT INTO Users( EmailId,UserPassword,FirstName,LastName,PhoneNumber,RoleId) VALUES('Vijay@gmail.com','BSBEV@1234','Vijay','vv','8263789072','2')
INSERT INTO Users( EmailId,UserPassword,FirstName,LastName,PhoneNumber,RoleId) VALUES('Sujay@gmail.com','BSBEV@1234','Sujay','kp','7888776657','2')
INSERT INTO Users( EmailId,UserPassword,FirstName,LastName,PhoneNumber,RoleId) VALUES('Mariya@gmail.com','BSBEV@1234','Mariya','vb','8904563782','2')


----insertion scripts Template
INSERT INTO CollageTemplate(CollageTemplateId, CollageTemplateName, BackGroundColor, FontSize, TextAlign, Padding, TextColor, BorderPadding, EmailId) VALUES('T101','Examplecollage','green','20px','left','70px','black','xyz','Ajay@gmail.com')
INSERT INTO CustomisedCalendarTemplate(CalendarTemplateId, CalendarTemplateName, Holidays, BackGroundColor, FontSize, TextAlign, Padding, TextColor, BorderPadding, EmailId) VALUES('CC101','Examplecollage','20','green','20px','left','70px','black','xyz','Vijay@gmail.com')
INSERT INTO AdvertisementTemplate(AdvertisementTemplateId, AdvertisementTemplateName, BackGroundColor, FontSize, TextAlign, Padding, TextColor, BorderPadding, EmailId) VALUES('A101','Examplecollage','green','20px','left','70px','black','xyz','Vijay@gmail.com')
--GO

--SELECT * FROM [Roles]
SELECT * FROM [Users];
SELECT * FROM [CollageTemplate]
SELECT * FROM [CustomisedCalendarTemplate]
SELECT * FROM [AdvertisementTemplate]
SELECT * FROM [Feedback];
--GO
SELECT * FROM [CustomisedCollageTemplate]

--select * from users
DELETE FROM CustomisedCalendarTemplate


