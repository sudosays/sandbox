# Python script to create template files
# Julius Stopforth
# 18.02.2016

import sys
from string import Template
from datetime import date

# Formats given date as DD.MM.YYYY
def format_date(a_date):
	
	datestr = str(a_date.day).zfill(2) + "."
	datestr += str(a_date.month).zfill(2) + "."
	datestr += str(a_date.year).zfill(4)
	return datestr


project_name = sys.argv[1]

default_author = "Julius Stopforth"

creation_date = format_date(date.today())

template_dict = {'project_name': project_name, "author": default_author, "date": creation_date}

print(template_dict)


temp_file = open( 'file.template' )

src = Template( temp_file.read())

result = src.substitute(template_dict)

print( result )
