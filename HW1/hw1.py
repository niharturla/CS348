# Use this file to write your queries. Submit this file to Gradescope after finishing your homework.

# Make sure to test that this script prints out the strings (your SQL queries) correctly.

# To verify your submission is in the correct format: `python3 hw1.py`

# Make sure the program prints out your SQL statements correctly. That means the autograder will read you SQL correctly. Running the Python file will not execute your SQL statements, it simply prints them.

instr = '''Instructions:
	Please put the queries under the corresponding functions below.
	Running this python file will check if the formatting is okay.
	Example:
		def query1():
			return """
				SELECT * FROM agent
			"""
'''

def query1():
	return """
	SELECT p.FirstName, p.LastName, a.AppointmentDateTime, a.Reason, a.Diagnosis
	FROM Appointments a
	JOIN Patients p ON a.PatientID = p.PatientID;
	"""

def query2():
	return """
	SELECT d.FirstName || ' ' || d.LastName AS DoctorName,
	       COUNT(*) AS total_appointments,
	       COUNT(DISTINCT a.PatientID) AS distinct_patients
	FROM Doctors d
	JOIN Appointments a ON d.DoctorID = a.DoctorID
	GROUP BY d.DoctorID, DoctorName;
	"""

def query3():
	return """
	SELECT p.FirstName || ' ' || p.LastName AS PatientName,
	       COUNT(*) AS total_prescriptions,
	       SUM(pr.Price) AS total_cost
	FROM Patients p
	JOIN Appointments a ON p.PatientID = a.PatientID
	JOIN Prescriptions pr ON a.AppointmentID = pr.AppointmentID
	GROUP BY p.PatientID;
	"""
	
def query4():
	return """
	SELECT p.FirstName || ' ' || p.LastName AS PatientName,
	       doc.FirstName || ' ' || doc.LastName AS DoctorName,
	       v.DateTime AS vital_time,
	       v.Temperature,
	       dr.Name AS drug_name,
	       pr.Dosage
	FROM Vitals v
	JOIN Appointments a ON v.AppointmentID = a.AppointmentID
	JOIN Patients p ON a.PatientID = p.PatientID
	JOIN Doctors doc ON a.DoctorID = doc.DoctorID
	JOIN Prescriptions pr ON a.AppointmentID = pr.AppointmentID
	JOIN Drugs dr ON pr.DrugID = dr.ID;
	"""

def query5():
	return """
	SELECT p.FirstName || ' ' || p.LastName AS PatientName,
	       doc.FirstName || ' ' || doc.LastName AS DoctorName,
	       v.DateTime AS vital_time,
	       v.Temperature,
	       dr.Name AS drug_name,
	       pr.Dosage
	FROM Patients p
	LEFT JOIN Appointments a ON p.PatientID = a.PatientID
	LEFT JOIN Vitals v ON a.AppointmentID = v.AppointmentID
	LEFT JOIN Doctors doc ON a.DoctorID = doc.DoctorID
	LEFT JOIN Prescriptions pr ON a.AppointmentID = pr.AppointmentID
	LEFT JOIN Drugs dr ON pr.DrugID = dr.ID

	UNION ALL

	SELECT NULL AS PatientName,
	       d.FirstName || ' ' || d.LastName AS DoctorName,
	       NULL AS vital_time,
	       NULL AS Temperature,
	       NULL AS drug_name,
	       NULL AS Dosage
	FROM Doctors d
	WHERE d.DoctorID NOT IN (SELECT DISTINCT DoctorID FROM Appointments)

	UNION ALL

	SELECT NULL AS PatientName,
	       NULL AS DoctorName,
	       NULL AS vital_time,
	       NULL AS Temperature,
	       dr.Name AS drug_name,
	       NULL AS Dosage
	FROM Drugs dr
	WHERE dr.ID NOT IN (SELECT DISTINCT DrugID FROM Prescriptions);
	"""

