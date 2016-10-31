/**

Main file

Author: Julius Stopforth
Date: 25.10.2016

The following project was created by following the learnopengl.com tutorial

**/

#include "tutorial.h"

// This is necessary otherwise GLEW will be dynamically linked instead
#ifndef GLEW_STATIC
#define GLEW_STATIC
#endif
#include <GL/glew.h>

// GLFW lib
#include <GLFW/glfw3.h>

#include <iostream>
#include <fstream>

// Define vertex data
GLfloat verticies[] = 
{
    -0.5f, -0.5f, 0.0f,
     0.5f, -0.5f, 0.0f,
     0.0f,  0.5f, 0.0f,
};

// Unique vtcs for a rectangle
GLfloat rectVerts[] =
{
     0.5f,  0.5f, 0.0f, // Top Right
     0.5f, -0.5f, 0.0f, // Bottom Right
    -0.5f, -0.5f, 0.0f, // Bottom Left
    -0.5f,  0.5f, 0.0f  // Top Left
};

GLuint rectIndices[] = 
{

    0, 1, 3, // Triangle 1
    1, 2, 3  // Triangle 2

};


bool wireframeMode;


int main(void)
{
    
    wireframeMode = false;
    
    glfwInit();
    // Set opengl version to minimum 3.3 where <x>.<x> is <MAJOR>.<MINOR>
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    // As opposed to immediate profile (fixed funtion mode)
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);

    // Create the window object
    GLFWwindow* window = glfwCreateWindow(800, 600, "LearnOpenGL", nullptr, nullptr);
    if (window == nullptr)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    
    }
    glfwMakeContextCurrent(window);

    // Starting GLEW
    glewExperimental = GL_TRUE;
    if (glewInit() != GLEW_OK)
    {
    
        std::cout << "Failed to initialise GLEW" << std::endl;
        return -1;
    
    }

    // Get the window size info from GLFW
    int width, height;
    glfwGetFramebufferSize(window, &width, &height);

    // Tell OpenGL how big a window to render
    glViewport(0, 0, width, height);
    // glViewport(x, y, w, h) where x,y are coords of lower left corner of the window.

    // Registering the user defined key callback method
    glfwSetKeyCallback(window, key_callback);


    // OTHER INIT STUFF

    // Create/load vert and frag shaders
    GLuint vertexShader = loadShader("shader.vert", GL_VERTEX_SHADER);
    GLuint fragmentShader = loadShader("shader.frag", GL_FRAGMENT_SHADER);

    // Create a shader program to link the vert/frag shaders to
    GLuint shaderProgram;
    shaderProgram = glCreateProgram();

    // Attatch the two shaders to the program
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    
    // Link the shaders together in the final shader program
    glLinkProgram(shaderProgram);

    // Delete the shaders after linking
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    // Check for issues in shader linking (just like shader compilation)
    GLint successful;
    GLchar infoLog[512];
    glGetProgramiv(shaderProgram, GL_LINK_STATUS, &successful);
    if (!successful)
    { 
        glGetProgramInfoLog(shaderProgram, 512, NULL, infoLog);
        std::cout << "Error in linking shaders." << std::endl << infoLog << std::endl; 
    }

    // Tell OpenGL to render using the provided shader program
    // Can also be placed in game loop
    glUseProgram(shaderProgram);


    // Vertex Buffers init

    // Create a new vertex array object
    GLuint vertexArrayObject;
    glGenVertexArrays(1, &vertexArrayObject);

    // Bind the VAO so that VBO's can be linked
    glBindVertexArray(vertexArrayObject);

    // Create the needed vertex Buffer obj
    GLuint vertexBufferObject;
    glGenBuffers(1, &vertexBufferObject);
   
    // Create the Element Buffer Object
    GLuint elementBufferObject;
    glGenBuffers(1, &elementBufferObject);

    // Bind buffers to VAO
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
    // Insert the buffer data from our vertex array
    glBufferData(GL_ARRAY_BUFFER, sizeof(rectVerts), rectVerts, GL_STATIC_DRAW);
    
    // Fill EBO
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, elementBufferObject);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(rectIndices), rectIndices, GL_STATIC_DRAW);
    
    // Set the vertex attribute pointers
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*)0);
    // Enable the attrib pointer with id 0 that we just configd
    glEnableVertexAttribArray(0);

    // Unbind the vertexArrayObject
    glBindVertexArray(0);

    //Create a game loop
    while(!glfwWindowShouldClose(window)) // Waits until GLFW has been told to shutdown
    {
        // Checks for input events (possibly generic too) 
        // User defined callback methods are then called
        glfwPollEvents();

        // All rendering commands should go here, AND MUST be before the swap buffers
        glClearColor(0.2f,0.3f,0.3f,1.0f); // <- State setting function
        glClear(GL_COLOR_BUFFER_BIT);// <- state-using function

        // DRAW THE VAO TO THE BUFFER WITH THE SHADER PROG
        glUseProgram(shaderProgram);

        glBindVertexArray(vertexArrayObject);
   
        // Draw elements from EBO using indices
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

        // Use this when drawing vertex arrays
        // glDrawArrays(GL_TRIANGLES, 0, 3);
        
        glBindVertexArray(0);

        // Swaps in the new color buffer containint the color vals for each pixel in the GLFW window
        glfwSwapBuffers(window);
    
    }
    

    // Properly clean and release glfw data
    glfwTerminate();
    return 0;

}

