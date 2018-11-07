SET SERVEROUTPUT ON; 

DROP TABLE STUDENT CASCADE CONSTRAINTS;
CREATE TABLE STUDENT(
	ID		CHAR(3),
	Name		VARCHAR2(20),
	Midterm	NUMBER(3,0) 	CHECK (Midterm>=0 AND Midterm<=100),
	Final		NUMBER(3,0)	CHECK (Final>=0 AND Final<=100),
	Homework	NUMBER(3,0)	CHECK (Homework>=0 AND Homework<=100),
	PRIMARY KEY (ID)
);
INSERT INTO STUDENT VALUES ( '445', 'Seinfeld', 85, 90, 99 );
INSERT INTO STUDENT VALUES ( '909', 'Costanza', 74, 72, 86 );
INSERT INTO STUDENT VALUES ( '123', 'Benes', 93, 89, 91 );
INSERT INTO STUDENT VALUES ( '111', 'Kramer', 99, 91, 93 );
INSERT INTO STUDENT VALUES ( '667', 'Newman', 78, 82, 83 );
INSERT INTO STUDENT VALUES ( '888', 'Banya', 50, 65, 50 );
--SELECT * FROM STUDENT;

DROP TABLE WEIGHTS CASCADE CONSTRAINTS;
CREATE TABLE WEIGHTS(
	MidPct	NUMBER(2,0) CHECK (MidPct>=0 AND MidPct<=100),
	FinPct	NUMBER(2,0) CHECK (FinPct>=0 AND FinPct<=100),
	HWPct	NUMBER(2,0) CHECK (HWPct>=0 AND HWPct<=100)
);
INSERT INTO WEIGHTS VALUES ( 30, 30, 40 );
--SELECT * FROM WEIGHTS;
COMMIT;

/*  Part 1
Desired output:
Weights are 30 30 40
445 Seinfeld 92.1 A
909 Costanza 78.2 C
123 Benes 91 A
111 Kramer 94.2 A
667 Newman 81.2 B
888 Banya 54.5 F
*/
DECLARE
    studentID STUDENT.ID%TYPE;
    studentName STUDENT.Name%TYPE;
    mid STUDENT.Midterm%TYPE;
    fin STUDENT.Final%TYPE;
    hw STUDENT.Homework%TYPE;
    numGrade DECIMAL(3,1);
    grade Char(1);
    midPer WEIGHTS.MidPct%TYPE;
    finPer WEIGHTS.FinPct%TYPE;
    hwPer WEIGHTS.HWPct%TYPE;
    
CURSOR Curs1 IS
    SELECT MidPct, FinPct, HWPct
    FROM WEIGHTS;
    
CURSOR Curs2 IS
    SELECT ID, Name, MidTerm, Final, Homework
    FROM Student;

BEGIN
    OPEN Curs1;
    LOOP
        FETCH Curs1 INTO midPer, finPer, hwPer;
        IF Curs1%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Weights are '|| midPer || ' ' || finPer || ' ' || hwPer);
        END IF;
        EXIT WHEN Curs1%NOTFOUND;
    END LOOP;

    OPEN Curs2;
    LOOP
        FETCH Curs2 INTO studentID, studentName, mid, fin, hw;
        IF Curs2%FOUND THEN
            numGrade := mid*(midPer/100) + hw*(hwPer/100) + fin*(finPer/100); -- calculates numGrade grade
            IF numGrade >= 90 THEN
                grade := 'A';
            ELSIF numGrade >= 80 and numGrade < 90 THEN
                grade := 'B';
            ELSIF numGrade >= 70 and numGrade < 80 THEN
                grade := 'C';
            ELSIF numGrade >= 60 and numGrade < 70 THEN
                grade := 'D';
            ELSE 
                grade := 'F';
            END IF;
            DBMS_OUTPUT.PUT_LINE(studentID || ' ' || studentName || ' ' || numGrade || ' ' || grade);
        END IF; 
        EXIT WHEN Curs2%NOTFOUND;
    END LOOP;
    CLOSE Curs1;
    CLOSE Curs2;
END;
/

