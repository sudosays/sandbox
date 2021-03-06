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

MAIN_METHOD = 'int main($param)'

template_files = {'source':'source.template','header':'header.template','makefile':'makefile.template'}
template_data = {}

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

def gen_identifier(astr):
	newstr = astr.strip() # Remove whitespace
	newstr = newstr.upper()
	if ('.' in newstr):
		newstr = newstr.replace('.','_')
	else:
		newstr += '_H'
	return newstr
	
def load_templates():
	new_dict = {}
	for filename in template_files:
		temp_file = open( template_files[filename] )
		new_dict[filename] = temp_file.read()
		temp_file.close()
	return new_dict

def create_dir(dirname):
	try:
		subprocess.call(['mkdir', dirname])
	except SubprocessError:
		print('Error: directory creation failed!')
		raise

def create_file_from_template(filetype, filename, extension=''):
	raw = Template( template_data[filetype] )
	if (filetype == 'header'):
		user_data['header_identifier'] = gen_identifier(filename)
	
	user_data['filetype'] = filetype

	data = raw.safe_substitute(user_data)
	
	if (filename == 'driver'):
		if (filetype == 'source'):
			data += MAIN_METHOD + '\n{\n\t\n\treturn 0;\n}\n'
		elif (filetype == 'header'):
			data += MAIN_METHOD + ';\n\n#endif'
	elif (filetype == 'header'):
		data += '#endif'
	output = open(filename + extension, 'w')
	output.write(data)
	output.close()
	
	
def gen_files(files):
	# Keep track of files generated for makefile
	# Will later be used to generate $objects and $sources strings
	for filename in files:
		create_file_from_template('source', filename, '.cpp')
		create_file_from_template('header', filename, '.h')	
				
	files.append('')
	user_data['objects'] = '.o '.join(files).strip()
	user_data['sources'] = '.cpp '.join(files).strip() 	 
	
	create_file_from_template('makefile', 'makefile')	
	
def git_setup():
	# Initialise the repository
	subprocess.call(['git', 'init'])
	# Once the git repo has been created set the local user settings
	subprocess.call(['git', 'config', '--local', 'user.name', '"' + user_data['author'] + '"'])
	subprocess.call(['git', 'config', '--local', 'user.email', user_data['email']])	
	# Automate the initial commit
	# ENSURE FILES HAVE BEEN CREATED?	
	subprocess.call(['git','add','--all'])
	subprocess.call(['git', 'commit', '-m', 'Initial commit']) 
	

if __name__ == "__main__":

	# Load the user's info from the config file
	# Add a check if there is no config file
	user_data = config()
	
	template_data = load_templates()

	## Ask the user for the name of the project ##
	project_name = input('Please enter the name of the project:\n')

	print("Select main method parameters:\n1) argc, argv\n2) void")
	
	choice = eval(input("Enter choice:\n"))
	
	if choice == 1:
		MAIN_METHOD = MAIN_METHOD.replace('$param','int argc, char * argv[]')
	elif choice == 2:
		MAIN_METHOD = MAIN_METHOD.replace('$param','void')

	user_data['project_name'] = project_name

	class_name = input('Specify name of implementation class (default = ' + project_name + '):\n')

	if (class_name == ''):
		class_name = project_name

	# Create the project directory (parent) ##
	print('Attempting to create directory called ' + project_name + '.')
	create_dir(project_name)
	
	# Change into the newly created directory 
	print('Changing into directory ' + project_name + '.')
	chdir(project_name)
	
	# Files to generate:
	# - driver.cpp && driver.h
	# - sourcefile.cpp && source.h
	# - makefile incl. above files 	

	files = [class_name, 'driver']	
	print ('Creating files from templates.')
	gen_files(files)
	
	
	# Initialise the git repository
	print('Initialising git repository and making initial commit.')
#	git_setup()
	
	
