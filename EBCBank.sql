/*
drop database EBC_Bank_Project
create database EBC_Bank_Project
use EBC_Bank_Project
*/	
------------------------------------------------------------------table one (4 region)
create table region																		
(Region_ID	INTEGER	Primary Key Identity,
REGION_NAME	CHAR(10)	NOT NULL,
IsActive bit DEFAULT(1),
CreatedDate datetime DEFAULT(GETDATE()),
ModifiedDate datetime)
---------------------------------------

create table Branch-------------------------table two (2 branch in each region(4) , total 8 branch)						
(Branch_ID int Primary Key Identity,
BRANCH_NAME	VARCHAR(30)	NOT NULL,
BRANCH_ADDRESS	VARCHAR(50)	NOT NULL,
Region_ID	INT NOT NULL Foreign Key references region(Region_ID) on delete cascade on update cascade
,IsActive bit DEFAULT(1),
CreatedDate datetime DEFAULT(GETDATE()),
ModifiedDate datetime);

----------------------------------------
create table [Employee]	----------------------------------table Three (3 employee each branch(8), total 24 employee)			
		(Employee_ID INTEGER Primary Key Identity,
		[Employee_NAME] VARCHAR(30)	NOT NULL,
		DESIGNATION	CHAR(7) NOT NULL check (DESIGNATION  in( 'MANAGER',  'TELLER' ,  'CLERK' )),
		branch_id int foreign key references branch(branch_id),
		IsActive bit DEFAULT(1),
		CreatedDate datetime DEFAULT(GETDATE()),
		ModifiedDate datetime);

-------------------------------------
create table Account_type  --------------------------------table four(4 account_type)Savings, Checking,Current
		(AccountType_ID	int	Primary Key Identity,
		Accounttype_Name VARCHAR(20)	not NULL
		,IsActive bit DEFAULT(1),
		CreatedDate datetime DEFAULT(GETDATE()),
		ModifiedDate datetime)

alter table account_type
add constraint UQ_accountname unique(Accounttype_Name)
-------------------------------------------------------
create table Customer (		--------------------------------table five(5 customers in each branch(8),total 40 customers)
		Customer_ID	INTEGER	Primary Key Identity,
		[Customer_Name]	VARCHAR(40)	NOT NULL ,
		[ADDRESS]	VARCHAR(50)	NOT NULL,
		Branch_ID	int	NOT NULL Foreign Key references Branch(Branch_ID) ON DELETE CASCADE ON UPDATE CASCADE,		
		IsActive bit DEFAULT(1),
		CreatedDate datetime DEFAULT(GETDATE()),
		ModifiedDate datetime);
		
alter table customer
add constraint UQ_Name_Adress_Customer unique([ADDRESS], customer_name)

---------------------------------------------------------
CREATE TABLE Account ----------------------------------------table six 
(
	Account_ID int PRIMARY KEY Identity(1,1),
	Customer_ID int	NOT NULL Foreign Key references Customer(Customer_ID),
	AccountType_ID	int	NOT NULL Foreign Key references account_type(accounttype_id) ON DELETE No action ON UPDATE CASCADE,
	CLEAR_BALANCE	MONEY	NULL,
	UNCLEAR_BALANCE	MONEY	NULL,
	[status] CHAR(40) not null check([Status] in ('OPERATIVE', 'INOPERATIVE','CLOSED')) DEFAULT ('OPERATIVE'),
	IsActive bit DEFAULT(1),
	CreatedDate datetime DEFAULT(GETDATE()),
	ModifiedDate datetime)

--12.	Uncleared balance should not be less than Cleared balance
alter table account
add constraint chk_CLEAR_UNCLEAR_BALANCE_Account
check (UNCLEAR_BALANCE > CLEAR_BALANCE)
--------------------------------------------
--13.	Minimum balance for Savings Bank should be $. 1,000/=
alter table account
add constraint chk_Savings_Account
check ((CLEAR_BALANCE) > 1000)
	
alter table account
add constraint UK_custmer_idandAcountid unique(customer_id, accounttype_id)

------------------------------------------------------------------

create table [TransactionDetail](---------------------------------table seven (5 transaction for each branch(8), total 40)
		TRANSACTION_ID	INTEGER	Primary Key  Identity, 
		TRANSACTION_Date DATETIME NOT NULL default getdate(),
		Customer_ID INTEGER NOT NULL Foreign Key references Customer(Customer_ID) on delete cascade on update cascade,
		Branch_ID int NOT NULL Foreign Key references BRANCH(Branch_ID) ON DELETE No action ON UPDATE no action,
		Transaction_Type CHAR(3) NOT NULL check (Transaction_Type in ('CW' , 'CD' , 'CQD')),
		check_number INTEGER	NULL,
		Check_Date	DATETIME 	NULL,
		Transaction_amount	MONEY	NOT NULL  ,
		Employee_ID	INTEGER	NOT NULL Foreign Key references [Employee](Employee_ID)  on delete cascade on update cascade
		,IsActive bit DEFAULT(1),
		CreatedDate datetime DEFAULT(GETDATE()),
		ModifiedDate datetime);
