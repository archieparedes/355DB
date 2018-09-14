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
    hotelID VARCHAR2(4),
    hotelName VARCHAR2(25),
    City VARCHAR2(20) NOT NULL,
-- CONSTRAINTS --
    CONSTRAINT HOTEL_PK
        PRIMARY KEY(hotelID) -- Primary Key
);

CREATE TABLE RESERVATION(
    travelerID NUMBER(9), -- Foreign Key
    hotelID VARCHAR2(4), -- Foreign Key
    startDate DATE,
    endDate DATE,
    Confirmation CHAR(10),
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
        REFERENCES HOTEL(hotelID) -- hotelID becomes ID from HOTEL table
);
-- DATA INSERT --
INSERT INTO HOTEL VALUES('58aa','Hilton Chicago', 'Chicago');
INSERT INTO HOTEL VALUES('57ab', 'Chula Vista', 'Wisconsin Dells');
INSERT INTO HOTEL VALUES('56ac', 'JW Marrioit', 'Chicago');
INSERT INTO HOTEL VALUES('55ba', 'Holiday Inn', 'Mount Prospect');

INSERT INTO TRAVELER VALUES(189258658, 'Archie', 'Paredes','6303282828');
INSERT INTO TRAVELER VALUES(132330658, 'Ryan', 'Fogarty','6307484848');
INSERT INTO TRAVELER VALUES(598669909, 'Aloy', 'Paredes','6303272727');
INSERT INTO TRAVELER VALUES(232456674, 'David', 'Bucio','7935555555');