// Mode is in case the user has any meta/super keys pressed
void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode)
{

    if(key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
    { glfwSetWindowShouldClose(window, GL_TRUE); }
    else if(key == GLFW_KEY_W && action == GLFW_PRESS)
    {
        if(wireframeMode)
        {
            // Set wireframe mode off
            glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        }
        else
        {
            // Turn on wireframe mode
            glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
        }

        wireframeMode = !wireframeMode;
    }

}

GLuint loadShader(std::string shaderName, GLenum shaderType)
{

    std::ifstream shaderFile(shaderName, std::ifstream::in);

    if (!shaderFile) 
    { 
        std::cout << "Error opening shader file: " << shaderName << std::endl; 
        return -1;
    }

    // Get file length
    shaderFile.seekg(0, shaderFile.end); // seekg sets the pos in the file
    int length = shaderFile.tellg(); // tellg provides the current pos in the file as int
    shaderFile.seekg(0, shaderFile.beg); // Move back to the start of the file in preparation for reading

    char* rawData = new char[length]; // Create a new string long enough to hold the file contents

    shaderFile.read(rawData, length); // Read all the data from the file

    // Check for any errors after reading
    if (shaderFile)
    { std::cout << "File read successfully" << std::endl; }
    else
    { std::cout << "Error while reading file. Only read " << shaderFile.gcount() << std::endl; }

    shaderFile.close();

    // Now that rawData contains the shader file data, create the shader
    GLuint newShader;
    newShader = glCreateShader(shaderType); // Where shader type is GL_[VERTEX/FRAGMENT]_SHADER

    // Attatch the source code for shader to compile
    glShaderSource(newShader, 1, &rawData, NULL);
    // glShaderSource (uint, sizei, char**, length)
    
    // COMPILE! \:D/
    glCompileShader(newShader);

    //Checking if shader compiled successfully
    GLint successful;
    GLchar infoLog[512];
    glGetShaderiv(newShader, GL_COMPILE_STATUS, &successful);
    if (!successful)
    { 
        glGetShaderInfoLog(newShader, 512, NULL, infoLog);
        std::cout << "Shader failed to compile successfully" << std::endl << infoLog << std::endl; 
    }
    else
    {
        std::cout << "Successfully compiled shader \"" << shaderName << "\"." << std::endl;
    }
    // Clean up mem alloc to rawData C string
    delete [] rawData;

    return newShader;

}
