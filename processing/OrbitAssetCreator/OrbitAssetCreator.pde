
// Colors
color shaderPink = #ff2a94;
color white = #ffffff;
color black = #000000;

color azure = #007FFF;
color gray = #a5adb0;
color deepSpaceBlue = #0d1438;

star[] galaxy = new star[400];

planet moon = new planet();

boolean isDev = true;

void setup()
{

  size(512,512);
  background((isDev) ? shaderPink : deepSpaceBlue);
  noSmooth();
  if (isDev) {
    noLoop();
  }
  frameRate(480);
  
  //Create the stars
  createStars();
  
  moon.pos = new PVector(128,128);
  moon.col = gray;
  
}

void draw()
{

  background((isDev) ? shaderPink : deepSpaceBlue);
  
  if (!isDev) {
  // Draw the orbit line
  strokeWeight(4);
  stroke(white);
  fill(deepSpaceBlue);
  ellipse(256,256,380, 380);
  
  // Draw the stars
  strokeWeight(1);
  for (int i=0; i < 400; i++)
  {
    int starshine = lerpColor(white, azure, random(1));
    galaxy[i].col = starshine;
    galaxy[i].draw();
  }
  
    
  // Create a little moon
  moon.draw();
  
  }
  
  // Setup brush for planetary sketching
  stroke(white);
  fill(azure);

  // Create a blue geoid shape.
  ellipse(256,256,256,256);

  
  //save("planet-###.png");

}

class star
{
  
  PVector pos;
  color col;
  
  void draw()
  {
    stroke(col);
    fill(col);
    rect(pos.x,pos.y,2,2);
  }

}

class planet
{
  
  float orbitalprog = -1;
  PVector pos;
  color col;
  
  void draw()
  {
    stroke(white);
    fill(col);
    ellipse(pos.x,pos.y,64,64);
    update();
  }
  
  void update()
  {
    
    orbitalprog += 0.001;
    pos.x = 256+190*cos(orbitalprog);
    pos.y = 256+190*sin(orbitalprog);
    
  }

}


void keyPressed()
{

  createStars();

}

void createStars()
{

    for (int i=0; i < 400; i++)
  {
    int starshine = lerpColor(white, azure, random(1));
    galaxy[i] = new star();
    galaxy[i].col = starshine;
    galaxy[i].pos = new PVector(random(512), random(512));
  }

}