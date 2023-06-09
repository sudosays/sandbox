// Masking eye irises
// see: https://mathworld.wolfram.com/Circle-CircleIntersection.html
// use arcs then


boolean isDebug = false;
boolean staring = false;

ArrayList<Eye> eyes;

void setup() {

  size(640, 480);
  background(#e1e1e1);
  fill(#ff0000);
  stroke(#00ff00);
  strokeWeight(3);

  eyes = new ArrayList<>();

}

void drawCross(float x, float y, float r) {
  line(x+r, y, x-r, y);
  line(x, y+r, x, y-r);
}

void draw() {
  background(#e3e3e3);
  
  PVector mouse = new PVector(mouseX, mouseY);

  for (Eye eye : eyes) {
    eye.debug = isDebug;
    if (staring) {
      eye.stare();
    } else {
      eye.lookAt(mouse.x, mouse.y);
    }
    eye.show();
  }
}


void keyPressed() {
  switch (key) {

  case 'd':
    isDebug= !isDebug;
    break;
  case 's':
    staring = !staring;
    break;
   case 'o':
     for (Eye eye : eyes) {
       eye.outline = !eye.outline;
     }
  }
}

void mouseClicked() {
  eyes.add(new Eye(mouseX, mouseY,25));
  //eyes.add(new Eye(mouseX, mouseY, (int)random(10,25)));
}

class Eye {

  public PVector origin;
  private PVector target;

  public boolean debug = false;
  public boolean outline = true;

  public float irisSize = 10;

  public color scleraColor = #ffffff;
  public color irisColor = #000000;


  public Eye(float x, float y, int irisSize) {
    origin = new PVector(x, y);
    this.irisSize = irisSize;
  }

  public void lookAt(float x, float y) {
    target = new PVector(x, y);
  }

  public void stare() {
    target = new PVector(this.origin.x, this.origin.y);
  }
  
  public void show() {
       
    color outerColor = this.scleraColor;
    color innerColor = this.irisColor;

    if (this.debug) {
      noFill();
      stroke(#000000);
      strokeWeight(2);
    } else {
      fill(outerColor);
      if (outline) {
        stroke(innerColor);
      } else {
        stroke(outerColor);
      }
      strokeWeight(3);
    }

    //draw the outer eye/sclera
    ellipse(origin.x, origin.y, 3*irisSize, 2*irisSize);

    PVector vec = PVector.sub(target, origin);
    if (vec.mag() >= irisSize/2.0) {
      vec.normalize();
      vec = vec.mult(irisSize/2.0);
    }
    vec.add(origin);

    // Draw the iris
    if (!this.debug) {
      fill(innerColor);
      stroke(innerColor);
    }
    ellipse(vec.x, vec.y, irisSize, irisSize);

    // add crosses and lines
    if (this.debug) {
      ellipse(origin.x, origin.y, irisSize, irisSize);
      drawCross(origin.x, origin.y, 5);
      drawCross(target.x, target.y, 5);
      drawCross(vec.x, vec.y, 5);
      line(origin.x, origin.y, target.x, target.y);
    }
  }
  
  
}
