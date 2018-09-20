/*
Archie Paredes
CSC 355, DATABASE SYSTEMS
Septemeber 20, 2018
*/

CREATE TABLE Animal(
  AID       NUMBER(3, 0),
  AName      VARCHAR2(30) NOT NULL,
  ACategory VARCHAR2(19),  
  TimeToFeed NUMBER(4,2),  
  CONSTRAINT Animal_PK  PRIMARY KEY(AID)
);

  
INSERT INTO Animal VALUES(1, 'Galapagos Penguin', 'exotic', 0.5);
INSERT INTO Animal VALUES(2, 'Emperor Penguin', 'rare', 0.75);

INSERT INTO Animal VALUES(3, 'Sri Lankan sloth bear', 'exotic', 2.5);
INSERT INTO Animal VALUES(4, 'Grizzly bear', 'common', 3.5);
INSERT INTO Animal VALUES(5, 'Giant Panda bear', 'exotic', 1.5);
INSERT INTO Animal VALUES(6, 'Florida black bear', 'rare', 1.75);

INSERT INTO Animal VALUES(7, 'Siberian tiger', 'rare', 3.5);
INSERT INTO Animal VALUES(8, 'Bengal tiger', 'common', 2.75);
INSERT INTO Animal VALUES(9, 'South China tiger', 'exotic', 2.25);

INSERT INTO Animal VALUES(10, 'Alpaca', 'common', 0.25);
INSERT INTO Animal VALUES(11, 'Llama', NULL, 3.25);

-- Querys --
SELECT AName
FROM Animal
WHERE TimeToFeed < 2; -- Find all the animals (their names) that take less than 2 hours to feed.

SELECT AName, TimeToFeed
FROM Animal
WHERE ACategory = 'rare'
ORDER BY TimeToFeed; -- Find all the rare animals and sort the query output by feeding time 

SELECT AName, ACategory
FROM Animal
WHERE AName LIKE '% bear'; -- Find the animal names and categories for the animals that are related to a bear

SELECT AName
FROM Animal
WHERE ACategory IS NULL; -- Return the listings for all animals whose rarity is not available in the database

SELECT AName, ACategory
FROM Animal
WHERE timeToFeed BETWEEN 1 AND 2.2; -- Find the rarity rating of all animals that require between 1 and 2.2 hours to be fed

SELECT AName, ACategory
FROM Animal
WHERE AName LIKE '% tiger' AND ACategory NOT IN 'common'; -- Find the names of the animals that are related to the tiger and are not common

SELECT MIN(TimeToFeed), MAX(TimeToFeed)
FROM Animal; -- Find the minimum and maximum feeding time amongst all the animals in the zoo

SELECT AVG(TimeToFeed)
FROM Animal; -- Find the average feeding time for the rare animals