CS 348 - Homework 1: SQL (Joins, Aggregations, Set Operators)
(100 Points)
Fall 2025

Due on: 9/14/2025 at 11:59 pm 
This assignment is to be completed by individuals. 
There will be a 10% penalty if the homework is submitted 24 hours after the due date, a 20% penalty if the homework is submitted 48 hours after the due date, or a 30% penalty if the homework is submitted 72 hours after the due date. The homework will not be accepted after 72 hours, as a solution will be posted by then.

Submission Instructions: 
Submit your answers using the hw1.py skeleton file included with this assignment. The python file is read by the autograder. It is important to have a syntax-error free file. Your query result should have the same attributes(columns) exactly in the same order as the expected result shown in each question. However, the rows can be in any order unless a specific order is required by the question. Column headers can be different. Before submitting your Python file, execute the file using the command: Python3 hw1.py The output should contain all of your queries. Getting the correct output ensures that the autograder will be able to read your queries.

The homework will be submitted in Gradescope. Make sure you submit the correct file (hw1.py). The number of attempts (submissions to Gradescope) is unlimited. There is no partial in this assignment.
The Homework 1 lead TA will announce in Ed when the Gradescope submission is open. Meanwhile, you can test your queries using the database included with Homework 1. 


Notes:
- For all questions, include all columns shown in the expected result.
- You are not allowed to use the WITH clause in this homework. The autograder will return a zero score for queries that include the WITH clause.


Database instructions:
For this assignment, use medical.db SQLite database included with this assignment. You can open the database by simply typing .open medical.db in the SQLite shell. For a readable layout in SQLite shell, run the commands 
.mode column 
.headers on


The database:
-- Patients Table
CREATE TABLE IF NOT EXISTS Patients (
    PatientID INTEGER PRIMARY KEY,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Age INTEGER,
    StreetAddress TEXT,
    City TEXT,
    ZipCode TEXT
);

-- Doctors Table
CREATE TABLE IF NOT EXISTS Doctors (
    DoctorID INTEGER PRIMARY KEY,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Age INTEGER,
    Specialty TEXT,
    StreetAddress TEXT,
    City TEXT,
    ZipCode TEXT
);


-- Appointments Table
CREATE TABLE IF NOT EXISTS Appointments (
    AppointmentID INTEGER PRIMARY KEY,
    PatientID INTEGER,
    DoctorID INTEGER,
    AppointmentDateTime TEXT NOT NULL,
    Reason TEXT,
    Diagnosis TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


-- Vitals Table
CREATE TABLE IF NOT EXISTS Vitals (
    RecordID INTEGER PRIMARY KEY,
    AppointmentID INTEGER,
    DateTime TEXT NOT NULL,
    BloodPressureHigh INTEGER,
    BloodPressureLow INTEGER,
    OxygenLevel INTEGER,
    Temperature REAL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);


-- Prescriptions Table
CREATE TABLE IF NOT EXISTS Prescriptions (
    AppointmentID INTEGER,
    DrugID INTEGER,
    Dosage TEXT,
    Duration TEXT,
    Price REAL,
    PRIMARY KEY (AppointmentID, DrugID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (DrugID) REFERENCES Drugs(ID)
);


-- Drugs Table
CREATE TABLE IF NOT EXISTS Drugs (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

All questions have the same number of points (100/13)


======================================================
1) List the following details about the patient appointments. 

Expected Result:

FirstName  LastName  AppointmentDateTime  Reason           Diagnosis
---------  --------  -------------------  ---------------  ---------
John       Doe       2024-01-10 09:00     Routine Checkup  Healthy
Jane       Smith     2024-01-15 10:30     Headache         Migraine
Jane       Smith     2024-01-20 08:45     Vaccination      Healthy
Michael    Brown     2024-01-25 14:00     Skin Rash        Eczema
Michael    Brown     2024-01-30 16:30     General Checkup  Healthy


============================================
2) For every doctor who has at least one appointment, report their total number of appointments and number of distinct patients.

DoctorName      total_appointments  distinct_patients
--------------  ------------------  -----------------
Alice Wilson    2                   2
Linda Taylor    2                   2
David Anderson  1                   1

=============================================
3) For every patient who has received at least one prescription, report the total number of prescriptions and the total cost across all their appointments.

PatientName    total_prescriptions  total_cost
-------------  -------------------  ----------
Jane Smith     3                    65.0
Michael Brown  2                    75.0


==========================================
4) List the measured tempreatures and Prescribed drugs in all appointments. You can use the SQLite || operator to concatenate first and last names.

