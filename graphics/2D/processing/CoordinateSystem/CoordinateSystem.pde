/*

This sketch is for creating an plotting shapes within a cartesian space onto the screen space.

It makes drawing graphs such as sin more intuitive instead of having to worry about aspect ratio etc etc.

*/



void setup() {

  size(640, 480);
  frameRate(60);

  background(#ffaaaa);
  stroke(#000000);
  noFill();
  
  println("Aspect ratio is: " + (1.0*width/float(height)));

}

// from coordinate/uv space to screen space
PVector toScreen(PVector vec) {
  float x = vec.x;
  float y = vec.y;
  float aspect = float(width)/float(height);

  y = ((y*-1.0)/2+0.5)*height;

  x = x/aspect;
  x = (x/2.0)+0.5;
  x = x*width;
  return new PVector(x, y);
}

// From screen/pixel space to coordinate space
PVector toUV(PVector vec) {
  float x = vec.x;
  float y = vec.y;
  float aspect = float(width)/float(height);

  y = y/height;
  y = (y-0.5)*2.0;
  y = y * -1.0;

  x = (x / width);
  x = (x-0.5)*2.0;
  x = x*aspect;

  return new PVector(x, y);
}

void drawGrid() {
  int tickSize = 2;

  PVector minPos = toUV(new PVector(0,0));
  PVector maxPos = toUV(new PVector(width, height));
  
  float ytick = (maxPos.y-minPos.y)/20;
  float xtick = (maxPos.x-minPos.x)/20;
  
  for (float x = minPos.x; x <= maxPos.x; x+= xtick) {
    PVector tickPos = toScreen(new PVector(x, 0));
    line(tickPos.x,tickPos.y-tickSize, tickPos.x, tickPos.y+tickSize);
  }
  
  for (float y = minPos.y; y <= maxPos.y; y+= ytick) {
    PVector tickPos = toScreen(new PVector(0, y));
    line(tickPos.x-tickSize, tickPos.y, tickPos.x+tickSize, tickPos.y);
  }
  
  
  line(0,height/2, width, height/2);
  line(width/2, 0, width/2, height);
}

void draw() {

  background(#000000);
  stroke(#ff3333);
  drawGrid();
  
  PVector uvPos = toUV(new PVector(mouseX, mouseY));
  fill(#ff3333);
  text(String.format("x: %.2f y: %.2f", uvPos.x, uvPos.y), mouseX, mouseY);
  
  noFill();
  PVector pos = toScreen(new PVector(0, 0));
  ellipse(pos.x, pos.y, 100, 100);
  
  PVector minPos = toUV(new PVector(0,0));
  PVector maxPos = toUV(new PVector(width, height));
  float xtick = (maxPos.x-minPos.x)/100;
  
  for (float x = minPos.x; x <= maxPos.x; x += xtick) {
    PVector coords = toScreen(new PVector(x, 0.5*sin(x+millis()/1000.0)));
    //fill(#0000ff);
    ellipse(coords.x, coords.y, 5,5);
    coords = toScreen(new PVector(x, 0.5*cos(x+millis()/1000.0)));
    //fill(#ff0000);
    ellipse(coords.x, coords.y, 5,5);
  }
  
}
