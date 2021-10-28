use IS01_20_TS

/*TASK1*/

SELECT TOP (100) PERCENT ID, NAME, Region, Code
FROM dbo.BudgetInstitution
ORDER BY ID 

SELECT TOP (100) PERCENT ID, CoECNAME, CoECCode
FROM dbo.CoECCatalog
ORDER by ID

SELECT TOP (100) PERCENT ID, Remainder, SpendingLimit, EstimateID, CoECCatalogID
FROM dbo.CoECs
ORDER by ID

SELECT TOP (100) PERCENT ID, Number, DT, BudgetInstitutionID
FROM dbo.Estimates
ORDER by ID

SELECT TOP (100) PERCENT ID, Number, Reason, Recepient, Sum, DT, CoECsID
FROM dbo.PaymentOrders
ORDER by ID

/*TASK2*/

SELECT ID, Remainder, SpendingLimit, EstimateID, CoECCatalogID
FROM dbo.CoECs
WHERE SpendingLimit > 1400000
ORDER by ID

SELECT CoECsID, ID, Number, Reason, Recepient, Sum, DT
FROM dbo.PaymentOrders
WHERE CoECsID < 5
ORDER by CoECsID

/*TASK3*/

SELECT * FROM Estimates
WHERE ID IN(SELECT EstimateID FROM CoECs)
ORDER BY ID 

SELECT * FROM CoECs
WHERE Remainder < (SELECT AVG(Remainder) FROM CoECs)
ORDER BY SpendingLimit

SELECT Name FROM BudgetInstitution
WHERE Exists (SELECT ID FROM Estimates 
WHERE BudgetInstitution.ID = Estimates.BudgetInstitutionID)

/*TASK4*/

SELECT Estimates.Number, Estimates.DT, Estimates.BudgetInstitutionID, 
BudgetInstitution.Name, BudgetInstitution.Region
FROM Estimates INNER JOIN BudgetInstitution		
ON BudgetInstitution.ID = Estimates.BudgetInstitutionID

SELECT CoECs.Remainder, CoECs.CoECCatalogID as CoECCatalogID,
CoECCatalog.CoECName, CoECCatalog.CoECCode
FROM CoECs LEFT JOIN CoECCatalog
ON CoECs.CoECCatalogID = CoECCatalog.ID
ORDER BY Remainder

SELECT PaymentOrders.Number, PaymentOrders.Reason, PaymentOrders.Recepient,
PaymentOrders.Sum, PaymentOrders.CoECsID, CoECs.SpendingLimit
FROM PaymentOrders RIGHT JOIN CoECs
ON PaymentOrders.CoECsID = CoECs.ID

/*TASK5*/

CREATE TABLE CoECCatalog2021(
ID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
CoECCode INT NOT NULL,
CoECName NVARCHAR(MAX) NOT NULL,
)

INSERT INTO CoECCatalog(CoECCode, CoECName) VALUES
(9645, 'Озеленення територій'),
(2574, 'Реставрація архітектури'),
(7445, 'Ремонт доріг');

Select ID, CoECCode, CoECName FROM CoECCatalog
UNION ALL
SELECT  ID, CoECCode, CoECName FROM CoECCatalog2021