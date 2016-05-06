# Basic C++ makefile
# Author: Julius Stopforth

## Variable declaration ##
CC=g++
CFLAGS= -Wall -c

#-I $(LIBDIR) $(LIBFLAGS) 
LFLAGS= -std=c++11 
LIBFLAGS= -L $(LIBDIR) 
TARGET= 
OBJECTS= 
SOURCES=
LIBDIR= 

## DEBUG INFO

## Build the final executable binary
$(TARGET): $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LFLAGS)

## Build the object files if not yet present
$(OBJECTS): pre
	$(CC) $(CFLAGS) $(SOURCES) $(LFLAGS)

## Tell make that pre is not a file that needs to be created
.PHONY: pre

run:
	@ echo "**Executing program: " $(TARGET) "**"
	@ read -p "Enter args: " args;\
	./$(TARGET) $$args;
	@ echo "**Finished makefile program execution**"

## Run these commands before compiling the source code ##
pre:
#	$(MAKE) -C $(LIBDIR)

## Remove all object and shared object files in the current directory
clean:
	@ $(RM) *.o *.so
	@ $(RM) $(TARGET)
	@echo "Removed all binary and object files"
