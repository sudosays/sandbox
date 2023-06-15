

final float PHI = 1.618033;


void setup() {


  size(640, 480);

  background(#ffffff);
  stroke(#000000);
  noFill();


  float theta = 0;
  for (int i = 0; i < 30; i++) {
    float r = pow(PHI, 2*theta/PI);
    arc(width/2, height/2, r,r,theta, theta+QUARTER_PI);
    theta = theta+QUARTER_PI;
  }
}

void draw() {

  background(#ffffff);
  stroke(#000000);
  //noFill();
  //fill(#e3e3e3);
  
  
  float theta = (0-millis()/1000.0)%HALF_PI;
  for (int i = 0; i < 30; i++) {
    float r = pow(PHI, 2*theta/PI);
    arc(width/2, height/2, r,r,theta, theta+QUARTER_PI);
    theta = theta+QUARTER_PI;
  }

}
