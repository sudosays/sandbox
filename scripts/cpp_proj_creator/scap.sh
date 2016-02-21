#!/bin/bash

echo "Please specify a name for the project (lowercase):"

read proj_name

##echo "The specified proj name is: $proj_name"

# todo mkdir in current directory
# ^ maybe check if in correct directory?

# Check if directory exists


echo "Making directory called '$proj_name'"
mkdir $proj_name

cd $proj_name

python3 ../create_file_templates.py $proj_name