PatientName    DoctorName      vital_time        Temperature  drug_name        Dosage
-------------  --------------  ----------------  -----------  ---------------  -----------------
Jane Smith     Alice Wilson    2024-01-15 10:45  99.1         Ibuprofen        50mg
Jane Smith     Linda Taylor    2024-01-20 09:00  98.7         Ibuprofen        5ml
Michael Brown  David Anderson  2024-01-25 10:45  100.2        Cortisone Cream  Apply twice daily
Michael Brown  David Anderson  2024-01-25 14:15  98.5         Cortisone Cream  Apply twice daily
Jane Smith     Alice Wilson    2024-01-15 10:45  99.1         Amoxicillin      10mg


=====================================================================
5)The previous result misses some data, such as patients/doctors with no appointments and drugs that have never been prescribed. Modify the query to include the missing data.


Expected Output (note that empty cells contain Null values)
PatientName    DoctorName       vital_time        Temperature  drug_name        Dosage
-------------  ---------------  ----------------  -----------  ---------------  -----------------
John Doe       Alice Wilson     2024-01-10 09:15  98.6
Jane Smith     Alice Wilson     2024-01-15 10:45  99.1         Ibuprofen        50mg
Jane Smith     Alice Wilson     2024-01-15 10:45  99.1         Amoxicillin      10mg
Jane Smith     Linda Taylor     2024-01-20 09:00  98.7         Ibuprofen        5ml
Emily Johnson
Michael Brown  David Anderson   2024-01-25 10:45  100.2        Cortisone Cream  Apply twice daily
Michael Brown  David Anderson   2024-01-25 14:15  98.5         Cortisone Cream  Apply twice daily
Michael Brown  Linda Taylor                                    Amoxicillin      100mg
Sarah Davis
               Robert Miller
               Jennifer Harris
                                                               Vaccine A
                                                               Loratadine

===========================================================
6) Modify the previous query to remove doctors with no appointments and drugs with no prescriptions. Keep all patients regardless if they have appointments or not.

PatientName    DoctorName      vital_time        Temperature  drug_name        Dosage
-------------  --------------  ----------------  -----------  ---------------  -----------------
John Doe       Alice Wilson    2024-01-10 09:15  98.6
Jane Smith     Alice Wilson    2024-01-15 10:45  99.1         Ibuprofen        50mg
Jane Smith     Alice Wilson    2024-01-15 10:45  99.1         Amoxicillin      10mg
Jane Smith     Linda Taylor    2024-01-20 09:00  98.7         Ibuprofen        5ml
Emily Johnson
Michael Brown  Linda Taylor                                   Amoxicillin      100mg
Michael Brown  David Anderson  2024-01-25 10:45  100.2        Cortisone Cream  Apply twice daily
Michael Brown  David Anderson  2024-01-25 14:15  98.5         Cortisone Cream  Apply twice daily
Sarah Davis

=======================================
7) Find pairs of patients living in the same city.

Patient1       Patient2       City
-------------  -------------  -----------
John Doe       Jane Smith     Springfield
Emily Johnson  Michael Brown  Greenfield

======================================
8) Find an appointment with a doctor and patient pair having the same age. 

Patient   Doctor        Age  AppointmentDateTime
--------  ------------  ---  -------------------
John Doe  Alice Wilson  42   2024-01-10 09:00

============================
9) For every patient living in Springfield, display the count of tempreature records and the average of those records. Keep only patients with two or more tempreature records.

PatientName  avg_temp  temp_count
-----------  --------  ----------
Jane Smith   98.9      2


=======================================
10) For each Specialty, count the number of doctors, the number of patients seen by the specialty doctors, and the number of drugs prescribed by the specialty doctors. 

Specialty         number_doctors  number_patients  number_drugs
----------------  --------------  ---------------  ------------
Cardiology        1               2                2
General Practice  2               0                0
Pediatrics        2               3                3


===============================================

11) find city-zipcode pairs that have patients and no doctors.

City       ZipCode
---------  -------
Hillsdale  67890


====================================
12) Count the appointments whose reason contains the word 'Checkup'. Also, Count the appointments whose diagnosis contains the word 'Healthy'. Note that you can add a string as a column like in the expected result below (e.g., Select GPA, 'Out of 4.0' as a description ...)

appointment_type      appointments_count
--------------------  ------------------
diagonsis is Healthy  3
reason is Checkup     2


==================================
13) Find any appointment where the doctor has prescribed both 'Ibuprofen' and 'Amoxicillin'. List the appointment id, the patient name, and the doctor name.

AppointmentID  PatientName  DoctorName
-------------  -----------  ------------
112            Jane Smith   Alice Wilson
