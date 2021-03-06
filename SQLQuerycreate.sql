Create database covid_management;

/*Address*/
CREATE TABLE ADDRESS_DIVISION (
   zipCode INT NOT NULL PRIMARY KEY,
   state VARCHAR(4),
   country VARCHAR(10)
);
 


/*Person*/
CREATE TABLE PERSON (
  personID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  zipCode INT FOREIGN KEY REFERENCES ADDRESS_DIVISION(zipCode),
  firstName VARCHAR(20),
  lastName VARCHAR(20),
  sex VARCHAR(10),
  dateOfBirth DATE,
  email VARCHAR(50),
  phone VARCHAR(10),
  personType VARCHAR(10),
  healthInsuranceID VARCHAR(20)
)
 

 
/*VACCINATION*/

CREATE TABLE VACCINATION (
  vaccinationID INT NOT NULL PRIMARY KEY IDENTITY(500,1),
  personID INT FOREIGN KEY REFERENCES PERSON(personID),
  vaccineName VARCHAR(20),
  dateOfVaccination DATE,
  numberOfVaccination INT,
  centerName VARCHAR(50),
);



/*BUILDING*/

CREATE TABLE BUILDING
(
 buildingID INT NOT NULL,
 classRoomNumber INT NOT NULL,
 collegeName VARCHAR(20),
 buildingName VARCHAR(20),
 capacity INT,
 CONSTRAINT BUILDING_PK PRIMARY KEY(buildingId,classRoomNumber)
)



/*COVID_RECORD*/
 
CREATE TABLE COVID_RECORD(
  covidTestID INT NOT NULL PRIMARY KEY IDENTITY(100,1),
  personID INT FOREIGN KEY REFERENCES PERSON(personID),
  bodyTemperature FLOAT,
  oxygenLevel FLOAT,
  result VARCHAR(10),
  CovidTestTimestamp DATETIME,
  typeOfTest VARCHAR(20)
);

/*QUARANTINE_CENTER*/

CREATE TABLE QUARANTINE_CENTER(
  centerID INT NOT NULL PRIMARY KEY,
  address varchar(20)
);
 

/*QUARANTINE*/
CREATE TABLE QUARANTINE (
  centerID INT FOREIGN KEY REFERENCES QUARANTINE_CENTER(centerID),
  personID INT FOREIGN KEY REFERENCES PERSON(personID),
  admitDate DATE,
  CONSTRAINT Quarantine_pk PRIMARY KEY (centerID, personID)
)


/*VISIT*/
CREATE TABLE VISIT
(
 personID INT FOREIGN KEY REFERENCES PERSON(personID),
 buildingID INT,
 classRoomNumber INT,
 visitTimeStamp DATETIME,
 CONSTRAINT VISIT_FK FOREIGN KEY (buildingID, classRoomNumber) REFERENCES BUILDING(buildingID, classRoomNumber),
 CONSTRAINT VISIT_PK PRIMARY KEY(personID,buildingID, classRoomNumber)
);


/*STUDENT*/
 
CREATE TABLE STUDENT(
  NUID BIGINT NOT NULL PRIMARY KEY IDENTITY(1610000, 2),
  personID INT FOREIGN KEY REFERENCES PERSON(personID),
  semester VARCHAR(20),
  major VARCHAR(25),
  degreeType VARCHAR(20)
);


/*UHCS_RECORD*/
 
CREATE TABLE UHCS_RECORD(
  UHCSRecordID INT NOT NULL PRIMARY KEY IDENTITY(5000,1),
  personID INT FOREIGN KEY REFERENCES PERSON(personID),
  visitingDateTime DATETIME,
  symptoms VARCHAR(50),
  wellnessCheckStatus VARCHAR(5),
  prescribedMedicine VARCHAR(50),
  comments VARCHAR(50)
)

/*COURSE*/
CREATE TABLE COURSE
(
 courseID INT NOT NULL PRIMARY KEY IDENTITY(3000,1),
 courseName VARCHAR(25),
 credits INT
);


/*PROFESSOR*/

CREATE TABLE PROFESSOR(
  PNUID BIGINT NOT NULL PRIMARY KEY IDENTITY(21467, 2),
  personID INT FOREIGN KEY REFERENCES PERSON(personID),
  department VARCHAR(20),
  designation VARCHAR(20)
);



/*STAFF*/
CREATE TABLE STAFF(
 SNUID INT NOT NULL PRIMARY KEY IDENTITY(101, 2),
 personID INT FOREIGN KEY REFERENCES PERSON(personID),
 jobDescription VARCHAR(50),
 serviceHours INT
);


/*UHCS_DOCTOR*/

CREATE TABLE UHCS_DOCTOR(
 doctorID INT NOT NULL PRIMARY KEY IDENTITY(911,2),
 personID INT FOREIGN KEY REFERENCES PERSON(personID),
 specialization VARCHAR(20),
 experience INT
);


/*REGISTER*/
CREATE TABLE REGISTER (
 NUID BIGINT FOREIGN KEY REFERENCES STUDENT(NUID),
 PNUID BIGINT FOREIGN KEY REFERENCES PROFESSOR(PNUID),
 courseID INT FOREIGN KEY REFERENCES COURSE(CourseID),
 term VARCHAR(15),
 CONSTRAINT REGISTER_PK1 PRIMARY KEY(NUID,PNUID,courseID)
);


/*ACCESS*/

CREATE TABLE ACCESS(
  UHCSRecordID INT FOREIGN KEY REFERENCES UHCS_RECORD(UHCSRecordID),
  doctorID INT FOREIGN KEY REFERENCES UHCS_DOCTOR(doctorID),
  CONSTRAINT ACESSS_PK PRIMARY KEY(UHCSRecordID, doctorID)
)

