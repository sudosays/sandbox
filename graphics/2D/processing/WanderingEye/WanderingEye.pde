





void setup() {

  size(640, 480);
  background(#e3e3e3);
  fill(#ff0000);
  stroke(#00ff00);
  strokeWeight(3);
}

void drawCross(float x, float y, float r) {
  line(x+r, y, x-r, y);
  line(x, y+r, x, y-r);
}

void draw() {
  
  PVector origin = new PVector(width/2, height/2);
  PVector mouse = new PVector(mouseX, mouseY);
  
  background(#e3e3e3);
  fill(#ff0000);
  stroke(#00ff00);
  strokeWeight(3);

  //draw the bounding circle for the iris
  stroke(#ffffff);
  fill(#ff0000);
  ellipse(origin.x, origin.y, 150, 100);

  //draw the iris/pupil at center coordinates
  //ellipse(origin.x, origin.y, 50, 50);

  stroke(#000000);
  //line(origin.x, origin.y, mouse.x, mouse.y);

  //stroke(#ffffff);
  // draw crosshairs
  //drawCross( origin.x, origin.y, 5);
  drawCross(mouse.x, mouse.y, 5);

  //debug text
  fill(#ffffff);
  noStroke();
  rect(mouse.x+2, mouse.y-2, 102, -38);

  fill(#ff0000);
  String info = String.format("distance: %.2f", origin.dist(mouse));
  text(info, mouse.x+5, mouse.y-5,100,-36);
  
  PVector vec = PVector.sub(mouse, origin);
  vec.normalize();
  
  vec = vec.mult(25.0);

  vec.add(origin);
   println(vec);
  stroke(#00ff00);
  strokeWeight(3);

  drawCross(vec.x,vec.y,5);
  noFill();
  ellipse(vec.x,vec.y,50,50);
  
  
  

}
