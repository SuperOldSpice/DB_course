/*
LAB05
*/

use Diet

/*TABLES CREATION*/

CREATE TABLE Dishes(
ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
Name VARCHAR(MAX) NOT NULL,
)

CREATE TABLE Menu(
ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
Day INT NOT NULL,
DishID INT NOT NULL,
Weight FLOAT NOT NULL,
)

CREATE TABLE ProductsWeights(
ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
DishID INT NOT NULL,
CalorieContentID int NOT NULL,
Weight FLOAT NOT NULL,
)

Create TABLE CalorieContents(
ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
Name VARCHAR(MAX) NOT NULL,
CalorieContent FLOAT NOT NULL,
)

/*REFERENCING*/

ALTER TABLE ProductsWeights
ADD CONSTRAINT FK_ProductsWeights_Dishes FOREIGN KEY (DishID)
REFERENCES Dishes(ID)
ON UPDATE CASCADE 
ON DELETE CASCADE

ALTER TABLE ProductsWeights
ADD CONSTRAINT FK_ProductsWeights_CalorieContents FOREIGN KEY (CalorieContentID)
REFERENCES CalorieContents(ID)
ON UPDATE CASCADE 
ON DELETE CASCADE

ALTER TABLE Menu
ADD CONSTRAINT FK_Menu_Dishes FOREIGN KEY (DishID)
REFERENCES Dishes(ID)
ON UPDATE CASCADE 
ON DELETE CASCADE

/*FILLING*/

INSERT INTO Dishes(Name) VALUES
('Чай'),
('Каша рисова'),
('Творог'),
('Паста'),
('Курячі котлети'),
('Печиво'),
('Сік'),
('Картопляне пюре'),
('Вареники'),
('Суп дієтичний');

INSERT INTO Menu(Day, DishID, Weight) VALUES
(1, 1, 0.2),
(1, 2, 0.4),
(1, 4, 0.3),
(2, 7, 0.25),
(2, 9, 0.3),
(2, 5, 0.15),
(3, 1, 0.25),
(3, 9, 0.4),
(3, 4, 0.3),
(4, 10, 0.3),
(4, 2, 0.3),
(4, 7, 0.4),
(5, 6, 0.2),
(5, 8, 0.5),
(5, 4, 0.3),
(6, 9, 0.4),
(6, 3, 0.25),
(6, 2, 0.3),
(7, 9, 0.3),
(7, 2, 0.4),
(7, 7, 0.35);

INSERT INTO CalorieContents(Name, CalorieContent) VALUES
('Чай', 350),
('Рис', 1300),
('Творог', 1690),
('Паста', 1300),
('Курятина', 2390),
('Мука', 3650),
('Сік', 540);

INSERT INTO CalorieContents(Name, CalorieContent) VALUES
('Картопля', 770);

INSERT INTO ProductsWeights (DishID, CalorieContentID, Weight) VALUES
(1, 1, 1),
(2, 2, 0.6),
(3, 3, 1),
(4, 4, 0.7),
(5, 5, 0.9),
(5, 6, 0.05),
(6, 6, 1),
(7, 7, 1),
(8, 8, 0.8),
(9, 8, 0.3),
(9, 6, 0.6),
(10, 6, 0.1),
(10, 5, 0.1),
(10, 2, 0.2),
(10, 8, 0.3);

/* QUERIES */

/* 1 */

SELECT Name
FROM CalorieContents
WHERE ID IN
	(SELECT CalorieContentID
	FROM ProductsWeights
	WHERE DishID IN
		(SELECT ID
		FROM Dishes
		WHERE ID IN
			(SELECT DishID
			FROM Menu
			WHERE Menu.Day = 2)))
ORDER BY Name;

/* 2 */

DECLARE @Name NVARCHAR(MAX)
SET @Name = 'Картопля';

SELECT Sum(Menu.Weight * ProductsWeights.Weight) as Weight_in_kg
FROM Menu INNER JOIN Dishes
ON (Menu.DishID = Dishes.ID)
JOIN ProductsWeights
ON(Dishes.ID = ProductsWeights.DishID)
JOIN CalorieContents
ON(ProductsWeights.CalorieContentID = CalorieContents.ID)
WHERE CalorieContents.Name = @Name

/* 3 */

DECLARE @Day INT
SET @Day = 6;

SELECT Name
FROM CalorieContents
WHERE ID IN
	(SELECT CalorieContentID
	FROM ProductsWeights
	WHERE DishID IN
			(SELECT DishID
			FROM Menu
			WHERE Menu.Day = @Day))
AND

	Name NOT IN 
	(SELECT CalorieContents.Name 
	FROM 
	Menu INNER JOIN ProductsWeights
	ON(Menu.DishID = ProductsWeights.DishID)
	JOIN CalorieContents
	ON(CalorieContents.ID = ProductsWeights.CalorieContentID)
	WHERE Day != @Day 
	GROUP BY CalorieContents.Name)

/* 4 */

DECLARE @MaxQuantity INT
SET @MaxQuantity = (SELECT  MAX(Quantity)
FROM 
	(SELECT COUNT(Name) AS Quantity
	FROM Menu INNER JOIN Dishes
	ON(Dishes.ID = Menu.DishID)
	GROUP BY Name) AS M);

SELECT  Name, @MaxQuantity as Quantity
FROM
Menu INNER JOIN Dishes
ON(Dishes.ID = Menu.DishID)
GROUP BY NAME
HAVING COUNT(NAME) = @MaxQuantity

/* 5 */

SELECT Day, Sum(Menu.Weight * ProductsWeights.Weight * 
CalorieContents.CalorieContent) as CalorieContent
FROM Menu INNER JOIN Dishes
ON (Menu.DishID = Dishes.ID)
JOIN ProductsWeights
ON(Dishes.ID = ProductsWeights.DishID)
JOIN CalorieContents
ON( ProductsWeights.CalorieContentID = CalorieContents.ID) 
GROUP BY DAY;

/* testing */

SELECT * 
FROM Menu
INNER JOIN Dishes
ON(Menu.DishID = Dishes.ID)
JOIN ProductsWeights
ON(Dishes.ID = ProductsWeights.DishID)
JOIN CalorieContents
ON(CalorieContents.ID = ProductsWeights.CalorieContentID)


