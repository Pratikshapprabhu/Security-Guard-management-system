USE [master]
GO

IF (EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = N'SecurityGuardDB'OR name = N'SecurityGuardDB')))
DROP DATABASE SecurityGuardDB

CREATE DATABASE SecurityGuardDB
GO

USE SecurityGuardDB
GO

IF OBJECT_ID('Roles')  IS NOT NULL
DROP TABLE Roles
GO

IF OBJECT_ID('Users')  IS NOT NULL
DROP TABLE Users
GO

IF OBJECT_ID('Employee')  IS NOT NULL
DROP TABLE Employee
GO

IF OBJECT_ID('EmpUserRole')  IS NOT NULL
DROP TABLE EmpUserRole
GO

IF OBJECT_ID('Company')  IS NOT NULL
DROP TABLE Company
GO

IF OBJECT_ID('CompanyBranch')  IS NOT NULL
DROP TABLE CompanyBranch
GO

IF OBJECT_ID('Bank')  IS NOT NULL
DROP TABLE Bank
GO
   
IF OBJECT_ID('EmpBankAccount')  IS NOT NULL
DROP TABLE EmpBankAccount
GO

IF OBJECT_ID('Clients')  IS NOT NULL
DROP TABLE Clients
GO

IF OBJECT_ID('Agreement')  IS NOT NULL
DROP TABLE Agreement
GO

IF OBJECT_ID('CompanyBranchClient')  IS NOT NULL
DROP TABLE CompanyBranchClient
GO

IF OBJECT_ID('ClientLocation')  IS NOT NULL
DROP TABLE ClientLocation
GO

IF OBJECT_ID('PricingPlan')  IS NOT NULL
DROP TABLE PricingPlan
GO

IF OBJECT_ID('DutyShift')  IS NOT NULL
DROP TABLE DutyShift
GO

IF OBJECT_ID('ShiftsLocation')  IS NOT NULL
DROP TABLE ShiftsLocation
GO

IF OBJECT_ID('ShiftSchedule')  IS NOT NULL
DROP TABLE ShiftSchedule
GO

IF OBJECT_ID('HolidaysList')  IS NOT NULL
DROP TABLE HolidaysList
GO

IF OBJECT_ID('Invoice')  IS NOT NULL
DROP TABLE Invoice
GO

IF OBJECT_ID('PaymentDetails')  IS NOT NULL
DROP TABLE PaymentDetails
GO

IF OBJECT_ID('Suppliers')  IS NOT NULL
DROP TABLE Suppliers
GO

IF OBJECT_ID('CurrentBasic')  IS NOT NULL
DROP TABLE CurrentBasic
GO

IF OBJECT_ID('Salary')  IS NOT NULL
DROP TABLE Salary
GO

IF OBJECT_ID('LeaveType')  IS NOT NULL
DROP TABLE LeaveType
GO

IF OBJECT_ID('LeaveApplication')  IS NOT NULL
DROP TABLE LeaveApplication
GO

IF OBJECT_ID('usp_RegisterUser') IS NOT NULL
DROP PROC usp_RegisterUser
GO

IF OBJECT_ID('usp_AddEmployee') IS NOT NULL
DROP PROC usp_AddEmployee
GO

IF OBJECT_ID('usp_AddClient') IS NOT NULL
DROP PROC usp_AddClient
GO


IF OBJECT_ID('ufn_CheckEmailId')  IS NOT NULL
DROP FUNCTION ufn_CheckEmailId
GO

IF OBJECT_ID('ufn_ValidateUserCredentials')  IS NOT NULL
DROP FUNCTION ufn_ValidateUserCredentials
GO

IF OBJECT_ID('ufn_CheckForeignKeys')  IS NOT NULL
DROP FUNCTION ufn_CheckForeignKeys
GO

IF OBJECT_ID('ufn_GenerateEmployeeId')  IS NOT NULL
DROP FUNCTION ufn_GenerateEmployeeId
GO

IF OBJECT_ID('ufn_GenerateBranchId')  IS NOT NULL
DROP FUNCTION ufn_GenerateBranchId
GO

CREATE TABLE Roles
(
	[RoleId] INT CONSTRAINT pk_RoleId PRIMARY KEY,
	[RoleName] VARCHAR(20) CONSTRAINT uq_RoleName UNIQUE,
	[RoleCode] VARCHAR(20) CONSTRAINT uq_RoleCode UNIQUE,
	[RoleDescription] VARCHAR(200)
)
GO 

CREATE TABLE Users
( 	
	[UserId] INT CONSTRAINT pk_UserId PRIMARY KEY IDENTITY(1,1),
	[UserName] VARCHAR(50) NOT NULL,
	[UserPassword] VARCHAR(15) NOT NULL,
	[Email] VARCHAR(20) NOT NULL,
	[PhoneNumber] BIGINT NOT NULL,
)
GO

