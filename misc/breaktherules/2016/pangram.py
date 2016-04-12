# Pangram verifier
# Created to apply for #BreaktheRules 2016
# Author: Julius Stopforth
# Date: 12.04.2016


def pangram_check(aString):
	alphabet = "abcdefghijklmnopqrstuvwxyz"
	
	aString = aString.lower()
	
	tempstr = ""

	for letter in aString:
		if ((letter not in tempstr) and (letter in alphabet) ):
			tempstr += letter
	tempstr = ''.join(sorted(tempstr))
	print(tempstr)
	return (alphabet == tempstr)
