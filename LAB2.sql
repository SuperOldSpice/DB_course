USE IS01_20_TS

CREATE TABLE BudgetInstitution(
ID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Name NVARCHAR(MAX) NOT NULL,	
Region NVARCHAR(MAX),
Code INT NOT NULL
)

CREATE TABLE Estimates(
ID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Number BIGINT NOT NULL,
DT date,
BudgetInstitutionID INT NOT NULL
)

CREATE TABLE CoECCatalog(
ID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
CoECCode INT NOT NULL,
CoECName NVARCHAR(MAX) NOT NULL,
)

CREATE TABLE CoECs(
ID INT PRIMARY KEY NOT  NULL IDENTITY(1,1),
Remainder INT NOT NULL,
SpendingLimit INT NOT NULL,
EstimateID INT NOT NULL,
CoECCatalogID INT NOT NULL,
)

CREATE TABLE PaymentOrders(
ID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Number BIGINT NOT NULL,
Reason  NVARCHAR(MAX) NOT NULL,
Recepient NVARCHAR(MAX) NOT NULL,
Sum MONEY NOT NULL,
DT DATE NOT NULL,
CoECsID INT NOT NULL,
)



ALTER TABLE PaymentOrders
ADD CONSTRAINT FK_PaymentOrders_CoECs FOREIGN KEY (CoECsID)
REFERENCES CoECs(ID)
ON UPDATE CASCADE 

ALTER TABLE CoECs
ADD CONSTRAINT FK_CoECs_Estimate FOREIGN KEY (EstimateID)
REFERENCES Estimates(ID)
ON UPDATE CASCADE

ALTER TABLE CoECs
ADD CONSTRAINT FK_CoECs_CoECCatalog FOREIGN KEY (CoECCatalogID)
REFERENCES CoECCatalog(ID)
ON UPDATE CASCADE

ALTER TABLE Estimates
ADD CONSTRAINT FK_Estimates_BudgetInstitutions FOREIGN KEY (BudgetInstitutionID)
REFERENCES BudgetInstitution(ID)
ON UPDATE CASCADE



INSERT INTO BudgetInstitution(Name, Region, Code) VALUES
('����� �����', '������� ���.', '342534'),
('������������ ����� ������ ��������', '������� ���.', '345267'),
('��������� ����� ����������', '������� ���.', '563567'),
('������� ������ �8', '������� ���.', '874534'),
('���������� ����������� ����������', '�������� ���.', '345786'),
('˳��� �46', '������� ���.', '321579'),
('��������� ����� "�����"', '�������� ���', '765345');

INSERT INTO Estimates(Number, DT, BudgetInstitutionID) VALUES
('123', '2021-08-12', 1),
('432', '2021-09-23', 2),
('234', '2021-06-8', 3),
('342', '2021-02-1', 4),
('658', '2021-12-26', 5),
('124', '2021-11-17', 6),
('764', '2021-06-5', 7);

INSERT INTO CoECCatalog(CoECCode, CoECName) VALUES
(0423, '���������� ������'),
(2154, '������ ���������������'),
(4312, '������� �� ����������'),
(4315, '������� �� ����������'),
(2375, '������� �� ����������'),
(3212, '��������� �������'),
(8457, '��������� ������');

INSERT INTO CoECs(Remainder, SpendingLimit, EstimateID, CoECCatalogID) VALUES
(1000000, 1000000, 7, 1),
(1200000, 1200000, 6, 3),
(780000, 780000, 3, 2),
(2500000, 2500000, 4, 4),
(2300000, 2300000, 5, 5),
(3000000, 3000000,  1,  6),
(1500000, 1500000, 2, 7);

INSERT INTO PaymentOrders(Number, Reason, Recepient, Sum, DT, CoECsID) VALUES
(1111, '�������� ���������', '����', 700000, '2021-07-21', 2),
(1123, '������������ ����', '���', 450000, '2021-02-23', 1),
(1243, '�������� �`����', '����', 40000, '2021-05-12', 3),
(1423, 'ϳ�������� ����������� �����������', '���', 450000, '2021-01-23', 4),
(1246, '������� ��������', '���', 360000, '2021-09-16', 5),
(4313, '�������� �����', '���', 200000, '2021-05-23', 6),
(3212, '���������� ��������', '���', 80000, '2021-08-27', 7);