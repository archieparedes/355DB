/*
Archie Paredes
CSC 355, DATABASE SYSTEMS
Septemeber 12, 2018
*/

-- DROPS --
DROP TABLE TRAVELER;
DROP TABLE HOTEL;
DROP TABLE RESERVATION;

CREATE TABLE TRAVELER(
    ID NUMBER(9),
    firstName VARCHAR2(20),
    lastName VARCHAR2(20),
    PHONE CHAR(10),
    CONSTRAINT TRAVELER_PK
        PRIMARY KEY(ID) -- Primary Key
);

CREATE TABLE HOTEL(
    ID VARCHAR2(4),
    hotelName VARCHAR2(25),
    City VARCHAR2(20) NOT NULL,
    
-- CONSTRAINTS --
    CONSTRAINT HOTEL_PK
        PRIMARY KEY(ID) -- Primary Key
);

CREATE TABLE RESERVATION(
    travelerID NUMBER(9), -- Foreign Key
    hotelID VARCHAR2(4), -- Foreign Key
    startDate DATE,
    endDate DATE,
    Confirmation VARCHAR(10),
    
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
INSERT INTO HOTEL VALUES('56ac', 'JW Marrioit', 'Chicago');
INSERT INTO HOTEL VALUES('55ba', 'Holiday Inn', 'Mount Prospect');

INSERT INTO TRAVELER VALUES(189258658, 'Archie', 'Paredes','6303282828');
INSERT INTO TRAVELER VALUES(132330658, 'Ryan', 'Fogarty','6307484848');

INSERT INTO RESERVATION VALUES(132330658,'58aa', '12-Sep-2017', '18-Sep-2017', '1323RF56aa');
INSERT INTO RESERVATION VALUES(132330658,'56ac', '12-Sep-2018', NULL, '1323RF56ac');
INSERT INTO RESERVATION VALUES(189258658,'57ab', '01-Jan-2018', '11-Jan-2018', '1892AP57ab');
INSERT INTO RESERVATION VALUES(189258658,'55ba', '10-Jul-2018', '11-Jul-2018', '1892AP55ba');
INSERT INTO RESERVATION VALUES(189258658,'58aa', '03-Nov-2017', '21-Nov-2017', '1892AP58aa');