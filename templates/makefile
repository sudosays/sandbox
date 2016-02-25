## Driver makefile ##
## Author: Julius Stopforth ##
## Variable declaration ##
CC=g++
CFLAGS= -Wall -c
LFLAGS= -std=c++11 -I $(LIBDIR) $(LIBFLAGS) 
LIBFLAGS= -L $(LIBDIR) -lbrain_dead_factorial
TARGET= driver
OBJECTS= driver.o
SOURCES= driver.cpp

LIBDIR= ./factorial_library/


## Build the final executable binary
$(TARGET): $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LFLAGS)

## Build the object files if not yet present
$(OBJECTS): pre
	$(CC) $(CFLAGS) $(SOURCES) $(LFLAGS)

## Tell make that pre is not a file that needs to be created
.PHONY: pre

run:
	export LD_LIBRARY_PATH=./factorial_library/ && ./driver

## Make the shared library
pre:
	$(MAKE) -C $(LIBDIR)

## Remove all object and shared object files in the current directory
clean:
	$(RM) *.o *.so
