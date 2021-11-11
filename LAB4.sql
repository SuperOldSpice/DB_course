use IS01_20_TS

/*TASK1*/
SELECT DT, Sum(PaymentOrders.Sum) AS Total FROM PaymentOrders
GROUP BY DT

/*TASK2*/
SELECT Reason as reason, Sum(PaymentOrders.Sum) AS Total FROM PaymentOrders
GROUP BY Reason
HAVING Sum(PaymentOrders.Sum) > 400000;

/*TASK3*/
SElECT * INTO CheapOrders
FROM PaymentOrders
WHERE Sum < 400000

/*TASK4*/
UPDATE CheapOrders
SET Sum = Sum - Sum * 0.05

/*TASK5*/
DELETE FROM	CheapOrders
WHERE DT < '2021-08-01'

/*TASK6*/
INSERT INTO CheapOrders
SELECT Number, Reason, Recepient, Sum, 
DT, CoECsID FROM PaymentOrders
WHERE Sum < 400000