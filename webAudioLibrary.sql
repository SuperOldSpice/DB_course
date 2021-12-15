CREATE DATABASE AudioLibrary;
USE AudioLibrary;

CREATE TABLE Audio(
Id INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
Name VARCHAR(MAX) NOT NULL,
Cost DECIMAL NOT NULL,
Year INT NOT NULL,
AuthorId INT NOT NULL,
);

CREATE TABLE Author(
Id INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
Name VARCHAR(MAX) NOT NULL,
);

ALTER TABLE Audio
ADD CONSTRAINT FK_Audio_Author FOREIGN KEY (AuthorId)
REFERENCES Author(Id)
ON UPDATE CASCADE 
ON DELETE CASCADE;

INSERT INTO Author(Name) VALUES
('Jaye Bryan'),
('Mike Cage'),
('Frida Gray'),
('Steffan Bate');

INSERT INTO Audio(Name, Cost, Year, AuthorId) VALUES
('Mask of fury', 15, 2006, 1),
('Dressed for crime', 10, 2015, 3),
('Paradise bound', 18, 2017, 2),
('Axe and the wolf', 12, 2019, 2),
('The Oracle in the Marsh', 7, 2004, 4);

SELECT DISTINCT local_net_address, local_tcp_port 
FROM  sys.dm_exec_connections  
WHERE local_net_address is  not  null;