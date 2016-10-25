## Driver makefile ##
## Author: Julius Stopforth ##
## Variable declaration ##
CC=g++
CFLAGS= -Wall -c
LFLAGS= -std=c++11 
LIBFLAGS=-L$(LIBDIR) -lGL -lglfw -lGLEW
TARGET=tutorial 
OBJECTS=tutorial.o
SOURCES=tutorial.cpp

LIBDIR=/libs

## Build the final executable binary
$(TARGET): $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LFLAGS)

## Build the object files if not yet present
$(OBJECTS): pre
	$(CC) $(CFLAGS) $(SOURCES) $(LFLAGS) $(LIBFLAGS)

## Tell make that pre is not a file that needs to be created
.PHONY: pre

run:
	./$(TARGET)

## Make any prerequisites
##$(MAKE) -C $(LIBDIR)
pre:

## Remove all object and shared object files in the current directory
clean:
	$(RM) *.o *.so $(TARGET)
