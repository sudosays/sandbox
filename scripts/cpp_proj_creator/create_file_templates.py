# Python script to create skeleton C++ pnroject
# Julius Stopforth
# 18.02.2016

# add os.exec for git repo initialisation
# add subprocess to change local git user info to preferred info

import subprocess
from string import Template
from datetime import date

# Formats given date as DD.MM.YYYY
def format_date(a_date):
	
	datestr = str(a_date.day).zfill(2) + '.'
	datestr += str(a_date.month).zfill(2) + '.'
	datestr += str(a_date.year).zfill(4)
	return datestr

def create_dir(dirname):
	try:
		subprocess.call(['mkdir', project_name])
	except SubprocessError:
		print('Failed')
		raise
		
def git_setup():
	subprocess.call(['git', 'init'])
	## Once the git repo has been created set the local user settings
	## This must be read from the given config file perhaps?
	subprocess.call(['git', 'config', '--local', 'user.name', 'Julius Stopforth'])
	subprocess.call(['git', 'config', '--local', 'user.email', 'stpjul004@myuct.ac.za'])	

if __name__ == "__main__":

	## Ask the user for the name of the project ##
	project_name = input('Please enter the name of the project:\n')


	## Create the project directory (parent) ##
	print('Attempting to create directory called ' + project_name + '.')
	create_dir(project_name)
	subprocess.call(['cd', project_name])
	create_dir('asldkfj')
	git_setup()

	default_author = 'Julius Stopforth'

	creation_date = format_date(date.today())

	main_stub = 'int main($param)\n{\n\t\n\treturn 0;\n}\n'

	base_dict = {'project_name': project_name, 'author': default_author, 'date': creation_date}

	makefile_dict = {}

	temp_file = open( 'source.template' )

	src = Template( temp_file.read())

	result = src.safe_substitute(base_dict)

	result += Template( main_stub ).safe_substitute({'param': 'void'})

	print( result )
