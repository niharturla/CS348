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
	"""

def query2():
	return """
	"""

def query3():
	return """
	"""
	
def query4():
	return """
	"""

def query5():
	return """
	"""

def query6():
	return """
	"""

def query7():
	return """
	"""

def query8():
	return """
	"""

def query9():
	return """
	"""

def query10():
	return """
	"""

def query11():
	return """
	"""

def query12():
	return """
	"""

def query13():
	return """
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
