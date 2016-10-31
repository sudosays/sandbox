/**

Main file

Author: Julius Stopforth
Date: 25.10.2016

The following project was created by following the learnopengl.com tutorial

**/

#ifndef TUTORIAL
#define TUTORIAL

// This is necessary otherwise GLEW will be dynamically linked instead
#ifndef GLEW_STATIC
#define GLEW_STATIC
#endif

#include <GL/glew.h>

// GLFW lib
#include <GLFW/glfw3.h>

#include <string>

int main(void);

void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode);

GLuint loadShader(std::string shaderName, GLenum shaderType);  

#endif