CREATE TABLE Employee
(
	[EmpId] VARCHAR(50) CONSTRAINT pk_empId PRIMARY KEY,
	[EmpName] VARCHAR(20) NOT NULL,
	[Email] VARCHAR(20) NOT NULL,
	[Address]  VARCHAR(50) NOT NULL,
	[City] VARCHAR(20) NOT NULL,
	[PinCode] INT NOT NULL,
	[PAN] VARCHAR(20) NOT NULL,
	[AdharNumber] BIGINT NOT NULL,
	[Photo] VARCHAR(50) NOT NULL,
	[RoleId] INT CONSTRAINT fk_roleId FOREIGN KEY  REFERENCES Roles(RoleId)  ON DELETE CASCADE NOT NULL ,
	[UserId] INT CONSTRAINT fk_userId2 FOREIGN KEY REFERENCES Users(UserId) ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE EmpUserRole
(	
	[EURId] INT CONSTRAINT pk_eURId PRIMARY KEY,
	[UserId] INT CONSTRAINT fk_userId3 FOREIGN KEY  REFERENCES Users(UserId),
	[RoleId] INT CONSTRAINT fk_roleId2 FOREIGN KEY  REFERENCES Roles(RoleId),
	[EmpId] VARCHAR(50)  CONSTRAINT fk_empId3 FOREIGN KEY  REFERENCES Employee(EmpId),
	[FromDate] DATE NOT NULL,
	[ToDate] DATE,
	[Status] VARCHAR(20) NOT NULL,
)
Go

CREATE TABLE Company
(
	[CompanyId] VARCHAR(20) CONSTRAINT pk_companyId PRIMARY KEY,
	[CompanyName] VARCHAR(50) NOT NULL,
	[Address] VARCHAR(50),
	[City] VARCHAR(20),
	[PinCode] INT,
	[GST] VARCHAR(15) CONSTRAINT uq_gst UNIQUE,
	[TIN] VARCHAR(10) CONSTRAINT uq_tin UNIQUE,
)
GO

CREATE TABLE CompanyBranch
(
	[BranchId] VARCHAR(20) CONSTRAINT pk_branchId PRIMARY KEY,
	[BranchName] VARCHAR(20) NOT NULL,
	[Address] VARCHAR(50),
	[City] VARCHAR(20),
	[PinCode] INT,
	[CompanyId] VARCHAR(20) CONSTRAINT fk_companyId FOREIGN KEY REFERENCES Company(CompanyId)  ON DELETE CASCADE NOT NULL ,
)
GO

CREATE TABLE Bank
(
	[BankId] VARCHAR(20) CONSTRAINT pk_bankId PRIMARY KEY,
	[BankName] VARCHAR(20) NOT NULL,
	[BranchName] VARCHAR(20) NOT NULL,
	[Address] VARCHAR(50) NOT NULL,
	[City] VARCHAR(20) NOT NULL,
	[IFSC] VARCHAR(12) CONSTRAINT uq_ifsc UNIQUE NOT NULL
)
GO

CREATE TABLE EmpBankAccount
(
	[AccountId] INT IDENTITY(1,1),
	[AccountNumber] BIGINT CONSTRAINT pk_accntNumber PRIMARY KEY,
	[AccountType] VARCHAR(10),
	[IFSC] VARCHAR(20) NOT NULL, 
	[BankId] VARCHAR(20) CONSTRAINT fk_bankId FOREIGN KEY REFERENCES Bank(BankId)  ON DELETE CASCADE NOT NULL ,
	[EmpId] VARCHAR(50) CONSTRAINT fk_empId1 FOREIGN KEY REFERENCES Employee(EmpId)  ON DELETE CASCADE NOT NULL
)
GO

CREATE TABLE Client
(
	[ClientId] VARCHAR(20) CONSTRAINT pk_clientId PRIMARY KEY,
	[ClientName] VARCHAR(50),
	[Address] VARCHAR(50),
	[City] VARCHAR(20),
	[Email] VARCHAR(20),
	[PinCode] INT,
	[GST] VARCHAR(20),
	[PAN] VARCHAR(20) CONSTRAINT uq_pan UNIQUE NOT NULL
)
GO

CREATE TABLE Agreement
(	
	[AgreementId] VARCHAR(20) CONSTRAINT pk_agreeId PRIMARY KEY,
	[DateOfAgreement] DATE NOT NULL,
	[ValidUpTo] DATE NOT NULL,
	[Status] VARCHAR(20),
	[Document] VARBINARY(max) NOT NULL,
	[CompanyId] VARCHAR(20) CONSTRAINT fk_companyId1 FOREIGN KEY REFERENCES Company(CompanyId)  ON DELETE CASCADE NOT NULL ,
	[ClientId] VARCHAR(20) CONSTRAINT fk_clientId FOREIGN KEY REFERENCES Client(ClientId)  ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE CompanyBranchClient
(
	[CBCId] INT CONSTRAINT pk_cbcId PRIMARY KEY,
	[ClientId] VARCHAR(20) CONSTRAINT fk_clientId1 FOREIGN KEY REFERENCES Client(ClientId)  ON DELETE CASCADE NOT NULL ,
	[BranchId] VARCHAR(20) CONSTRAINT fk_branchId FOREIGN KEY REFERENCES CompanyBranch(BranchId)  ON DELETE CASCADE NOT NULL ,
	[FromDate] DATE,
	[ToDate] DATE,
	[Status] VARCHAR(20)
)
GO

CREATE TABLE ClientLocation
(
	[LocationId] VARCHAR(20)  CONSTRAINT pk_locId PRIMARY KEY,
	[LocationName] VARCHAR(20),
	[Address] VARCHAR(50),
	[City] VARCHAR(20),
	[GPS] VARCHAR(50),
	[GPSRange] VARCHAR(50),
	[GuardsPerShift] INT,
	[ClientId] VARCHAR(20) CONSTRAINT fk_clientId2 FOREIGN KEY REFERENCES Client(ClientId)  ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE PricingPlan
(
	[PricingPlanId] VARCHAR(20)  CONSTRAINT pk_priceplanId PRIMARY KEY,
	[Amount] FLOAT,
	[Unit] INT,
	[FromDate] DATE NOT NULL,
	[ToDate] DATE,
	[AgreementDoc] VARBINARY(max) NOT NULL,
	[Status] VARCHAR(20),
	[ClientId] VARCHAR(20) CONSTRAINT fk_clientId3 FOREIGN KEY REFERENCES Client(ClientId) ,
	[LocationId] VARCHAR(20) CONSTRAINT fk_locationId FOREIGN KEY REFERENCES ClientLocation(LocationId) ,
	[BranchId] VARCHAR(20) CONSTRAINT fk_branchId1 FOREIGN KEY REFERENCES CompanyBranch(BranchId) NOT NULL 
)
GO

CREATE TABLE DutyShift
(
	[ShiftId] VARCHAR(20) CONSTRAINT pk_shiftId PRIMARY KEY,
	[ShiftName] VARCHAR(20),
	[FromTime] TIME,
	[ToTime] TIME,
	[ShiftCode] VARCHAR(20) NOT NULL
)
GO

CREATE TABLE ShiftsLocation
(   
	[ShiftsLocationId] INT CONSTRAINT pk_shiftsLocId PRIMARY KEY,
	[FromDate] DATE,
	[ToDate] DATE,
	[Status] VARCHAR(20),
	[WeekDay] VARCHAR(10),
	[LocationId] VARCHAR(20) CONSTRAINT fk_locationId1 FOREIGN KEY REFERENCES ClientLocation(LocationId)  ON DELETE CASCADE NOT NULL ,
	[ShiftId] VARCHAR(20) CONSTRAINT fk_shiftId FOREIGN KEY REFERENCES DutyShift(ShiftId)  ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE ShiftSchedule
(
	[GLShiftId] VARCHAR(20) CONSTRAINT pk_gshiftId PRIMARY KEY,
	[ScheduledDate] DATE,
	[AttendanceStatus] VARCHAR(20),
	[DutyReportingTime] TIME,
	[DutyRelievingTime] TIME,
	[LocationId] VARCHAR(20) CONSTRAINT fk_locationId2 FOREIGN KEY REFERENCES ClientLocation(LocationId) ON DELETE CASCADE NOT NULL ,
	[ShiftId] VARCHAR(20) CONSTRAINT fk_shiftId1 FOREIGN KEY REFERENCES DutyShift(ShiftId)  ON DELETE CASCADE NOT NULL 
)
GO


CREATE TABLE HolidaysList
(
	[HolidayId] VARCHAR(20) CONSTRAINT pk_holodayId PRIMARY KEY,
	[HolidayDate] DATE,
	[HolidayType] VARCHAR(20),
	[HolidayName] VARCHAR(20)
)
GO

CREATE TABLE Invoice
(
	[InvoiceNumber] BIGINT CONSTRAINT pk_invoiceNo PRIMARY KEY,
	[InvoiceDate] DATE,
	[GLShiftIdId] VARCHAR(20) CONSTRAINT fk_gshiftId FOREIGN KEY REFERENCES ShiftSchedule(GLShiftId) ON DELETE CASCADE NOT NULL ,
	[HolidayId] VARCHAR(20) CONSTRAINT fk_holidayId FOREIGN KEY REFERENCES HolidaysList(HolidayId)  ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE PaymentDetails
(
	[PayerName] VARCHAR(20),
	[AmountPaid] BIGINT,
	[TotalAmount] BIGINT,
	[PaymentType] VARCHAR(20),
	[PaymentDate] DATE,
	[TransactionId] BIGINT CONSTRAINT pk_transactionId PRIMARY KEY,
	[BalanceAmount] BIGINT,
	[PaymentMethod] VARCHAR(20),
	[BankName] VARCHAR(20),
	[InvoiceNumber] BIGINT  CONSTRAINT fk_invoiceNo FOREIGN KEY REFERENCES Invoice(InvoiceNumber)  ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE CurrentBasic
(
	[Scale] BIGINT,
	[Basic] BIGINT,
	[SiId] VARCHAR(20) CONSTRAINT pk_siId PRIMARY KEY,
	[DateOfIncrement] DATE,
	[Status] VARCHAR(10),
	[EmpId] VARCHAR(50) CONSTRAINT fk_empId2 FOREIGN KEY REFERENCES Employee(EmpId) ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE Salary 
(
	[SalaryId] VARCHAR(20) CONSTRAINT pk_salaryId PRIMARY KEY,
	[Basic] BIGINT,
	[DA] BIGINT,
	[HRA] BIGINT,
	[Incenive] BIGINT,
	[CCA] BIGINT,
	[GrossSalary] BIGINT,
	[IncoomeTax] VARCHAR(20),
	[FBF] VARCHAR(20),
	[InsurancePremium] VARCHAR(10),
	[PF] BIGINT,
	[GroupInsurance] BIGINT,
	[QuartersRent] BIGINT,
	[GroupGratuity] VARCHAR(20),
	[NetSalary] VARCHAR(20),
	[SalaryDate] DATE,
	[SalaryForMonthYear] VARCHAR(20),
	[SiId] VARCHAR(20) CONSTRAINT fk_siId FOREIGN KEY REFERENCES CurrentBasic(SiId) ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE LeaveType
(
	[LtId] VARCHAR(20) CONSTRAINT pk_ltId PRIMARY KEY,
	[LeaveTypeName] VARCHAR(10),
	[LeavePerYear] INT
)
GO

CREATE TABLE LeaveApplication
(
	[LeaveApplicationId] VARCHAR(20) CONSTRAINT pk_leaveId PRIMARY KEY,
	[FromDate] DATE,
	[ToDate] DATE,
	[NoOfDays] INT,
	[Reason] VARCHAR(50),
	[LeaveApplicationDate] DATE,
	[ApprovedStatus] VARCHAR(10),
	[EmpId] VARCHAR(50) CONSTRAINT fk_empId4 FOREIGN KEY  REFERENCES Employee(EmpId)  ON DELETE CASCADE NOT NULL ,
	[SubstituteEmployeeId] VARCHAR(20),
	[ApprovedBy] VARCHAR(20),
	[LtId] VARCHAR(20) CONSTRAINT fk_ltId FOREIGN KEY  REFERENCES LeaveType(LtId)  ON DELETE CASCADE NOT NULL 
)
GO

CREATE TABLE Suppliers 
(
	[SupplierId] VARCHAR(20) CONSTRAINT pk_supplierId PRIMARY KEY,
	[SupplierName] VARCHAR(20),
	[ShopName] VARCHAR(20),
	[ShopAddress] VARCHAR(50),
	[LandMark] VARCHAR(20),
	[MobileNumber] BIGINT,
	[Telephone] BIGINT,
	[EmailId] VARCHAR(20),
	[Website] VARCHAR(50),
	[ProprietorPhoto] VARCHAR(50),
	[GSTNumber] BIGINT,
	[City] VARCHAR(20)
)
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION ufn_CheckEmailId
(
	@Email VARCHAR(50)
)
RETURNS BIT
AS
BEGIN	
	DECLARE @ReturnValue BIT
	IF NOT EXISTS (SELECT Email FROM Users WHERE Email=@Email)
		SET @ReturnValue=1
	ELSE 
		SET @ReturnValue=0
	RETURN @ReturnValue
END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION ufn_CheckForeignKeys
(
	@RoleId INT,
	@Email VARCHAR(50)
)
RETURNS BIT
AS
BEGIN	
	DECLARE @ReturnValue BIT
	IF NOT EXISTS (SELECT Email FROM Users WHERE Email=@Email) 
    AND
	 NOT EXISTS (SELECT RoleId FROM Roles WHERE RoleId=@RoleId) 
		SET @ReturnValue=1
	ELSE 
		SET @ReturnValue=0
	RETURN @ReturnValue
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION ufn_ValidateUserCredentials
(
	@Email VARCHAR(50),
    @UserPassword VARCHAR(15)
)
RETURNS INT
AS
BEGIN
	DECLARE @UserId INT
	SELECT @UserId=UserId FROM Users WHERE Email=@Email AND UserPassword=@UserPassword
	RETURN @UserId
END
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION ufn_GenerateEmployeeId()
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @EmpId CHAR(10)	
	IF NOT EXISTS(SELECT EmpId FROM Employee)
		SET @EmpId='E100'		
	ELSE
		SELECT @EmpId='E'+CAST(CAST(SUBSTRING(MAX(EmpId),2,3) AS INT)+1 AS CHAR) FROM Employee
	RETURN @EmpId	
END
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION ufn_GenerateBranchId()
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @BranchId CHAR(20)	
	IF NOT EXISTS(SELECT BranchId FROM CompanyBranch)
		SET @BranchId='COMPB101'		
	ELSE
		SELECT @BranchId='COMPB'+CAST(CAST(SUBSTRING(MAX(BranchId),6,9) AS INT)+1 AS CHAR) FROM CompanyBranch
	RETURN @BranchId	
END
GO
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE usp_RegisterUser
(
	@UserName VARCHAR(50),
	@UserPassword VARCHAR(15),
	@Email VARCHAR(20),
	@PhoneNumber BIGINT
)
AS
BEGIN
	BEGIN TRY
		IF (@Email IS NULL)
			RETURN -1

		DECLARE @CheckEmailId BIT
		SET @CheckEmailId = dbo.ufn_CheckEmailId(@Email)
		IF (@CheckEmailId = 0)
			RETURN -2

		IF (@UserPassword IS NULL)
			RETURN -3
		IF (@UserName IS NULL)
			RETURN -4
		IF (@PhoneNumber IS NULL) 
			RETURN -6
		IF (LEN(@UserPassword)<8)
			RETURN -7
		IF (LEN(@UserPassword)>16)
			RETURN -8
		IF (@Email  NOT LIKE '[0-9a-zA-Z]%@__%.__%') 
			RETURN -9
		IF (@PhoneNumber  NOT LIKE '[1-9]%') 
			RETURN -14
		IF (LEN(@PhoneNumber)<> 10)
			RETURN -15

		INSERT INTO Users VALUES 
		(@UserName,@UserPassword,@Email,@PhoneNumber)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO
----------------------------------------------------------------ADD EMPLOYEE--------------------------------------------------------------------
CREATE PROCEDURE usp_AddEmployee
(
	@EmpName VARCHAR(20),
	@Email VARCHAR(20),
	@Address VARCHAR(50),
	@City VARCHAR(20),
	@PinCode INT,
	@Pan VARCHAR(20),
	@AdharNumber BIGINT,
	@Photo VARCHAR(50),
	@RoleId INT
)
AS
BEGIN
	BEGIN TRY
		IF (@Email IS NULL)
			RETURN -1
		DECLARE @CheckForeignKeys BIT
		SET @CheckForeignKeys = dbo.ufn_CheckForeignKeys(@RoleId,@Email)
		IF(@CheckForeignKeys = 1)
			RETURN -2		
		IF (@Email  NOT LIKE '[0-9a-zA-Z]%@__%.__%') 
			RETURN -3
		IF (@EmpName IS NULL)
			RETURN -4
		IF (@EmpName NOT LIKE '[A-Za-z]%') 
			RETURN -5
		IF (@Address IS NULL)
			RETURN -6
		IF (@City IS NULL)
			RETURN -7
		IF (@PinCode IS NULL)
			RETURN -8
		IF (@Pan IS NULL)
			RETURN -9
		IF (@AdharNumber IS NULL)
			RETURN -10
		IF (@Photo IS NULL)
			RETURN -11
		IF (@RoleId IS NULL)
			RETURN -12
		IF (LEN(@AdharNumber)<> 12)
			RETURN -13
		DECLARE @UserId INT
		SELECT @UserId=UserId FROM Users WHERE Email=@Email

		DECLARE @EmpId VARCHAR(50)
		SET @EmpId = dbo.ufn_GenerateEmployeeId()
		
		INSERT INTO Employee VALUES 
		(@EmpId,@EmpName,@Email,@Address,@City,@PinCode,@Pan,@AdharNumber,@Photo,@RoleId,@UserId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

--DECLARE @ReturnValue INT
--EXEC @ReturnValue = usp_AddEmployee 'Pratiksha','Pratiksha@gmail.com','Siddapur','Siddapur','581222','FPPNB4534O','989823124','Photo.jpg','1'
--SELECT @ReturnValue
--GO

------------------------------------------ADD CLIENT-----------------------------------------------------------------------------
--CREATE PROCEDURE usp_AddClient
--(
--	@ClientName VARCHAR(50),
--	@Address VARCHAR(50),
--	@City VARCHAR(20),
--	@Email VARCHAR(20),
--	@PinCode INT,
--	@GST VARCHAR(20),
--	@PAN VARCHAR(20)
--)
--AS
--BEGIN
--	BEGIN TRY
--		IF (@ClientName IS NULL)
--			RETURN -1

--		INSERT INTO Client VALUES 
--		(@ClientName,@Address,@City,@Email,@PinCode,@GST,@PAN)
--		RETURN 1
--	END TRY
--	BEGIN CATCH
--		RETURN -99
--	END CATCH
--END
--GO	
----------------------------------------Add Company Branch--------------------------------------------------------------------------------------------------------
CREATE PROCEDURE usp_AddCompanyBranch
(
	@BranchName VARCHAR(20),
	@Address VARCHAR(50),
	@City VARCHAR(20),
	@PinCode INT
)
AS
BEGIN
	BEGIN TRY
		IF (@BranchName IS NULL)
			RETURN -1
		IF (@Address IS NULL)
			RETURN -2
		IF (@City IS NULL)
			RETURN -3
		IF (@PinCode IS NULL)
			RETURN -4
		
		
		DECLARE @CompanyId VARCHAR(20)
		SELECT @CompanyId=CompanyId FROM Company WHERE CompanyName='Security Company'

		DECLARE @BranchId VARCHAR(20)
		SET @BranchId = dbo.ufn_GenerateBranchId()
		
		INSERT INTO CompanyBranch VALUES 
		(@BranchId,@BranchName,@Address,@City,@PinCode,@CompanyId)
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -99
	END CATCH
END
GO

--DECLARE @ReturnValue INT
--EXEC @ReturnValue = usp_AddEmployee 'Pratiksha','Pratiksha@gmail.com','Siddapur','Siddapur','581222','FPPNB4534O','989823124','Photo.jpg','1'
--SELECT @ReturnValue
--GO

------------------------------------------Add Bank Account--------------------------------------------------------------------------------------------------------
--CREATE PROCEDURE usp_AddEmpBankAccount
--(
--	@BranchName VARCHAR(20),
--	@Address VARCHAR(50),
--	@City VARCHAR(20),
--	@PinCode INT
--)
--AS
--BEGIN
--	BEGIN TRY
--		IF (@BranchName IS NULL)
--			RETURN -1
--		IF (@Address IS NULL)
--			RETURN -2
--		IF (@City IS NULL)
--			RETURN -3
--		IF (@PinCode IS NULL)
--			RETURN -4
		
		
--		DECLARE @CompanyId VARCHAR(20)
--		SELECT @CompanyId=CompanyId FROM Company WHERE CompanyName='Security Company'

--		DECLARE @BranchId VARCHAR(20)
--		SET @BranchId = dbo.ufn_GenerateBranchId()
		
--		INSERT INTO CompanyBranch VALUES 
--		(@BranchId,@BranchName,@Address,@City,@PinCode,@CompanyId)
--		RETURN 1
--	END TRY
--	BEGIN CATCH
--		RETURN -99
--	END CATCH
--END
--GO

----DECLARE @ReturnValue INT
----EXEC @ReturnValue = usp_AddEmployee 'Pratiksha','Pratiksha@gmail.com','Siddapur','Siddapur','581222','FPPNB4534O','989823124','Photo.jpg','1'
----SELECT @ReturnValue
----GO


--INSERT INTO Roles(RoleId, RoleName, RoleCode, RoleDescription) VALUES ('1','Admin','A101','Admin can handle the whole webapplication')
--INSERT INTO Roles(RoleId, RoleName, RoleCode, RoleDescription) VALUES ('2','Security Guard','G101','In-house or proprietary')
--INSERT INTO Roles(RoleId, RoleName, RoleCode, RoleDescription) VALUES ('3','Security Supervisor', 'S101','Meets with clients and employees as necessary to ensure client and employee satisfaction')
--INSERT INTO Roles(RoleId, RoleName, RoleCode, RoleDescription) VALUES ('4','Scheduler','R101','Employee retention and cost maintained')
--INSERT INTO Roles(RoleId, RoleName, RoleCode, RoleDescription) VALUES ('5','HR','H101','Effective delivery of human resources servicessuch as employment, employee relations')
--INSERT INTO Roles(RoleId, RoleName, RoleCode, RoleDescription) VALUES ('6','Csevice manager','M101','Promotes financial growth for the District by ensuring client retention')
--INSERT INTO Roles(RoleId, RoleName, RoleCode, RoleDescription) VALUES ('7','Csevice supervisor','C101','Provides security sevices for designated clients resulting in customer satisfaction, Security officer retention and financial growth for the District')
--GO

--INSERT INTO Users(UserName, UserPassword, Email, PhoneNumber) VALUES ('Pratiksha P','Abc@123','Pratiksha@gmail.com','9988998899')
--INSERT INTO Users(UserName, UserPassword, Email, PhoneNumber) VALUES ('Deepti P','Bbc@123','Deepti@gmail.com','9988998811')
--INSERT INTO Users(UserName, UserPassword, Email, PhoneNumber) VALUES ('Ajay','Cbc@123','Ajay@gmail.com','9988998822')
--INSERT INTO Users(UserName, UserPassword, Email, PhoneNumber) VALUES ('Vijay','Dbc@123','Vijay@gmail.com','9988998833')
--INSERT INTO Users(UserName, UserPassword, Email, PhoneNumber) VALUES ('Sujay','Ebc@123','Sujay@gmail.com','9988998844')
--GO

--INSERT INTO Company(CompanyId, CompanyName, Address, City, PinCode, GST, TIN) VALUES ('COMP101', 'Security Company', 'Vidyanagar', 'Hubli','581223', '34CIPPS5925M1ZF', 'xyz')
--GO

--INSERT INTO Bank(BankId, BankName, BranchName, Address, City, IFSC) VALUES('CANARA101','CANARA BANK', 'Vidyanagar Hubli', 'Vidyanagar', 'Hubli', 'CANARA000080')
--INSERT INTO Bank(BankId, BankName, BranchName, Address, City, IFSC) VALUES('SBI101','STATE BANK OF INDIA','Station Road Dharwad','Dharwad', 'Dharwad','SBI00000062')
--INSERT INTO Bank(BankId, BankName, BranchName, Address, City, IFSC) VALUES('KVGB101','KVG BANK', 'KVG BANK, Mangalore', 'Kodailbail', 'Mangalore', 'KVGB0000589')
--INSERT INTO Bank(BankId, BankName, BranchName, Address, City, IFSC) VALUES('AXIS101','AXIS BANK', 'AXIS BANK SIRSI', 'Belgaum road, Sirsi', 'Sirsi', 'AXIS0004545')
--INSERT INTO Bank(BankId, BankName, BranchName, Address, City, IFSC) VALUES('HDFC101','HDFC BANK', 'Vidyanagar Hubli', 'Vidyanagar', 'Hubli', 'HDFC0000580')
--GO

--INSERT INTO Employee(EmpId, EmpName,Email, Address, City, PinCode, PAN, AdharNumber, Photo, RoleId, UserId) VALUES ('E101','Pratiksha', 'Pratiksha@gmail.com','Siddapur','Siddapur','581222','FPPNB4534O','989823124565','photo.jpg','1','1')
--INSERT INTO Employee(EmpId, EmpName, Address, City, PinCode, PAN, AdharNumber, Photo, RoleId, UserId) VALUES ('E102','Deepti','Hubli','Hubli','581765','FPPcd7483P','769823125698','photo.jpg','2','5')
--INSERT INTO Employee(EmpId, EmpName, Address, City, PinCode, PAN, AdharNumber, Photo, RoleId, UserId) VALUES ('E103','Vijay','Sirsi','Sirsi','587689','FPPKA6756V','654823124590','photo.jpg','4','2')
--INSERT INTO Employee(EmpId, EmpName, Address, City, PinCode, PAN, AdharNumber, Photo, RoleId, UserId) VALUES ('E104','Ajay','Mangalore','Mangalore','543789','FPPKA6755O','659988998822','photo.jpg','3','2')
--INSERT INTO Employee(EmpId, EmpName, Address, City, PinCode, PAN, AdharNumber, Photo, RoleId, UserId) VALUES ('E105','Sujay','Bangalore','Bangalore','560002','FPPKA6711L','659988998844','photo.jpg','5','3')
--GO

--INSERT INTO EmpUserRole(EURID, UserId, RoleId, EmpId, FromDate, ToDate, Status) VALUES ('1','1', '1', 'E101','2022-01-01','','Current')
--INSERT INTO EmpUserRole(EURId, UserId, RoleId, EmpId, FromDate, ToDate, Status) VALUES ('2','5', '2', 'E102','2022-01-05','','Current')
--GO

--INSERT INTO CompanyBranch(BranchId,BranchName,Address,City,PinCode,CompanyId) VALUES ('COMPB101','MSecurityCompany','Mysore','Mysore','543456','COMP101')
--INSERT INTO CompanyBranch(BranchId,BranchName,Address,City,PinCode,CompanyId) VALUES ('COMPB102','BSecurityCompany','Banglore','Banglore','543489','COMP101')
--INSERT INTO CompanyBranch(BranchId,BranchName,Address,City,PinCode,CompanyId) VALUES ('COMPB103','SSecurityCompany','Sirsi','Sirsi','543409','COMP101')
--INSERT INTO CompanyBranch(BranchId,BranchName,Address,City,PinCode,CompanyId) VALUES ('COMPB104','ManSecurityCompany','Manglore','Manglore','543445','COMP101')
--INSERT INTO CompanyBranch(BranchId,BranchName,Address,City,PinCode,CompanyId) VALUES ('COMPB105','BadSecurityCompany','Badami','Badami','543472','COMP101')
--GO

--INSERT INTO EmpBankAccount(AccountNumber, AccountType,IFSC, BankId, EmpId) VALUES ('674593282209', 'Savings', '765656565','AXIS101','E101')
--INSERT INTO EmpBankAccount(AccountId, AccountNumber, AccountType, BankId, EmpId) VALUES ('2', '568999782098', 'Current', 'CANARA101','E101')
--INSERT INTO EmpBankAccount(AccountId, AccountNumber, AccountType, BankId, EmpId) VALUES ('3', '324593682009', 'Savings', 'HDFC101','E103')
--INSERT INTO EmpBankAccount(AccountId, AccountNumber, AccountType, BankId, EmpId) VALUES ('4', '634594782997', 'Savings', 'SBI101','E104')
--INSERT INTO EmpBankAccount(AccountId, AccountNumber, AccountType, BankId, EmpId) VALUES ('5', '767593382004', 'Current', 'KVGB101','E105')
--GO

--INSERT INTO Client(ClientId,ClientName,Address,City,Email,PinCode,GST,PAN) VALUES ('1', 'BVB', 'Vidyanagar', 'Hubli', 'bvb@edu.in','567678','12%','AACCS015IP')
--INSERT INTO Client(ClientId,ClientName,Address,City,Email,PinCode,GST,PAN) VALUES ('2', 'XYZ', 'Vidyanagar', 'Hubli', 'bvb@edu.in','567678','12%','AACCS0185P')
--INSERT INTO Client(ClientId,ClientName,Address,City,Email,PinCode,GST,PAN) VALUES ('3', 'BVB', 'Vidyanagar', 'Hubli', 'bvb@edu.in','567678','12%','AACCS0105P')
--INSERT INTO Client(ClientId,ClientName,Address,City,Email,PinCode,GST,PAN) VALUES ('4', 'BVB', 'Vidyanagar', 'Hubli', 'bvb@edu.in','567678','12%','AACCS0157P')
--INSERT INTO Client(ClientId,ClientName,Address,City,Email,PinCode,GST,PAN) VALUES ('5', 'BVB', 'Vidyanagar', 'Hubli', 'bvb@edu.in','567678','12%','AACCS0145P')
--GO

--INSERT INTO Agreement(AgreementId, DateOfAgreement, ValidUpTo, Status, Document, CompanyId, ClientId) VALUES ('AG101','2022-03-01','2025-03-01','Current',Cast('agreement.doc' As varbinary(max)),'COMP101','1')

--INSERT INTO CompanyBranchClient(CBCId,ClientId,BranchId,FromDate,ToDate,Status)VALUES('1','1','COMPB101','2022-03-01','2025-03-01','Current')
--GO

--INSERT INTO ClientLocation(LocationId,LocationName,Address,City,GPS,GPSRange,GuardsPerShift,ClientId)VALUES('L101','Ladies Hostel Hubli','Vidyanagr','Hubli','','','2','1')
--INSERT INTO ClientLocation(LocationId,LocationName,Address,City,GPS,GPSRange,GuardsPerShift,ClientId)VALUES('L102','Ladies Hostel2 Hubli','Vidyanagr','Hubli','','','2','1')
--INSERT INTO ClientLocation(LocationId,LocationName,Address,City,GPS,GPSRange,GuardsPerShift,ClientId)VALUES('L103','Boys Hostel Hubli','Vidyanagr','Hubli','','','2','1')
--INSERT INTO ClientLocation(LocationId,LocationName,Address,City,GPS,GPSRange,GuardsPerShift,ClientId)VALUES('L104','Boys Hostel2 Hubli','Vidyanagr','Hubli','','','2','1')
--INSERT INTO ClientLocation(LocationId,LocationName,Address,City,GPS,GPSRange,GuardsPerShift,ClientId)VALUES('L105','College Campus Hubli','Vidyanagr','Hubli','','','2','1')
--GO

--INSERT INTO PricingPlan(PricingPlanId,Amount,Unit,FromDate,ToDate,AgreementDoc,Status,ClientId,LocationId,BranchId)VALUES('P101','300000.00','1','2022-03-01','2022-09-01',Cast('agreement.doc' As varbinary(max)),'Current','1','L101','COMPB101')
--GO
 
--INSERT INTO DutyShift(ShiftId,ShiftName,FromTime,ToTime,ShiftCode)VALUES('SH101','Morning', '05:01:54.1237','13:01:54.1237','D101')
--INSERT INTO DutyShift(ShiftId,ShiftName,FromTime,ToTime,ShiftCode)VALUES('SH102','Day ','13:00:54.1237','21:01:54.1237','D102')
--INSERT INTO DutyShift(ShiftId,ShiftName,FromTime,ToTime,ShiftCode)VALUES('SH103','Night', '21:01:54.1237','05:01:54.1237','D103')
--INSERT INTO DutyShift(ShiftId,ShiftName,FromTime,ToTime,ShiftCode)VALUES('SH104','Day', '13:34:54.1237','21:01:54.1237','D102')
--INSERT INTO DutyShift(ShiftId,ShiftName,FromTime,ToTime,ShiftCode)VALUES('SH105','Night', '21:01:54.1237','05:01:54.1237','D103')
--GO

--INSERT INTO ShiftsLocation(ShiftsLocationId,FromDate,ToDate,Status,WeekDay,LocationId,ShiftId)VALUES('1','2022-02-01','2022-08-01','Current','WeekDay','L101','SH101')
--INSERT INTO ShiftsLocation(ShiftsLocationId,FromDate,ToDate,Status,WeekDay,LocationId,ShiftId)VALUES('2','2022-03-01','2022-09-01','Current','WeekDay','L102','SH102')
--INSERT INTO ShiftsLocation(ShiftsLocationId,FromDate,ToDate,Status,WeekDay,LocationId,ShiftId)VALUES('3','2022-03-01','2022-09-01','Current','WeekDay','L103','SH103')
------INSERT INTO ShiftsLocation(FromDate,ToDate,Status,WeekDay,LocationId,ShiftId)VALUES('2022-04-01','2022-10-01','Current','WeekDay','L104','SH104')
------INSERT INTO ShiftsLocation(FromDate,ToDate,Status,WeekDay,LocationId,ShiftId)VALUES('2022-05-01','2022-11-01','Current','WeekDay','L105','SH105')
--GO

--INSERT INTO ShiftSchedule(GLShiftId,ScheduledDate,AttendanceStatus,DutyReportingTime,DutyRelievingTime,LocationId,ShiftId)VALUES('GL101','2022-02-01','P','05:00:54.1237','13:00:54.1237','L101','SH101')
--GO

--INSERT INTO HolidaysList(HolidayId,HolidayDate,HolidayType,HolidayName)VALUES('HO101','2022-05-02','SL','Sick leave')
--GO

--SELECT * FROM Users
--SELECT * FROM Roles
--SELECT * FROM Employee
--SELECT * FROM EmpUserRole
--SELECT * FROM Company
--SELECT * FROM CompanyBranch
--SELECT * FROM Bank
--SELECT * FROM EmpBankAccount
--SELECT * FROM Client
--SELECT * FROM Agreement
--SELECT * FROM CompanyBranchClient
--SELECT * FROM ClientLocation
--SELECT * FROM PricingPlan
--SELECT * FROM DutyShift
--SELECT * FROM ShiftsLocation
--SELECT * FROM ShiftSchedule
--SELECT * FROM HolidaysList
--GO

--DELETE FROM Employee
--DELETE FROM EmpBankAccount
--GO
