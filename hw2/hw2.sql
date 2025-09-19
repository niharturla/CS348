CS 348 - Homework 2: SQL (Subqueries, Correlated Subqueries)
(100 Points)
Fall 2025

Due on: 9/24/2025 at 11:59 pm 
This assignment is to be completed by individuals. 
There will be a 10% penalty if the homework is submitted 24 hours after the due date, a 20% penalty if the homework is submitted 48 hours after the due date, or a 30% penalty if the homework is submitted 72 hours after the due date. The homework will not be accepted after 72 hours, as a solution will be posted by then.

Submission Instructions: 
Submit your answers using the hw2.py skeleton file included with this assignment. The python file is read by the autograder. It is important to have a syntax-error free file. Your query result should have the same attributes(columns) exactly in the same order as the expected result shown in each question. However, the rows can be in any order unless a specific order is required by the question. Column headers can be different. Before submitting your Python file, execute the file using the command: Python3 hw2.py The output should contain all of your queries. Getting the correct output ensures that the autograder will be able to read your queries.

The homework will be submitted in Gradescope. Make sure you submit the correct file (hw2.py). The number of attempts (submissions to Gradescope) is unlimited. There is no partial in this assignment.
The Homework 2 lead TA will announce in Ed when the Gradescope submission is open. Meanwhile, you can test your queries using the database included with Homework 1. 


Notes:
- For all questions, include all columns shown in the expected result.
- You are not allowed to use the WITH clause in this homework. The autograder will return a zero score for queries that include the WITH clause.


Database instructions:
For this assignment, use medical.db SQLite database included with this assignment. You can open the database by simply typing .open medical.db in the SQLite shell. For a readable layout in SQLite shell, run the commands 
.mode column 
.headers on


The database: Use the medical.db database from Homework 1.

All questions have the same number of points (100/12)

=================================================================
1) List the first name, last name, and tempreature for patient(s) with the highest tempreature reading. Discard duplicate rows if a patient has the highest tempreature multiple times.

Expected Result:

FirstName  LastName  Temperature
---------  --------  -----------
Michael    Brown     100.2

==================================================================
2) Find the maximum tempreature in each day. List the patients who had those maximum tempreatures. discard any duplicate rows.

Expected Result:

FirstName  LastName  Temperature  date
---------  --------  -----------  ----------
John       Doe       98.6         2024-01-10
Jane       Smith     99.1         2024-01-15
Jane       Smith     98.7         2024-01-20
Michael    Brown     100.2        2024-01-25

=========================================================
3) Find the average temperature readings for patients in each city. Retain only the city (or cities) with the highest average. Also include the number of temperature readings for each city you display.

Expected Result:

City        avg_temp  temp_count
----------  --------  ----------
Greenfield  99.35     2

==================================================================
4) Find the highest and the second highest age in the patients table. List patient(s) having one of those two ages. Note that the result may contain 3 or more patients if multiple people have the same age.

Expected Result:

PatientID  FirstName  LastName  Age  StreetAddress  City         ZipCode
---------  ---------  --------  ---  -------------  -----------  -------
1          John       Doe       42   123 Maple St   Springfield  12345
3          Emily      Johnson   47   789 Pine Blvd  Greenfield   54321

====================================================================
5) Find each city’s patient count, and keep only the cities whose patient count is above the average patient count per city (e.g., the average patient count per city in the given database is 1.66 and only Greenfield and Springfield are above the average).

Expected Result:

City         patient_count
-----------  -------------
Greenfield   2
Springfield  2

====================================================================
6) For each city C, find the oldest patients in C (i.e., patients having the highest age in the city).

Expected Result:

PatientID  FirstName  LastName  Age  StreetAddress  City         ZipCode
---------  ---------  --------  ---  -------------  -----------  -------
1          John       Doe       42   123 Maple St   Springfield  12345
3          Emily      Johnson   47   789 Pine Blvd  Greenfield   54321
5          Sarah      Davis     27   654 Elm St     Hillsdale    67890

====================================================================
7) List both the drugs with the lowest number of prescriptions and the drugs with highest number of prescriptions.

Expected Result:

ID    Name         prescription_count  description
----  -----------  ------------------  -----------------------
1001  Ibuprofen    2                   highest prescribed drug
1002  Vaccine A    0                   lowest prescribed drug
1004  Amoxicillin  2                   highest prescribed drug
1005  Loratadine   0                   lowest prescribed drug

===================================================================
8) List all patient tempreature readings. Include a column that shows the overall average tempreature.

Expected Result:

PatientName    DoctorName      vital_time        Temperature  avg_temp
-------------  --------------  ----------------  -----------  --------
John Doe       Alice Wilson    2024-01-10 09:15  98.6         99.02
Jane Smith     Alice Wilson    2024-01-15 10:45  99.1         99.02
Jane Smith     Linda Taylor    2024-01-20 09:00  98.7         99.02
Michael Brown  David Anderson  2024-01-25 10:45  100.2        99.02
Michael Brown  David Anderson  2024-01-25 14:15  98.5         99.02

=================================================================
9) Modify the query in the previous question to show the highest tempreature for the patient in each row.

Expected Result:

PatientName    DoctorName      vital_time        Temperature  patient_high
-------------  --------------  ----------------  -----------  ------------
John Doe       Alice Wilson    2024-01-10 09:15  98.6         98.6
Jane Smith     Alice Wilson    2024-01-15 10:45  99.1         99.1
Jane Smith     Linda Taylor    2024-01-20 09:00  98.7         99.1
Michael Brown  David Anderson  2024-01-25 10:45  100.2        100.2
Michael Brown  David Anderson  2024-01-25 14:15  98.5         100.2


=================================================
10) Find specialties that have the same number of doctors.

Expected Result:

specialty         doctor_count  specialty   doctor_count
----------------  ------------  ----------  ------------
General Practice  2             Pediatrics  2

=============================================
11) Find the number of doctors and the number of patients in each city. Additionally, for each city C, count the number of appointments where both the doctor and the patient are from city C.

Expected Result:

city         doctor_count  patient_count  appointment_count
-----------  ------------  -------------  -----------------
Greenfield   1             2              1
Hillsdale                  1
Riverdale    2
Springfield  2             2              2

=============================================

12) Find the patient(s) who achieved the minimum temperature on the day(s) that include the highest tempreature across all days. For example, in the given database, 2024-01-25 has the highest temperature (100.2) across all days. The result is listing the patient with the minmum tempreature (98.5) on 2024-01-25. Note that if multiple days tie for the highest tempreature, you need to find one minimum tempreature in all of those days. 

Expected Result:

FirstName  LastName  Temperature  day
---------  --------  -----------  ----------
Michael    Brown     98.5         2024-01-25
