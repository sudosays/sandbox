
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
  strokeWeight(3);
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
  strokeWeight(4);
  fill(azure);

  //ellipse(256,256,508,508);


  // Create a blue geoid shape.
  for (int i = 0; i < 5; ++i)
  {
      if (i > 0) {strokeWeight(1);}
      ellipse(256,256,508-(100*i),508);
  
  }
  
  line(256,0,256,508);


  
  //save("planet-"+random(0,100) +".png");

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
  int radius = 64;
  
  void draw()
  {
    stroke(white);
    fill(col);
    ellipse(pos.x,pos.y,radius*2,radius*2);
    update();
  }
  
  void update()
  {
    
    orbitalprog += 0.001;
    pos.x = ((int)width/2)+190*cos(orbitalprog);
    pos.y = ((int)height/2)+190*sin(orbitalprog);
    
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