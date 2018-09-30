/*
Archie Paredes
CSC 355, DATABASE SYSTEMS
Septemeber 20, 2018
*/

DROP TABLE PublicChauffeurs;

CREATE TABLE PublicChauffeurs(
    LicenseNumber NUMBER(6) UNIQUE,
    Renewed VARCHAR2(6),
    Status VARCHAR2(15),
    StatusDate DATE,
    DriverType VARCHAR2(16) NOT NULL,
    LicenseType VARCHAR2(9),
    OriginalIssueDate DATE,
    Name VARCHAR2(30),
    Sex VARCHAR2(6),
    ChaufferCity CHAR(25),
    ChaufferState CHAR(2),
    RecordNumber VARCHAR2(11) NOT NULL UNIQUE,
    
    CONSTRAINT PublicChauffeursPK
        PRIMARY KEY(LicenseNumber, Status, RecordNumber) -- Primary Key
);
