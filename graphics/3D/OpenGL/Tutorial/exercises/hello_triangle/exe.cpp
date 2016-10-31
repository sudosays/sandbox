/**

Main file

Author: Julius Stopforth
Date: 25.10.2016

The following project was created by following the learnopengl.com tutorial

**/

#include "exe.h"

// This is necessary otherwise GLEW will be dynamically linked instead
#ifndef GLEW_STATIC
#define GLEW_STATIC
#endif
#include <GL/glew.h>

// GLFW lib
#include <GLFW/glfw3.h>

#include <iostream>
#include <fstream>

/*-- Exercise 1 --//
// Vertex Data //
GLfloat vertices[] = 
{
     -1.0f, -0.5f, 0.0f,
      0.0f, -0.5f, 0.0f,
     -0.5f,  0.5f, 0.0f,
      0.0f,  0.5f, 0.0f,
      1.0f,  0.5f, 0.0f,
      0.5f, -0.5f, 0.0f

};
//-- --*/

//-- Exercise 2 --//
// Triangle Vertex Data //
GLfloat triangle1[] = 
{
     -1.0f, -0.5f, 0.0f,
      0.0f, -0.5f, 0.0f,
     -0.5f,  0.5f, 0.0f
};

GLfloat triangle2[] =
{
      0.0f,  0.5f, 0.0f,
      1.0f,  0.5f, 0.0f,
      0.5f, -0.5f, 0.0f
};
//-- --*/

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
    GLuint orangeFragShader = loadShader("orange.frag", GL_FRAGMENT_SHADER);
    GLuint yellowFragShader = loadShader("yellow.frag", GL_FRAGMENT_SHADER);

    // Create a shader program to link the vert/frag shaders to
    GLuint orangeShader, yellowShader;
    orangeShader = glCreateProgram();

    // Attatch the two shaders to the program
    glAttachShader(orangeShader, vertexShader);
    glAttachShader(orangeShader, orangeFragShader);
    
    // Link the shaders together in the final shader program
    glLinkProgram(orangeShader);

    yellowShader = glCreateProgram();
    glAttachShader(yellowShader, vertexShader);
    glAttachShader(yellowShader, yellowFragShader);

    glLinkProgram(yellowShader);

    // Delete the shaders after linking
    glDeleteShader(vertexShader);
    glDeleteShader(orangeFragShader);
    glDeleteShader(yellowFragShader);

    // Check for issues in shader linking (just like shader compilation)
    GLint successful;
    GLchar infoLog[512];
    glGetProgramiv(orangeShader, GL_LINK_STATUS, &successful);
    if (!successful)
    { 
        glGetProgramInfoLog(orangeShader, 512, NULL, infoLog);
        std::cout << "Error in linking shaders." << std::endl << infoLog << std::endl; 
    }
    // Check for issues in shader linking (just like shader compilation)
    glGetProgramiv(yellowShader, GL_LINK_STATUS, &successful);
    if (!successful)
    { 
        glGetProgramInfoLog(yellowShader, 512, NULL, infoLog);
        std::cout << "Error in linking shaders." << std::endl << infoLog << std::endl; 
    }


    // Tell OpenGL to render using the provided shader program
    // Can also be placed in game loop
    glUseProgram(orangeShader);

    // Vertex Buffers init

    /*-- Exercise 1 --//
    GLuint vertexArrayObject;
    glGenVertexArrays(1, &vertexArrayObject);

    glBindVertexArray(vertexArrayObject);

    GLuint vertexBufferObject;
    glGenBuffers(1, &vertexBufferObject);

    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
   
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*)0);
    glEnableVertexAttribArray(0);

    glBindVertexArray(0);
    //-- --*/
   

    //-- Exercise 2 --//
    GLuint VAOs[2], VBOs[2]; // Create two separate VAOs
    glGenVertexArrays(2, VAOs);
    glGenBuffers(2, VBOs);

    // Link up the first VAO
    glBindVertexArray(VAOs[0]);

    glBindBuffer(GL_ARRAY_BUFFER, VBOs[0]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(triangle1), triangle1, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*) 0);
    glEnableVertexAttribArray(0);

    glBindVertexArray(VAOs[1]);

    glBindBuffer(GL_ARRAY_BUFFER, VBOs[1]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(triangle2), triangle2, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*) 0); // This may break
    glEnableVertexAttribArray(0);

    glBindVertexArray(0);
    //-- --*/
   
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
        glUseProgram(orangeShader);

        /*-- Exercise 1 --|
        glBindVertexArray(vertexArrayObject);
        glDrawArrays(GL_TRIANGLES, 0, 6);
        //-- --*/
        
        //-- Exercise 2 & 3 --//
        glBindVertexArray(VAOs[0]);
        glDrawArrays(GL_TRIANGLES, 0, 3);

        //-- Exercise 3 --//
        glUseProgram(yellowShader);

        glBindVertexArray(VAOs[1]);
        glDrawArrays(GL_TRIANGLES, 0, 3);

        glBindVertexArray(0);
        //-- --//


        // Swaps in the new color buffer containint the color vals for each pixel in the GLFW window
        glfwSwapBuffers(window);
    
    }

    glDeleteVertexArrays(2, VAOs);
    glDeleteBuffers(2, VBOs);

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