---------------------------------------
alter table [transactiondetail]
add constraint CHK_Tranaction_Date  
check (TRANSACTION_Date <= getdate() and check_date <= getdate())
---------------------------------------
alter table [transactiondetail]
add constraint chk_CHQ_DATE_TRANSACTION_Date_TRANSACTION  
check (TRANSACTION_Date >= Check_Date)
---------------------------------------
--3. A Cheque which is more than six months old should not be accepted

alter table [transactiondetail]
add constraint chk_CHQ_DATE_TRANSACTION  
check (Check_Date < DATEADD(month, 6, GETDATE()))
---------------------------------------
--9.	Transaction Amount should not be negative
 alter table [transactiondetail]
add constraint chk__TXN_AMOUNT_TRANSACTION  
check (Transaction_amount> 0)
---------------------------------------
--10.	Transaction Type should only be ‘CW’ or ‘CD’ or ‘CQD’
alter table [transactiondetail]
add constraint chk__TXN_TYPE_TRANSACTION  
check (Transaction_Type in ('CW', 'CD', 'CQD'))
---------------------------------------
----insert records into tables

 insert into region values('southern',1, '01/01/2018',  '05/01/2022') ,
('Northern',1, '12/10/2020', '03/02/2022'),
('Estern',1, '01/04/2019', '05/03/2022'),
('central',1, '04/04/2021', Null)

-----------------------------------------
insert into branch (branch_name, branch_address, region_id)
				 values ('florida branch', '2398 georigia ave', 1)
				 , ('maryland branch', '289 west ave', 2)
				 , ('new jersey branch', '1298 randolph ave', 3)
				 , ('washington branch', '4592 kenedy street', 1)
				 , ('new york branch', '1456 new york ave', 2)
				 , ('California branch', '908 washington ave', 4)
				 , ('Dallas branch', '564 versvile ave', 3)
				,  ('texas branch', '4592 colie dr', 4)

Insert INTO Account_Type (Accounttype_Name) Values
				('Debit Card' ),
                ('Credit Card' ),
                ('Saving Account' ),
                ('Checking Account')
--------------------------------------
 
Insert into Employee values('Alex','Teller',1,1,'03/08/2019','11/20/2021')    ---- Florida Branch
,('Yitbarek','Manager',1,1,'02/20/2018',getdate())
,('Hilina','Clerk',1,1,'04/11/2019',getdate())

Insert INTO Employee (Employee_NAME, DESIGNATION, branch_id) Values 
('Dan', 'MANAGER', 2),                ----------------------------------------------Maryland Branch
('Helen', 'TELLER', 2),
('Jone', 'CLERK', 2)
insert into employee ([Employee_NAME], DESIGNATION, branch_id) values --from yitbark
('Alex', 'Manager', 3),               -------------------------------------------------NewJersy Branch
('Yitbark', 'Teller', 3),
('Bruk', 'clerk', 3),
('Shandra','Manager', 4),                        ---------------------------------------Washington Branch
('Llywellyn','clerk',4),
('Barbra', 'teller', 4)
Insert into Employee  Values('Josh','Teller',5,1, '05/10/2021','05/11/2022'); -------------New York Branch
Insert into Employee  Values('Kevin','Manager',5,1, '06/07/2021','06/09/2022');
Insert into Employee  Values ('Andre','Clerk',5,1,'09/05/2019',getdate());

Insert into Employee  Values('Tenbit','Teller',6,1, '05/10/2021','05/11/2022');-------------California Branch(Mihret)
Insert into Employee  Values('Dawit','Manager',6,1, '06/07/2021','06/09/2022');
Insert into Employee  Values ('Mulu','Clerk',6,1,'09/05/2019',getdate());

Insert into Employee  Values('Meti','Teller',7,1, '07/11/2021','07/11/2022');   -------------Dallas Branch(Mihret)
Insert into Employee  Values('James','Manager',7,1, '04/05/2021','04/09/2022');
Insert into Employee  Values ('Nati','Clerk',7,1,'02/04/2019',getdate());

Insert into Employee  Values('Nahi','Teller',8,1, '01/11/2021','01/11/2022');   ------------Texas Branch(Mihret)
Insert into Employee  Values('Yoni','Manager',8,1, '03/09/2021','04/09/2022');
Insert into Employee  Values ('Yohi','Clerk',8,1,'03/05/2019',getdate());
-----------------------------------------------------------

 --1st Branch, 5 customers 
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID)VALUES 
							('Tome','2711 Market Ln',1),
                           ('Azeb','4869 Salley Ln',1),
						   ('Muluwork','534 Norhstar Ave',1),
						   ('Yitbark','6273 Jonathon Dr',1),
						   ('Yona','6251 Woodline Dr',1)
