use IS01_20_TS

/*TASK1*/
SELECT DT, Sum(PaymentOrders.Sum) AS Total FROM PaymentOrders
GROUP BY DT

/*TASK2*/
SELECT Reason as reason, Sum(PaymentOrders.Sum) AS Total FROM PaymentOrders
GROUP BY Reason
HAVING Sum(PaymentOrders.CoECsID) >= 3;

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

/*ADDING ROWS TO PAYMENTORDERS*/

INSERT INTO PaymentOrders(Number, Reason, Recepient, Sum, DT, CoECsID) VALUES
(1321, 'Встановлення рядів', 'ВПН', 300000, '2021-05-12', 1),
(5213, 'Опалення музею', 'ЖЕК', 250000, '2021-08-27', 6),
(2164, 'Прибирання територій', 'РКВ', 40000, '2021-05-23', 7),
(4212, 'Підвищення кваліфікації співробітників', 'МПК', 300000, '2021-02-23', 4);
