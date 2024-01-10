CREATE TABLE Department (
departmentNo		INT NOT NULL,
departmentName     VARCHAR(25) NOT NULL,
PRIMARY KEY (departmentNo)
);

CREATE TABLE SpecialistDoctor (
sstaffNo    INT NOT NULL,
sstaffName  VARCHAR(25) NOT NULL,
ssex        CHAR
            CONSTRAINT Staff_sex
            CHECK (ssex IN ('M','F')),
sstaffPhoneNo	VARCHAR(15) NOT NULL,
ssalary			DECIMAL(9,2) NOT NULL,
specialistField VARCHAR(50) NOT NULL,
officeNo		VARCHAR(5) NOT NULL,
departmentNo    INT NOT NULL,

       PRIMARY KEY (sstaffNo),

       FOREIGN KEY (departmentNo)
           REFERENCES Department(departmentNo)
);

CREATE TABLE MedicalDoctor (
mstaffNo    INT NOT NULL,
mstaffName  VARCHAR(25) NOT NULL,
msex        CHAR
            CONSTRAINT Staff_sexCHK
            CHECK (msex IN ('M','F')),
mstaffPhoneNo VARCHAR(15) NOT NULL,
msalary       DECIMAL(9,2) NOT NULL,
roomNo		  VARCHAR(5) NOT NULL,
departmentNo  INT NOT NULL,
PRIMARY KEY (mstaffNo),
       FOREIGN KEY (departmentNo)
           REFERENCES Department(departmentNo)
);

CREATE TABLE LocalPatient(
lpatientNo		INT NOT NULL,
lpatientName	VARCHAR(25) NOT NULL, 
lpatientPhoneNo VARCHAR(15) NOT NULL,
icNo			VARCHAR(12) NOT NULL
PRIMARY KEY (lpatientNo),
);


CREATE TABLE InternationalPatient(
ipatientNo		INT NOT NULL,
ipatientName	VARCHAR(25) NOT NULL, 
ipatientPhoneNo VARCHAR(15) NOT NULL,
nationality		VARCHAR(20) NOT NULL,
passportNo		VARCHAR(20) NOT NULL,
PRIMARY KEY (ipatientNo),
);


CREATE TABLE Appointment(
appointmentNo   INT NOT NULL,
appointmentDate DATE NOT NULL,
appointmentTime TIME NOT NULL,
sstaffNo    INT,
mstaffNo    INT,
lpatientNo  INT ,
ipatientNo  INT,

PRIMARY KEY (appointmentNo),

       FOREIGN KEY (sstaffNo)
           REFERENCES SpecialistDoctor(sstaffNo),

       FOREIGN KEY (mstaffNo)
           REFERENCES MedicalDoctor(mstaffNo),

       FOREIGN KEY (lpatientNo)
           REFERENCES LocalPatient(lpatientNo),

       FOREIGN KEY (ipatientNo)
           REFERENCES InternationalPatient(ipatientNo),
);


CREATE TABLE Treatment(
treatmentNo INT NOT NULL,
ipatientNo  INT,
lpatientNo  INT,
PRIMARY KEY (treatmentNo),
       FOREIGN KEY (lpatientNo)
           REFERENCES LocalPatient(lpatientNo),

       FOREIGN KEY (ipatientNo)
           REFERENCES InternationalPatient(ipatientNo),
);

CREATE TABLE TreatmentDetails (
treatmentNo INT NOT NULL,
wardNo		INT,
bedNo		INT,
admitDate	   DATE,
dischargedDate DATE,
drugNo		   VARCHAR(5),
quantity	   INT,

PRIMARY KEY (treatmentNo),
    FOREIGN KEY (treatmentNo)
         REFERENCES Treatment(treatmentNo),

);




CREATE TABLE InsurancePayment(
ipaymentNo    INT NOT NULL,
amount	      VARCHAR(10) NOT NULL,
ipatientNo	  INT,
lpatientNo	  INT,
insuranceName	 VARCHAR(20) NOT NULL,
InsuranceContact VARCHAR(15) NOT NULL,

PRIMARY KEY (ipaymentNo),
    FOREIGN KEY (ipatientNo)
       REFERENCES InternationalPatient(ipatientNo),

    FOREIGN KEY (lpatientNo)
       REFERENCES LocalPatient(lpatientNo),
);

CREATE TABLE PersonalPayment(
ipaymentNo INT NOT NULL,
amount	   VARCHAR(10) NOT NULL,
ipatientNo INT,
lpatientNo INT,
typeOfPayment VARCHAR(10) NOT NULL,

PRIMARY KEY (ipaymentNo),
   FOREIGN KEY (ipatientNo)
      REFERENCES InternationalPatient(ipatientNo),

   FOREIGN KEY (lpatientNo)
      REFERENCES LocalPatient(lpatientNo),
);
