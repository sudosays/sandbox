/* 
* Virtual library system
* Author: Julius Stopforth
* Date: 18.02.2016
**/

#include <iostream>
#include "mylibrary.h"

using namespace std;

int main(void)
{
	char aString[30];	

	cout << "Please enter a string: ";

	cin >> aString;
	
	cout << "The string was: " << endl;

	cout << aString << endl;		
	
	book aBook;
	//aBook.author = "Card, Orson Scott";
	//aBook.title = "Ender's Game";	
	//aBook.code = 1;	

	return 0;

}
