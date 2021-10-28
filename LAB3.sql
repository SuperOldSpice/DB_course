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

