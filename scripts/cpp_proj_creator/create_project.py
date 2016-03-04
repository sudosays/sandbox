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

# WARNING POSSIBLE LOOMING DEPRECATION
from os import chdir 

# Variables used stored in a single dict

user_data = {}
MAIN_METHOD = 'int main($param)\n{\n\t\n\treturn 0;\n}\n'

def config():
	try:
		config_file = open( 'config.json' )
		# Decode the json file into the dict
		data = json.load(config_file)
		config_file.close()	
		data['date'] = format_date(date.today())
		return data;
	except ValueError:
		print ("Error: Failed to load config file!")
		return NULL;		

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
	subprocess.call(['git', 'config', '--local', 'user.name', '"' + user_data['author'] + '"'])
	subprocess.call(['git', 'config', '--local', 'user.email', user_data['email']])	

if __name__ == "__main__":

	# Load the user's info from the config file
	# Add a check if there is no config file
	user_data = config()

	## Ask the user for the name of the project ##
	project_name = input('Please enter the name of the project:\n')


	## Create the project directory (parent) ##
	print('Attempting to create directory called ' + project_name + '.')
	create_dir(project_name)
	chdir(project_name)
	git_setup()