def query6():
	return """
	SELECT p.FirstName || ' ' || p.LastName AS PatientName,
	       doc.FirstName || ' ' || doc.LastName AS DoctorName,
	       v.DateTime AS vital_time,
	       v.Temperature,
	       dr.Name AS drug_name,
	       pr.Dosage
	FROM Patients p
	LEFT JOIN Appointments a ON p.PatientID = a.PatientID
	LEFT JOIN Vitals v ON a.AppointmentID = v.AppointmentID
	LEFT JOIN Doctors doc ON a.DoctorID = doc.DoctorID
	LEFT JOIN Prescriptions pr ON a.AppointmentID = pr.AppointmentID
	LEFT JOIN Drugs dr ON pr.DrugID = dr.ID;
	"""

def query7():
	return """
	SELECT p1.FirstName || ' ' || p1.LastName AS Patient1,
	       p2.FirstName || ' ' || p2.LastName AS Patient2,
	       p1.City
	FROM Patients p1
	JOIN Patients p2 ON p1.City = p2.City AND p1.PatientID < p2.PatientID
	WHERE p1.City IS NOT NULL;
	"""

def query8():
	return """
	SELECT p.FirstName || ' ' || p.LastName AS Patient,
	       d.FirstName || ' ' || d.LastName AS Doctor,
	       p.Age AS Age,
	       a.AppointmentDateTime
	FROM Appointments a
	JOIN Patients p ON a.PatientID = p.PatientID
	JOIN Doctors d ON a.DoctorID = d.DoctorID
	WHERE p.Age = d.Age;
	"""

def query9():
	return """
	SELECT p.FirstName || ' ' || p.LastName AS PatientName,
	       AVG(v.Temperature) AS avg_temp,
	       COUNT(v.Temperature) AS temp_count
	FROM Patients p
	JOIN Appointments a ON p.PatientID = a.PatientID
	JOIN Vitals v ON a.AppointmentID = v.AppointmentID
	WHERE p.City = 'Springfield'
	GROUP BY p.PatientID
	HAVING COUNT(v.Temperature) >= 2;
	"""

def query10():
	return """
	SELECT d.Specialty,
	       COUNT(DISTINCT d.DoctorID) AS number_doctors,
	       COUNT(DISTINCT a.PatientID) AS number_patients,
	       COUNT(DISTINCT pr.DrugID) AS number_drugs
	FROM Doctors d
	LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
	LEFT JOIN Prescriptions pr ON a.AppointmentID = pr.AppointmentID
	GROUP BY d.Specialty;
	"""

def query11():
	return """
	SELECT p.City, p.ZipCode
	FROM Patients p
	WHERE NOT EXISTS (
	  SELECT 1 FROM Doctors d
	  WHERE d.City = p.City AND d.ZipCode = p.ZipCode
	)
	GROUP BY p.City, p.ZipCode;
	"""

def query12():
	return """
	SELECT 'diagonsis is Healthy' AS appointment_type, COUNT(*) AS appointments_count
	FROM Appointments
	WHERE Diagnosis LIKE '%Healthy%'

	UNION ALL

	SELECT 'reason is Checkup' AS appointment_type, COUNT(*) AS appointments_count
	FROM Appointments
	WHERE Reason LIKE '%Checkup%';
	"""

def query13():
	return """
	SELECT a.AppointmentID,
	       p.FirstName || ' ' || p.LastName AS PatientName,
	       d.FirstName || ' ' || d.LastName AS DoctorName
	FROM Appointments a
	JOIN Patients p ON a.PatientID = p.PatientID
	JOIN Doctors d ON a.DoctorID = d.DoctorID
	JOIN Prescriptions pr ON a.AppointmentID = pr.AppointmentID
	JOIN Drugs dr ON pr.DrugID = dr.ID
	GROUP BY a.AppointmentID
	HAVING SUM(CASE WHEN dr.Name = 'Ibuprofen' THEN 1 ELSE 0 END) > 0
	   AND SUM(CASE WHEN dr.Name = 'Amoxicillin' THEN 1 ELSE 0 END) > 0;
	"""

# Do not edit below

if __name__ == "__main__":
	try:
		if all(type(eval(f'print(t:=query{f+1}()),t')[1])==str for f in range(13)):
			print(f'Your submission is valid.')
		else:
			raise TypeError('Invalid Return Types.')
	except Exception as e:
		print(f'Your submission is invalid.\n{instr}\n{e}')
