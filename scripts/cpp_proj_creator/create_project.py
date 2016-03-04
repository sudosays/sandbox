# Python script to create skeleton C++ pnroject
# Julius Stopforth
# 18.02.2016

# add os.exec for git repo initialisation
# add subprocess to change local git user info to preferred info

# ADD READING IN OF CONFIG FILE

import subprocess
import json
from string import Template
from datetime import date

# Variables used stored in a single dict

user_data = {}

def config():
	try:
		config_file = open( 'config.json' )
		# Decode the json file into the dict
		user_data = json.load(config_file)
		config_file.close()	
		user_data['date'] = format_date(date.today())
	except ValueError:
		print ("Error: Failed to load config file!")

# Formats given date as DD.MM.YYYY
def format_date(a_date):
	datestr = str(a_date.day).zfill(2) + '.'
	datestr += str(a_date.month).zfill(2) + '.'
	datestr += str(a_date.year).zfill(4)
	return datestr

def create_dir(dirname):
	try:
		subprocess.call(['mkdir', dirname])
	except SubprocessError:
		print('Error: directory creation failed!')
		raise
		
def git_setup():
	subprocess.call(['git', 'init'])
	## Once the git repo has been created set the local user settings
	## This must be read from the given config file perhaps?
	subprocess.call(['git', 'config', '--local', 'user.name', user_data['author']])
	subprocess.call(['git', 'config', '--local', 'user.email', user_data['email']])	

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

	MAIN_METHOD = 'int main($param)\n{\n\t\n\treturn 0;\n}\n'

	base_dict = {'project_name': project_name, 'author': default_author, 'date': creation_date}

	temp_file = open( 'source.template' )

	src = Template( temp_file.read())

	result = src.safe_substitute(base_dict)

	result += Template( main_stub ).safe_substitute({'param': 'void'})

	print( result )
