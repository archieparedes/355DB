/*
	TransactionWarehouse.sql
	Alexander Rasin
	CSC 355 Fall 2018
*/


-- Store(StoreID, City, State)
-- Transaction(StoreID, TransID, Date, Amount)

-- get rid of any existing tables

DROP TABLE Transaction; -- drops transaction table
DROP TABLE Store; 

-- SELECT * From Course; -- * means select all
-- create the new tables, each with primary keys

-- can only run once because error. error because table already exist
CREATE TABLE Store(
-- schema: store(StoreID, City, State)
        StoreID   NUMBER(3), -- 1-99 up to 3 digit int. StoreID is a foreign key
 	
        City    VARCHAR2(20) NOT NULL, -- 20 char limit, cannot be null
	
        State  CHAR(2) NOT NULL, -- 2 char limit, cannot be null
      
      CONSTRAINT STORE_ID -- this makes sure not StoreID is duplicated
            PRIMARY KEY (StoreID)
);

CREATE TABLE Transaction(
-- schema Transaction(StoreID, TransID, TDate, Amount)
        StoreID   NUMBER, -- Foreign Key
 	
        TransID  NUMBER,
	
        TDate       DATE, -- UNIQUE,  -- UNIQUE means the column cannot have any repeating values
        Amount  NUMBER(*, 2) DEFAULT 0,  -- defaults to 0
        
-- contraint is like if-then statement but doesnt do anything. it just doesnt allow it
      CONSTRAINT DateCheck
           Check (TDate > To_Date('01-Jan-2010')), -- checks and make sure date is greater than 1/1/10

      CONSTRAINT AmountCheck
           Check (Amount > 0.00), -- checks amount exceeds 0.00

      CONSTRAINT Transaction_ID
           PRIMARY KEY (StoreID, TransID),

      CONSTRAINT Transaction_FK1
           FOREIGN KEY (StoreID) -- transaction relies on Store Data    
           REFERENCES Store(StoreID)
);null


DROP TABLE Store;

-- Cascade:
drop table store cascade constraints;

-- custom insertion order
INSERT INTO Store(State, City, StoreID) VALUES('IL', 'Chicago', 888);

-- insert data...
INSERT INTO Store VALUES  (100, 'Chicago', 'IL');
INSERT INTO Store VALUES  (200, 'Chicago', 'IL');
INSERT INTO Store VALUES  (300, 'Schaumburg', 'IL');
INSERT INTO Store VALUES  (400, 'Boston', 'MA');
INSERT INTO Store VALUES  (500, 'Boston', 'MA');
INSERT INTO Store VALUES  (600, 'Portland', 'ME');

-- violating primary key costraint (StoreID already exists)
INSERT INTO Store VALUES  (600, 'NotPortland', 'ME');

-- violate NOT NULL constraint
INSERT INTO Store VALUES  (700, NULL, 'CA');


INSERT INTO Transaction Values(100, 1, '10-Oct-2011', 100.00);
INSERT INTO Transaction Values(100, 2, '11-Oct-2011', 120.00);
INSERT INTO Transaction Values(200, 1, '11-Oct-2011', 50.00);
INSERT INTO Transaction Values(200, 2, '11-Oct-2011', 70.00);
INSERT INTO Transaction Values(300, 1, '12-Oct-2011', 20.00);
INSERT INTO Transaction Values(400, 1, '10-Oct-2011', 10.00);

INSERT INTO Transaction Values(400, 2, '11-Oct-2011', 20.00);
INSERT INTO Transaction Values(400, 3, '12-Oct-2011', 30.00);
INSERT INTO Transaction Values(500, 1, '10-Oct-2011', 10.00);
INSERT INTO Transaction Values(500, 2, '10-Oct-2011', 110.00);
INSERT INTO Transaction Values(500, 3, '11-Oct-2011', 90.00);

INSERT INTO Transaction (StoreID, TransID, TDate, Amount)
          Values(600, 1, '11-Oct-2011', 300.00);

-- missing date
INSERT INTO Transaction (StoreID, TransID, Amount)
          Values(600, 2 , 400.00);

SELECT * FROM Transaction;


-- Adding attributes / modify existing table
ALTER TABLE STORE
 ADD UselessColumn CHAR(10); 
 -- DROP COLUMN UselessColumn -- deletes column

SELECT * FROM store;

ALTER TABLE store
 DROP COLUMN UselessColumn;

SELECT * FROM Store;

-- if Boston: change to Bohston
UPDATE Store SET city = 'Bohston'
    WHERE city = 'Boston';

SELECT * FROM Store;

SELECT * FROM Transaction;

UPDATE Transaction SET Amount = Amount * 1.2
   WHERE StoreID = 400;

SELECT * FROM Transaction;

-- Delete a row
DELETE FROM Transaction
    WHERE Amount = 400;
    
-- Delete row with StoreID 888
DELETE FROM Store 
    WHERE StoreID = 888;
    
    
-- Queries:    
SELECT TDate, Amount
 FROM Transaction
 WHERE Amount >= 100;    



SELECT *
FROM Store
WHERE City LIKE 'B_ston';

SELECT *
FROM Store
WHERE City LIKE 'B%ston';

-- Combining predicates
 SELECT TDate, Amount
 FROM Transaction
 WHERE Amount > 40 AND Amount < 80;
    
SELECT storeid, city
 FROM store
 WHERE state = 'IL' OR state = 'ME';


-- Order by
SELECT Amount, TDate, TransID
FROM Transaction
ORDER BY Amount;

SELECT *
FROM Store
ORDER BY State, City;


 SELECT TDate, Amount
 FROM Transaction
 WHERE Amount >=20
 ORDER BY TDate, Amount;


-- Aggregation
  SELECT SUM(Amount)
  FROM Transaction
  WHERE Amount <= 20 or Amount >= 100;

  SELECT AVG(Amount)
  FROM Transaction
  WHERE TDate = to_date('11-Oct-2011');

 SELECT SUM(Amount)/COUNT(Amount)
  FROM Transaction;

  SELECT MAX(Amount)
  FROM Transaction
  WHERE Amount < 55;


--GROUP BY
 SELECT state, COUNT(StoreID)
  FROM Store
  GROUP BY state;

  SELECT state, COUNT(DISTINCT city)
  FROM Store
  GROUP BY state;

  SELECT state, city, COUNT(StoreID)
  FROM Store
  GROUP BY state, city;

  SELECT TDate, SUM(Amount)
  FROM Transaction
  GROUP BY TDate;

 SELECT StoreID, MAX(Amount)
  FROM Transaction
  GROUP BY StoreID
  ORDER BY StoreID;

SELECT StoreID, 0.5*MIN(Amount), 1.5*MAX(Amount)
  FROM Transaction
  GROUP BY StoreID
  ORDER BY StoreID ASC;

--HAVING
 SELECT TDate, SUM(Amount)
  FROM Transaction
  GROUP BY Tdate;
  
 SELECT TDate, SUM(Amount)
  FROM Transaction
  GROUP BY Tdate
  HAVING Sum(Amount) > 200;

