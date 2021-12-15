/*Lab06*/
/*TASK3 ('CREATE TRIGGER' must be the first statement in a query batch)*/
CREATE TRIGGER IncorrectNumber 
ON Estimates 
AFTER INSERT 
AS
IF EXISTS
	(SELECT BudgetInstitution.ID
	FROM BudgetInstitution INNER JOIN INSERTED
	ON BudgetInstitution.ID = INSERTED.BudgetInstitutionID
	)	
AND EXISTS
	(SELECT INSERTED.Number 
	FROM INSERTED 
	WHERE INSERTED.Number > 999 OR INSERTED.Number < 100)
BEGIN 
	DELETE FROM Estimates WHERE ID IN 
		(SELECT INSERTED.ID
		FROM INSERTED
		WHERE INSERTED.Number > 999 OR INSERTED.Number < 100
		)	
END;

INSERT INTO Estimates(Number, DT, BudgetInstitutionID) VALUES
(8018, '2021-07-26', 2),
(12, '2021-07-26', 2);
INSERT INTO Estimates(Number, DT, BudgetInstitutionID) VALUES
(8018, '2021-07-26', 2);

/*TASK4 ('CREATE TRIGGER' must be the first statement in a query batch)*/
CREATE TRIGGER СoECDoestExists
ON CheapOrders
AFTER INSERT 
AS
IF NOT EXISTS
	(SELECT CoECs.ID
	FROM CoECs INNER JOIN INSERTED
	ON CoECs.ID = INSERTED.CoECsID
	)	

BEGIN 
	DELETE FROM CheapOrders WHERE ID IN 
		(SELECT INSERTED.ID
		FROM INSERTED
		WHERE INSERTED.CoECsID NOT IN
			(SELECT CoECs.ID 
			FROM CoECs)
		)	
END;

INSERT INTO CheapOrders(Number, Reason, Recepient, Sum, DT, CoECsID) VALUES
(2311, 'Перекриття даху', 'НМК', 90000, '2021-11-22', 56),
(2321, 'Перекриття даху', 'НМК', 90000, '2021-11-22', 56);


/*TASK1*/
use IS01_20_TS;

UPDATE CoECCatalog SET CoECCode = 2154 WHERE CoECCode = 4312;

/*TASK2*/

ALTER TABLE PaymentOrders ADD CONSTRAINT SumLessThenMin
CHECK (Sum >= 20000);
UPDATE PaymentOrders 
SET Sum = 5800 
WHERE ID = 1;

