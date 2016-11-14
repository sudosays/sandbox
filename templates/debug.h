/** 
* Basic debugging macro
* NOTE: requires <iostream> from stdlib
* Author: Julius Stopforth
**/
#ifdef DEBUG
#define LOG(x) std::cout << x << std::endl;
#else
#define LOG(x) 
#endif
