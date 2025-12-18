-- Create a new database 'banksdata' based on the database design
drop database if exists banksdata;
create database if not exists banksdata;
use banksdata;

-- Create tables inside the database
-- Create Bank table 
CREATE TABLE Bank (
  Bank_ID INT NOT NULL,
  Bank_name VARCHAR(100),
  Bank_address VARCHAR(100),
  Bank_tel VARCHAR(30),
  No_of_staff INT,
  PRIMARY KEY (Bank_ID)
  );

-- Insert data into bank table 
INSERT INTO Bank (Bank_ID, Bank_name, Bank_address, Bank_tel, No_of_staff) VALUES
(001,'Dublin Office','Dublin','0011223344',5),
(002,'Cork Office','Cork','0011224455',5),
(003,'Galway Office','Galway','0011225566',5),
(004,'Limerick Office','Limerick','0011226677',5),
(005,'Waterford Office','Waterford','0011227788',5);
  
  -- Create Staff table
  CREATE TABLE Staff (
  Emp_ID INT NOT NULL,
  Bank_ID INT NOT NULL,
  Staff_name VARCHAR(100),
  Staff_tel INT,
  Staff_email VARCHAR(100),
  Gender VARCHAR(1), -- Either F/M. F for female and M for male
  Year_of_exp INT,
  DOB DATE, -- date of birth 
  PRIMARY KEY (Emp_ID),
  CONSTRAINT fk_staff_bank
    FOREIGN KEY (Bank_ID) REFERENCES Bank(Bank_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert data into Staff table:
INSERT INTO Staff (Emp_ID, Bank_ID, Staff_name, Staff_tel, Staff_email, Gender, Year_of_exp, DOB) VALUES
-- Bank 1
(101,1,'John Smith','111','john@bank.ie','M',15,'1980-01-01'),
(102,1,'Alice Johnson','112','alice@bank.ie','F',5,'1992-02-02'),
(103,1,'Bob Williams','113','bob@bank.ie','M',6,'1991-03-03'),
(104,1,'Carol Brown','114','carol@bank.ie','F',4,'1994-04-04'),
(105,1,'David Jones','115','david@bank.ie','M',3,'1995-05-05'),

-- Bank 2
(201,2,'Emma Garcia','211','emma@bank.ie','F',16,'1979-01-01'),
(202,2,'Frank Miller','212','frank@bank.ie','M',7,'1990-02-02'),
(203,2,'Grace Davis','213','grace@bank.ie','F',6,'1991-03-03'),
(204,2,'Henry Rodriguez','214','henry@bank.ie','M',4,'1994-04-04'),
(205,2,'Ivy Martinez','215','ivy@bank.ie','F',3,'1995-05-05'),

-- Bank 3
(301,3,'Jack Hernadez','311','jack@bank.ie','M',14,'1981-01-01'),
(302,3,'Kate Lopez','312','kate@bank.ie','F',5,'1992-02-02'),
(303,3,'Leo Wilson','313','leo@bank.ie','M',6,'1991-03-03'),
(304,3,'Mia Anderson','314','mia@bank.ie','F',4,'1994-04-04'),
(305,3,'Noah Taylor','315','noah@bank.ie','M',3,'1995-05-05'),

-- Bank 4
(401,4,'Olivia Anderson','411','olivia@bank.ie','F',15,'1980-01-01'),
(402,4,'Paul Thomas','412','paul@bank.ie','M',6,'1991-02-02'),
(403,4,'Queen Moore','413','queen@bank.ie','F',5,'1992-03-03'),
(404,4,'Ryan Jackson','414','ryan@bank.ie','M',4,'1994-04-04'),
(405,4,'Sara Martin','415','sara@bank.ie','F',3,'1995-05-05'),

-- Bank 5
(501,5,'Tom Thompson','511','tom@bank.ie','M',17,'1978-01-01'),
(502,5,'Uma Lee','512','uma@bank.ie','F',6,'1991-02-02'),
(503,5,'Victor Harris','513','victor@bank.ie','M',7,'1990-03-03'),
(504,5,'Wendy Clark','514','wendy@bank.ie','F',4,'1994-04-04'),
(505,5,'Xavier Lewis','515','xavier@bank.ie','M',3,'1995-05-05');


-- Create subclass of Staff:
CREATE TABLE Manager (
  Emp_ID INT NOT NULL,
  Manager_level VARCHAR(50),
  Credit_allocation_limit INT,
  Performance_score INT,
  PRIMARY KEY (Emp_ID),
  CONSTRAINT fk_manager_staff
    FOREIGN KEY (Emp_ID) REFERENCES Staff(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert data into Manager table:
INSERT INTO Manager (Emp_ID, Manager_level, Credit_allocation_limit, Performance_score) VALUES
(101,'Senior',500000,90),
(201,'Senior',500000,88),
(301,'Senior',450000,87),
(401,'Senior',480000,89),
(501,'Senior',520000,92);


CREATE TABLE Credit_analyst (
  Emp_ID INT NOT NULL,
  Supervised_by INT NULL, -- Add a column to show who supervises analyst
  Analyst_level VARCHAR(50), -- Junior / Senior 
  Loan_recommend_rate INT,
  PRIMARY KEY (Emp_ID),
  
  -- analyst is a staff 
  CONSTRAINT fk_analyst_staff
    FOREIGN KEY (Emp_ID) REFERENCES Staff(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION, 

-- analyst is supervised by a manager 
  CONSTRAINT fk_analyst_manager 
    FOREIGN KEY (Supervised_by) REFERENCES Manager(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert data into Credit analyst table:
INSERT INTO Credit_analyst (Emp_ID, Supervised_by, Analyst_level, Loan_recommend_rate) VALUES
(102,101,'Junior',70),
(103,101,'Senior',85),
(202,201,'Junior',72),
(203,201,'Senior',83),
(302,301,'Junior',68),
(303,301,'Senior',80),
(402,401,'Junior',69),
(403,401,'Senior',82),
(502,501,'Junior',71),
(503,501,'Senior',84);


CREATE TABLE Broker (
  Emp_ID INT NOT NULL,
  Supervised_by INT NULL, -- Add a column to show who supervises broker
  Investment_license VARCHAR(100),
  Commission_rate INT,
  PRIMARY KEY (Emp_ID),
  
   -- broker is a staff 
  CONSTRAINT fk_broker_staff
    FOREIGN KEY (Emp_ID) REFERENCES Staff(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION, 

-- broker is supervised by a manager 
  CONSTRAINT fk_broker_manager 
    FOREIGN KEY (Supervised_by) REFERENCES Manager(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert data into Broker table:
INSERT INTO Broker (Emp_ID, Supervised_by, Investment_license, Commission_rate) VALUES
(104,101,'LIC-001',5),
(105,101,'LIC-002',2),
(204,201,'LIC-003',5),
(205,201,'LIC-004',2),
(304,301,'LIC-005',5),
(305,301,'LIC-006',2),
(404,401,'LIC-007',5),
(405,401,'LIC-008',2),
(504,501,'LIC-009',5),
(505,501,'LIC-010',2);


CREATE TABLE AML_department (
  Monitor_ID INT NOT NULL,
  Bank_ID INT,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Phone INT,
  County VARCHAR(100),
  PRIMARY KEY (Monitor_ID),
  CONSTRAINT fk_aml_bank
    FOREIGN KEY (Bank_ID) REFERENCES Bank(Bank_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert data into AML department table 
INSERT INTO AML_department (Monitor_ID, Bank_ID, Name, Email, Phone, County) VALUES
(7575,1,'Dublin AML department','dublin.aml@bank.ie','1122', 'Dublin'),
(8989,2,'Cork AML department','cork.aml@bank.ie','1155', 'Cork'),
(8333,3,'Galway AML department','galway.aml@bank.ie','1133', 'Galway'),
(1586,4,'Limerick AML department','limerick.aml@bank.ie','1144', 'Limerick'),
(2005,5,'Waterford AML department','waterford.aml@bank.ie','1188', 'Waterford');


CREATE TABLE Customer (
  Customer_ID INT NOT NULL,
  Name VARCHAR(100),
  Phone INT,
  Email VARCHAR(100),
  Gender VARCHAR(1),
  DOB DATE,
  Address VARCHAR(100),
  PRIMARY KEY (Customer_ID)
);

-- Insert data into Customer table
INSERT INTO Customer (Customer_ID, Name, Phone, Email, Gender, DOB, Address) VALUES
(9001, 'Anne Jones', '0871110001', 'anne.jones@gmail.com', 'F', '1990-05-12', 'Dublin'),
(9002, 'Brian Murphy', '0871110002', 'brian.murphy@gmail.com', 'M', '1985-09-20', 'Cork'),
(9003, 'Clara O’Neill', '0871110003', 'clara.oneill@gmail.com', 'F', '1992-03-15', 'Galway'),
(9004, 'David Walsh', '0871110004', 'david.walsh@gmail.com', 'M', '1988-07-10', 'Limerick'),
(9005, 'Emma Byrne', '0871110005', 'emma.byrne@gmail.com', 'F', '1995-01-25', 'Waterford'),
(9006, 'Frank Doyle', '0871110006', 'frank.doyle@gmail.com', 'M', '1983-11-02', 'Dublin'),
(9007, 'Grace Kelly', '0871110007', 'grace.kelly@gmail.com', 'F', '1991-06-18', 'Cork'),
(9008, 'Henry Nolan', '0871110008', 'henry.nolan@gmail.com', 'M', '1987-04-30', 'Galway'),
(9009, 'Isla Brennan', '0871110009', 'isla.brennan@gmail.com', 'F', '1994-02-14', 'Limerick'),
(9010, 'Jack Collins', '0871110010', 'jack.collins@gmail.com', 'M', '1982-08-08', 'Waterford');

-- Customer subclasses
CREATE TABLE C_sociodemographic (
  Customer_ID INT NOT NULL,
  Education_level VARCHAR(100),
  Occupation VARCHAR(100),
  Marriage_status VARCHAR(100),
  PRIMARY KEY (Customer_ID),
  CONSTRAINT fk_soc_customer
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert value into customer sociodemographic table
INSERT INTO C_sociodemographic (Customer_ID, Education_level, Occupation, Marriage_status) VALUES
(9001, 'Bachelor', 'Accountant', 'Single'),
(9002, 'Master', 'Software Engineer', 'Married'),
(9003, 'Bachelor', 'Marketing Executive', 'Single'),
(9004, 'Bachelor', 'Civil Engineer', 'Married'),
(9005, 'Master', 'Financial Analyst', 'Single'),
(9006, 'PhD', 'University Lecturer', 'Married'),
(9007, 'Bachelor', 'HR Specialist', 'Single'),
(9008, 'Master', 'Operations Manager', 'Married'),
(9009, 'Bachelor', 'Graphic Designer', 'Single'),
(9010, 'Diploma', 'Sales Consultant', 'Married');

CREATE TABLE C_finance (
  Customer_ID INT NOT NULL,
  Yearly_income INT,
  Total_asset INT,
  Total_debt INT,
  PRIMARY KEY (Customer_ID),
  CONSTRAINT fk_fin_customer
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert data into customer finance table
INSERT INTO C_finance (Customer_ID, Yearly_income, Total_asset, Total_debt) VALUES
(9001, 55000, 120000, 15000),
(9002, 85000, 200000, 40000),
(9003, 48000,  90000, 10000),
(9004, 72000, 160000, 35000),
(9005, 60000, 110000, 20000),
(9006, 95000, 250000, 50000),
(9007, 52000, 100000, 12000),
(9008, 88000, 220000, 45000),
(9009, 47000,  85000,  8000),
(9010, 65000, 130000, 25000);


CREATE TABLE Bank_account (
  Account_No INT NOT NULL,
  Customer_ID INT NOT NULL,
  Emp_ID INT NOT NULL,     -- analyst in charge
  Monitor_ID INT NOT NULL,     -- AML department monitoring
  Available_balance INT,
  Deposit_rate INT,
  AML_score INT,
  PRIMARY KEY (Account_no),
  CONSTRAINT fk_bankacc_customer
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  CONSTRAINT fk_bankacc_analyst
    FOREIGN KEY (Emp_ID) REFERENCES Credit_analyst(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  CONSTRAINT fk_bankacc_aml
    FOREIGN KEY (Monitor_ID) REFERENCES AML_department(Monitor_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Insert data into Bank account table
INSERT INTO Bank_account
(Account_No, Customer_ID, Emp_ID, Monitor_ID, Available_balance, Deposit_rate, AML_score) VALUES
(50001, 9001, 102, 7575, 12000, 3.5, 15),
(50002, 9006, 103, 7575,  8500, 3.5, 20),
(50003, 9002, 202, 8989, 15000, 3.5, 10),
(50004, 9007, 203, 8989,  9200, 3.5, 18),
(50005, 9003, 302, 8333,  7000, 3, 25),
(50006, 9008, 303, 8333, 11000, 3, 12),
(50007, 9004, 402, 1586, 13000, 2, 14),
(50008, 9009, 403, 1586,  6800, 2, 30),
(50009, 9005, 502, 2005,  9000, 2, 22),
(50010, 9010, 503, 2005, 14000, 3.5, 16);


CREATE TABLE Securities_depository (
  Depository_ID INT,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Phone INT,
  County VARCHAR(100),
  PRIMARY KEY (Depository_ID)
);

INSERT INTO Securities_depository
(Depository_ID, Name, Email, Phone, County) VALUES
(3001, 'Central Securities Depository', 'info-dublin@csd.com','353100001', 'Dublin'),
(3002, 'Euroclear Bank', 'info-corkoffice@euroclearbank.com', '353200002', 'Cork'),
(3003, 'Central Securities Depository', 'info-cork@csd.com', '353300003', 'Cork'),
(3004, 'Central Securities Depository ', 'info-limerick@csd.com', '353400004', 'Limerick'),
(3005, 'Euroclear Bank', 'info-dublinoffice@euroclearbank.com','35320005', 'Dublin');


CREATE TABLE Investment_account (
  Inv_account_no INT,
  Customer_ID INT NOT NULL,
  Depository_ID INT NOT NULL,
  Emp_ID INT NOT NULL,       -- broker in charge
  NAV INT,
  Risk_tolerance VARCHAR(50),
  PRIMARY KEY (Inv_account_no),
  CONSTRAINT fk_inv_customer
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  CONSTRAINT fk_inv_depository
    FOREIGN KEY (Depository_ID) REFERENCES Securities_depository(Depository_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  CONSTRAINT fk_inv_broker
    FOREIGN KEY (Emp_ID) REFERENCES Broker(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

INSERT INTO Investment_account
(Inv_account_no, Customer_ID, Depository_ID, Emp_ID, NAV, Risk_tolerance) VALUES
(70001, 9001, 3001, 104, 25000, 'Medium'),
(70002, 9006, 3001, 105, 40000, 'High'),
(70003, 9002, 3002, 204, 30000, 'Medium'),
(70004, 9007, 3002, 205, 18000, 'Low'),
(70005, 9003, 3003, 304, 22000, 'Medium'),
(70006, 9008, 3003, 305, 35000, 'High'),
(70007, 9004, 3004, 404, 28000, 'Low'),
(70008, 9009, 3004, 405, 15000, 'Medium'),
(70009, 9005, 3005, 504, 32000, 'High'),
(70010, 9010, 3005, 505, 20000, 'Low');


CREATE TABLE Loan_Form (
  Loan_ID INT NOT NULL,
  Customer_ID INT NOT NULL,
  Submit_date DATE,
  Amount INT,
  Term_month INT,
  Loan_purpose VARCHAR(100),
  PRIMARY KEY (Loan_ID),
  CONSTRAINT fk_loan_customer
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

INSERT INTO Loan_Form
(Loan_ID, Customer_ID, Submit_date, Amount, Term_month, Loan_purpose) VALUES
(80001, 9001, '2025-01-10', 15000, 36, 'Car purchase'),
(80002, 9002, '2025-01-12', 25000, 48, 'Home renovation'),
(80003, 9003, '2025-01-15', 10000, 24, 'Education'),
(80004, 9004, '2025-01-18', 30000, 60, 'Mortgage'),
(80005, 9005, '2025-01-20', 12000, 36, 'Business capital'),
(80006, 9006, '2025-01-22', 20000, 48, 'Car purchase'),
(80007, 9007, '2025-01-25', 18000, 36, 'Medical expenses'),
(80008, 9008, '2025-01-27', 22000, 48, 'Home renovation'),
(80009, 9009, '2025-01-29',  9000, 24, 'Education'),
(80010, 9010, '2025-02-01', 16000, 36, 'Car purchase');


CREATE TABLE Credit_decision (
  Approval_ID INT NOT NULL,
  Emp_ID INT NOT NULL, 
  Loan_ID INT NOT NULL,   
  Status VARCHAR(100),
  Disbursement_date DATE,
  PRIMARY KEY (Approval_ID),
  CONSTRAINT fk_credit_manager
    FOREIGN KEY (Emp_ID) REFERENCES Manager(Emp_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  CONSTRAINT fk_credit_loan
    FOREIGN KEY (Loan_ID) REFERENCES Loan_Form(Loan_ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

INSERT INTO Credit_decision
(Approval_ID, Emp_ID, Loan_ID, Status, Disbursement_date) VALUES
(90001, 101, 80001, 'Approved', '2025-02-20'),
(90002, 101, 80006, 'Rejected', NULL),
(90003, 201, 80002, 'Approved', '2025-02-25'),
(90004, 201, 80007, 'Approved', '2025-02-02'),
(90005, 301, 80003, 'Rejected', NULL),
(90006, 301, 80008, 'Approved', '2025-02-25'),
(90007, 401, 80004, 'Approved', '2025-02-10'),
(90008, 401, 80009, 'Rejected', NULL),
(90009, 501, 80005, 'Approved', '2025-02-20'),
(90010, 501, 80010, 'Approved', '2025-03-01');

