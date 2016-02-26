## Driver makefile ##
## Author: Julius Stopforth ##
## Variable declaration ##
CC=g++
CFLAGS= -Wall -c
LFLAGS= -std=c++11 
LIBFLAGS= -L $(LIBDIR)
TARGET= 
OBJECTS= 
SOURCES= 

LIBDIR= 

## Build the final executable binary
$(TARGET): $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LFLAGS)

## Build the object files if not yet present
$(OBJECTS): pre
	$(CC) $(CFLAGS) $(SOURCES) $(LFLAGS)

## Tell make that pre is not a file that needs to be created
.PHONY: pre

run:
	./$(TARGET)

## Make any prerequisites
pre:
	#$(MAKE) -C $(LIBDIR)

## Remove all object and shared object files in the current directory
clean:
	$(RM) *.o *.so