--2nd Branch, 5 customers  
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID) VALUES 
						   ('Yonas','6451 Wood Dr',2),
						   ('Yohi','5201 Alexandria pl',2),
						   ('Alem','201 line Dr',2),
						   ('Kidist','5162 Radfor Dr',2),
						   ('Tinbit','1422 Oldtown pl',2)  
--3rd Branch, 5 customers  
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID)VALUES('Christen','87085 Heffernan Road',3),
                          ('Ashley','10460 Orin Terrace',3),
						  ('Jordain','62255 Ramsey Terrace',3),
						  ('Loralyn','87085 Heffernan Road',3),
						  ('Elvyn','323 Glendale Avenue',3)

--4th Branch, 5 customers 
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID)VALUES('Niko','5 Lillian Point',4),
                     ('Betsy','42 Corben Trail',4),
					 ('Mel','870810 Graedel Drive',4),
					 ('Xylina','1 Golf Center',4),
					 ('Jim','4764 Scoville Hill',4)

--5th Branch, 5 customers 
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID)VALUES ('Meheret','1117 7th Ave',5),
                      ('Lina','4401 Rossi St',5),
					  ('Stephani','14703 Aspen hillRoad',5),
					  ('Gary','13910 Long	Meade',5),
					  ('Yared','2132 Georgia Avenue',5)

--6th Branch 5 customers
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID)VALUES ('Jackson','2224 Bitch Drive',6),
                      ('Sam','5672 Aspen wood Drive',6),
					  ('John','2892 Wheaton road',6),
					  ('Glen','7634 Newhampshier Avenue',6),
					  ('Alexa','1444 Bluvard court',6)


--7th Branch 5 customers
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID)VALUES('Alen','1454 Bluvard court',7),
                     ('Abraham','3278 DareWood Drive',7),
					 ('Ephrem','1429 GlenAllen Avenue',7),
					 ('Sami','1329 GnAllen Avenue',7),
					 ('who','429 Alexanri Avenue',7)


--8th Branch 5 customers
INSERT INTO Customer (Customer_Name,ADDRESS,Branch_ID)VALUES('Alemu','2454 Bluvard court',8),
                      ('Hawi','2524 Arlington court',8),
					  ('Sole','1425 Arlington Blvd',8),
					  ('mercy','9393 washington court',8),
					  ('marthi','1234 old court',8)

