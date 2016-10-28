#version 330 core

// Versioning info always goes at the top
// Basic vertex shader created for learnopengl.com tutorial
// Author: Julius Stopforth

// in keyword specifies inputs to the shader program
// Layout is used to specifically set location of the input
layout (location = 0) in vec3 position;

void main()
{
    // Ouput of shader set by assigning glPosition variable    
    gl_Position = vec4(position.x, position.y, position.z, 1.0);

}
