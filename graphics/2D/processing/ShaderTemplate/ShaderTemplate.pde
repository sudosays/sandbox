PShader myShader;

void setup() {
  size(640,480, P2D);
  noStroke();
  
  myShader = loadShader("shader.glsl");
  myShader.set("resolution",float(width),float(height));
}


void draw() {
  myShader.set("time", millis() / 500.0);  
  shader(myShader); 
  rect(0, 0, width, height);
  if (keyPressed) {
    myShader = loadShader("shader.glsl");
    myShader.set("resolution",float(width),float(height));
  }
}
