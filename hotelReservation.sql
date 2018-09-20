/*
Archie Paredes
CSC 355, DATABASE SYSTEMS
Septemeber 12, 2018
*/

-- DROPS --
DROP TABLE RESERVATION;
DROP TABLE TRAVELER;
DROP TABLE HOTEL;

-- TABLE CREATION --
CREATE TABLE TRAVELER(
    ID CHAR(9),
    firstName VARCHAR2(20),
    lastName VARCHAR2(20),
    PHONE CHAR(10),
    CONSTRAINT TRAVELER_PK
        PRIMARY KEY(ID) -- Primary Key
);

CREATE TABLE HOTEL(
    ID CHAR(4),
    hotelName VARCHAR2(25),
    City VARCHAR2(20) NOT NULL,
    
-- CONSTRAINTS --
    CONSTRAINT HOTEL_PK
        PRIMARY KEY(ID) -- Primary Key
);

CREATE TABLE RESERVATION(
    travelerID CHAR(9), -- Foreign Key
    hotelID CHAR(4), -- Foreign Key
    startDate DATE,
    endDate DATE,
    Confirmation VARCHAR2(10),
    
-- CONSTRAINTS --
    CONSTRAINT endDateCheck
        CHECK(endDate > startDate),
    CONSTRAINT RESERVATION_PK
        PRIMARY KEY(travelerID, hotelID),
    CONSTRAINT RESERVATION_FK1
        FOREIGN KEY(travelerID)
        REFERENCES TRAVELER(ID), -- travelerID becomes ID from TRAVELER table
    CONSTRAINT RESERVATION_FK2
        FOREIGN KEY(hotelID)
        REFERENCES HOTEL(ID) -- hotelID becomes ID from HOTEL table
);

-- DATA INSERT --
INSERT INTO HOTEL VALUES('58aa','Hilton Chicago', 'Chicago');
INSERT INTO HOTEL VALUES('57ab', 'Chula Vista', 'Wisconsin Dells');
INSERT INTO HOTEL VALUES('56ac', 'JW Marriot', 'Chicago');
INSERT INTO HOTEL VALUES('55ba', 'Holiday Inn', 'Mount Prospect');

INSERT INTO TRAVELER VALUES(189258658, 'Archie', 'Paredes','6303282828');
INSERT INTO TRAVELER VALUES(234512374, 'David', 'Bucio','6303626262');
INSERT INTO TRAVELER VALUES(132330658, 'Ryan', 'Fogarty','6307484848');
INSERT INTO TRAVELER VALUES(442234123, 'Bilbo', 'Bagsauce','3123292929');

--INSERT INTO RESERVATION VALUES(234512374,'58aa', '12-Sep-2017', '18-Sep-2017', '2345RF56aa');
INSERT INTO RESERVATION VALUES(132330658,'56ac', '12-Sep-2018', NULL, '1323RF56ac');
INSERT INTO RESERVATION VALUES(132330658,'57ab', '11-Nov-2012', '23-Nov-2012', '1323RF57ab');
INSERT INTO RESERVATION VALUES(189258658,'57ab', '01-Jan-2018', '11-Jan-2018', '1892AP57ab');
INSERT INTO RESERVATION VALUES(189258658,'55ba', '10-Jul-2018', '11-Jul-2018', '1892AP55ba');
INSERT INTO RESERVATION VALUES(189258658,'58aa', '03-Nov-2017', '21-Nov-2017', '1892AP58aa');
INSERT INTO RESERVATION VALUES(442234123,'57ab', '11-Nov-2012', '23-Nov-2012', '4422BB57ab');
INSERT INTO RESERVATION VALUES(442234123,'56ac', '11-Nov-2012', '23-Nov-2012', '4422BB56ac');
INSERT INTO RESERVATION VALUES(442234123,'58aa', '11-Nov-2012', '23-Nov-2012', '4422BB58aa');
INSERT INTO RESERVATION VALUES(442234123,'55ba', '11-Nov-2012', '23-Nov-2012', '4422BB55ba');
-- QUERY PRACTICE --
SELECT *
FROM HOTEL;

SELECT * 
FROM RESERVATION 
WHERE travelerID = 189258658; -- reservations from one person

SELECT COUNT(*) 
FROM TRAVELER; -- counts amount of traveler exists

SELECT travelerID, COUNT(*) 
FROM RESERVATION 
GROUP BY travelerID 
ORDER BY COUNT(*); -- counts amount of reservations from each person, in order

SELECT travelerID, COUNT(*)
FROM RESERVATION
GROUP BY travelerID
HAVING COUNT(*) > 1; -- outputs ID and amount of reservation with more than 2 reservations 

SELECT * 
FROM RESERVATION
WHERE startDate >= '01-JAN-2013'; -- shows reservations made during/after 2013

SELECT ID FROM TRAVELER
INTERSECT
SELECT travelerID FROM RESERVATION; -- must be in both table

SELECT ID FROM TRAVELER
UNION
SELECT travelerID FROM RESERVATION; -- at least in one table

-- CARTESIAN PRODUCT --
SELECT * 
FROM TRAVELER, HOTEL, RESERVATION;

-- JOIN CONDITION --
SELECT * 
FROM TRAVELER, HOTEL, RESERVATION
WHERE TRAVELER.ID = travelerID
AND HOTEL.ID = hotelID; -- Equi-join

SELECT * 
FROM TRAVELER, HOTEL, RESERVATION
WHERE TRAVELER.ID = travelerID
AND HOTEL.ID = hotelID; -- Natural-join

SELECT *
FROM TRAVELER INNER JOIN RESERVATION
ON TRAVELER.ID = travelerID; -- Inner-join

SELECT * -- 9/19/2018
FROM TRAVELER LEFT OUTER JOIN RESERVATION
ON TRAVELER.ID = travelerID; -- Left Outer-join shows all users, even they have not reserved (null)
                             -- Right Outer-joins excludes non reserved
SELECT *
FROM TRAVELER FULL OUTER JOIN RESERVATION
ON TRAVELER.ID = travelerID; -- Full outer joins shows all

SELECT firstName, lastName, travelerID, hotelID, startDate, endDate
FROM TRAVELER INNER JOIN RESERVATION 
ON TRAVELER.ID = travelerID;

SELECT travelerID, TRAVELER.lastName, COUNT(travelerID) 
FROM TRAVELER LEFT OUTER JOIN RESERVATION
ON TRAVELER.ID = travelerID 
group by travelerID, TRAVELER.lastName; -- shows amount of reservation, even if person did not reserve.

-- VIEWS --
CREATE VIEW foo AS
SELECT firstName, lastName, travelerID, hotelID, startDate, endDate
FROM TRAVELER INNER JOIN RESERVATION 
ON TRAVELER.ID = travelerID;

SELECT lastName, COUNT(travelerID)
FROM foo
GROUP BY lastName;



