# Python script to create template files
# Julius Stopforth
# 18.02.2016


# add os.exec for git repo initialisation
# use os.exec for dir creation etc

import subprocess
from string import Template
from datetime import date

# Formats given date as DD.MM.YYYY
def format_date(a_date):
	
	datestr = str(a_date.day).zfill(2) + '.'
	datestr += str(a_date.month).zfill(2) + '.'
	datestr += str(a_date.year).zfill(4)
	return datestr

## Ask the user for the name of the project ##
project_name = input('Please enter the name of the project:\n')


## Create the project directory ##
print('Attempting to create directory called ' + project_name + '.')

try:
	subprocess.call(['mkdir', project_name])
	print('Success')
except SubprocessError:
	print('Failed')
	raise
	
	
	


default_author = 'Julius Stopforth'

creation_date = format_date(date.today())

base_dict = {'project_name': project_name, 'author': default_author, 'date': creation_date}

makefile_dict = {}

temp_file = open( 'file.template' )

src = Template( temp_file.read())

result = src.substitute(template_dict)

print( result )
