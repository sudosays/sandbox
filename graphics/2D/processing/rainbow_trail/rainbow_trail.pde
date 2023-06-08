/** Getting bezier curves right requires the creation of a spline class that
can draw a bezier curve from a set of points.

See: https://en.wikipedia.org/wiki/Composite_B%C3%A9zier_curve 
**/
final int MAX_POINTS = 20;

ArrayList<PVector> trailPoints = new ArrayList<PVector>(MAX_POINTS);

color from = color(204, 102, 0);
color to = color(0, 102, 153);

enum LineMode {
  NORMAL,
    BEZIER,
    LEGACY
};

boolean start_new = true;

LineMode mode = LineMode.NORMAL;

void setup() {

  size(512, 512);
  background(0);
  stroke(255);
  strokeWeight(16);
  strokeJoin(ROUND);
}

void draw() {

  background(0);

  if (mousePressed) {
    
    if (start_new) {
      trailPoints.clear();
      start_new = false;
    }
    
    trailPoints.add(new PVector(mouseX, mouseY));
    while (trailPoints.size() > MAX_POINTS) {
      trailPoints.remove(0);
    }
  } else {
    start_new = true;
  }

  switch (mode) {

  case NORMAL:
    noFill();
    beginShape();
    for (int i = 0; i < trailPoints.size(); i++) {
      curveVertex(trailPoints.get(i).x, trailPoints.get(i).y);
    }
    endShape();
    break;


  case LEGACY:
    for (int i = 0; i < trailPoints.size(); i++) {
      stroke(lerpColor(from, to, float( i)/trailPoints.size()));
      fill(lerpColor(from, to, float(i)/trailPoints.size()));
      ellipse(trailPoints.get(i).x, trailPoints.get(i).y, 10, 10);
    }

  case BEZIER:
    {
      if (trailPoints.size() >=4) {
        noFill();
        beginShape();
        vertex(trailPoints.get(0).x, trailPoints.get(0).y);
        for (int i = 1; i < trailPoints.size()-3; i+=3) {
          PVector endAnchor = trailPoints.get(i+2);
          PVector control1 = trailPoints.get(i);
          PVector control2 = trailPoints.get(i+1);
          stroke(lerpColor(from, to, float( i)/trailPoints.size()));
          bezierVertex(
            control1.x, control1.y,
            control2.x, control2.y,
            endAnchor.x, endAnchor.y
            );
        }
        endShape();
      }
    }
  }
}
