#version 330 core

// Versioning info always goes at the top
// Basic fragment shader created for learnopengl.com tutorial
// Author: Julius Stopforth

// No inputs yet, just specifies the color of each fragment
out vec4 color;

void main(void)
{
    // Color is specified as RGBA with floats from 0-1 
    color = vec4(1.0f, 0.5f, 0.2f, 1.0f);

}