-----------------------------------------------------
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES  (1,1,40000,110000,'Operative')
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES (1,2,5000,80000,'Operative')
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES(2,1,10000,700000,'Operative')
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES(2,4,10000,50000,'Operative')
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES(3,3,40000,900000,'Operative')
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES(3,2,40000,900000,'Operative')
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES(4,1,50000,600000,'Operative')
INSERT INTO Account(Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) VALUES(4,3,50000,9200000,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(5,1,30450,45970,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(5,2,33020,42927,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(6,1,11567,26000,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(7,2,9789,12504,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(8,1,21090,23675,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(9,2,5467,9789,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(10,1,12435,16789,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(10,2,9807,9908,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(11,1,67853,87209,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(12,2,67876,70768,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(13,1,55463,57689,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(13,2,35678,42100,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(14,1,23678,52100,'Operative')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(14,2,23878,52100,'INOPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(15,1,13878,122100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(16,1,2678,52100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(16,2,38678,42100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(17,1,38678,52100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(17,3,2678,42100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(17,4,2378,52100,'INOPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(18,1,4878,12100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(18,4,23678,52100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(19,2,5678,62100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(20,1,7678,42100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(20,3,4378,72100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(21,1,2378,52100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(22,2,24878,42100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(23,2,1678,52100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(24,1,38678,52100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(25,1,78678,352100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(25,3,78678,352100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(26,2,18678,52100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(27,1,2878,92100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(27,3,6748,12100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(28,2,1878,12100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(29,1,2278,92100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(30,2,6378,92100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(31,1,28678,32100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(31,4,28678,42100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(32,1,28678,32100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(32,2,28678,32100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(33,2,8678,102100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(34,1,28678,32100,'CLOSED')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(34,3,58678,332100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(35,1,48678,432100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(35,4,18678,32100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(36,2,78678,132100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(37,1,6278,42100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(37,3,1678,2100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(38,2,15678,72100,'OPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(39,1,1678,2100,'INOPERATIVE')
Insert into Account (Customer_ID,AccountType_ID,CLEAR_BALANCE, UNCLEAR_BALANCE,status) values(40,2,1678,2100,'INOPERATIVE')

--------------------------------------

--5 TRANSACTION FOR THE 1ST BRANCH 
insert into TransactionDetail (Transaction_date,Customer_ID,Branch_ID,Transaction_Type,check_number,  -- from yitbark
Check_Date,Transaction_amount,Employee_ID) values 
('01/23/2022',1,1, 'CQD', 13890454, '01/23/2022',1200,1),
('03/29/2022',2,1, 'CQD', 8932233, '03/20/2022',12200,2),
('03/23/2022',3,1,'CQD',1234568,	'01/12/2022', 4500,3),			
('10/23/2021',4,1,'CQD',3490832,'10/13/2021',5500,2),
('11/09/2021',5,1,'CQD', 45476876, '10/02/2021', 23000, 3),
('10/15/2021',13,3,'CQD', 1234, '09/21/2021',500,8)

--5 TRANSACTION FOR THE 2ND BRANCH 
insert into TransactionDetail (Transaction_date,Customer_ID,Branch_ID,  ----- from yitbark
Transaction_Type,Transaction_amount,Employee_ID) values 
('05/3/2022', 6,2, 'CW',18000,4),
('04/30/2022',7,2, 'CD', 30000, 4),
('01/23/2022',8,2 ,'CD', 30000, 5),
('12/27/2021',9,2, 'CD', 30000, 6),
('11/20/2021',10,2, 'CW', 30000, 6)

--5 TRANSACTION FOR THE 3RD BRANCH

Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
('05/01/22',11,3,'CD',8000,7),
('04/20/21',12,3,'CW',450,7),
('02/20/20',14,3,'CD',1400,8),
('09/10/17',15,3,'CW',1234,9)

--5 TRANSACTION FOR THE 4TH BRANCH
Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,check_number,Check_Date,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
('02/25/2022',16,4,900,'02/20/2022','CQD',5676,10),
('11/10/21',17,4,212,'10/10/2021','CQD',900,10)
Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
('12/20/21',18,4,'CW',367,11),
('12/10/21',19,4,'CW',900,12),
('08/23/19',20,4,'CD',2020,12)

--5 TRANSACTION FOR THE 5TH BRANCH
Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,check_number,Check_Date,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
('12/06/21',21,5,900,'11/20/2021','CQD',5676,13),
('10/10/21',22,5,212,'10/10/2021','CQD',900,13)
Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
('11/20/21',23,5,'CW',367,14),
('04/10/21',24,5,'CW',900,14),
('08/23/19',25,5,'CD',2020,15)

--5 TRANSACTION FOR THE 6TH BRANCH
Insert into  [TransactionDetail] (Transaction_date,Customer_ID,Branch_ID,check_number,Check_Date,Transaction_TYPE,  --from azeb
Transaction_Amount,Employee_ID) Values
			('02/03/2022',26,6,1001,'01/02/2022','CQD',1000,16),
			('04/02/2022',28,6,1003,'02/20/2022','CQD',500,16)
Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
			('02/20/2022',29,6,'CD',1400,17),
			('12/02/2021',30,6,'CW',2000,18),
			('07/02/2019',27,6,'CW',200,16)

--5 TRANSACTION FOR THE 7TH BRANCH

Insert into  [TransactionDetail] (Transaction_date,Customer_ID,Branch_ID,check_number,Check_Date,Transaction_TYPE,  --from azeb
				Transaction_Amount,Employee_ID) Values
			('05/09/2022',31,7,1006,'05/1/2022','CQD',5000,19),
			('04/10/2022',32,7,1007,'1/1/2022','CQD',9000,19)
Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
			('12/20/2021',33,7,'CW',3000,20),
			('12/10/2019',34,7,'CW',9000,20),
			('08/23/2019',35,7,'CD',7000,21)

--5 TRANSACTION FOR THE 8TH BRANCH
Insert into  [TransactionDetail] (TRANSACTION_Date,Customer_ID,Branch_ID,check_number,Check_Date,Transaction_TYPE,  --from azeb
Transaction_Amount,Employee_ID) Values
			('05/07/2022',36,8,1006,'05/1/2022','CQD',5000,22),
			('03/10/2022',37,8,1007,'1/1/2022','CQD',9000,23)
Insert into  [Transactiondetail] (Transaction_date,Customer_ID,Branch_ID,Transaction_TYPE,  --- from bruk
Transaction_Amount,Employee_ID) 	Values
			('11/20/2021',38,8,'CW',3000,24),
			('12/10/2019',39,8,'CW',9000,22),
			('08/23/2019',40,8,'CD',7000,23)

select * from Account_type
select * from Customer
select * from [Employee]
select * from region
select * from Branch
select * from [transactiondetail]
select* from Account