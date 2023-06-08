final int VIEWWIDTH = 800;
final int VIEWHEIGHT = 480;
final int PIXELSIZE = 6;
final int SCREENWIDTH = 84*PIXELSIZE; 
final int SCREENHEIGHT = 48*PIXELSIZE; 

int XOFFSET;
int YOFFSET = 75;

final color BGFILL = color(36,204,68);
final color GRIDCOL = color(100,100,100);

boolean showGrid = false;

byte[] vidMem;

void setup() {

  size(800, 600);
  
  XOFFSET = (width-SCREENWIDTH)/2;
  
  background(255);
  vidMem = new byte[504];
}

void draw() {

  if (mousePressed) {
    PVector screenPos = mouseToScreenPos();
    if (screenPos.x >= 0 && screenPos.y >= 0) {
      setBit((int)screenPos.x, (int)screenPos.y);

    }
  }
  drawDataToScreen();

}

void keyPressed() {
  if (key == 'c') {
    vidMem = new byte[504];
  }
  
  if (key == 'g') {
    showGrid = !showGrid;
  }
  
  if (key == 's') {
    PImage shot = screenshot();
    image(shot, XOFFSET, 500);
    selectOutput("Select a file to save", "savePngScreenshot");
  }
  
  if (key == 'q') {
    exit();
  }
}

/*=================================

UTILITY FUNCTIONS

===================================*/

void savePngScreenshot(File output) {
  if (output != null) {
    screenshot().save(output.getAbsolutePath());
  }
}

/*Draw the image on screen into a 84*48 pixel png image */
PImage screenshot() {
  boolean[] bits = bytesToBooleans(vidMem);
  PImage output = createImage(84, 48, RGB);
  output.loadPixels();
  for (int i = 0; i < output.pixels.length; i++) {
    output.pixels[i] = (bits[bits.length-1-i]?color(0):BGFILL);
  }
  output.updatePixels();
  return output;
}

PVector mouseToScreenPos() {
  int screenX = (mouseX-XOFFSET)/PIXELSIZE;
  int screenY = (mouseY-YOFFSET)/PIXELSIZE;
  if (screenX < 0 || screenX > 83) {
    screenX = -1;
  }
  
  if (screenY < 0 || screenY > 47) {
    screenY = -1;
  }
  
  return new PVector(screenX,screenY);
}

/* Set a bit at x,y to 1 in vidMem

  x in [0;83]
  y in [0;47]
*/ 
void setBit(int x, int y) {
  int position = y*84+x; // 0..4031
  byte shift = (byte)(position % 8);
  int byteIdx = (position - shift)/8;
  byte setBit =  (byte) (1  << (7-shift)); // endianess!
  vidMem[byteIdx] |= setBit;
}

/* Using Bresenham's Line Drawing ALogrithm
   https://en.wikipedia.org/wiki/Bresenham's_line_algorithm
   
   FIXME: Issue with drawing when slope is negative
*/
void drawLine(int x0, int y0, int x1, int y1) {
  
  // Force the gradient to always be positive
  int startX = (x0<x1?x0:x1);
  int endX = (x1>x0?x1:x0);
  int startY = (y0<y1?y0:y1);
  int endY = (y1>y0?y1:y0);
  
  int dx = endX-startX;
  int dy = endY-startY;
  int D = 2*dy - dx;
  int y = startY;
  
  for(int x = startX; x < endX; x++) {
    setBit(x,y);
    if (D > 0) {
      y = y + 1;
      D = D - 2*dx;
    }
    
    D = D + 2*dy;
  }
 

}




void drawDataToScreen() {
  if (showGrid) {
    stroke(GRIDCOL);
  } else {
    stroke(BGFILL);
  }
  // flatten vidMem into bitarray
  boolean[] bits = bytesToBooleans(vidMem);
  for (int i=0; i<84; i++) {
    for (int j=0; j<48; j++) {
      if (bits[(bits.length-1)-(j*84+i)]) {
        fill(0);
      } else {
        fill(BGFILL);
      }
      rect(XOFFSET+i*PIXELSIZE, YOFFSET+j*PIXELSIZE, PIXELSIZE, PIXELSIZE);
    }
  }
}



// Utility function from 
// http://www.java2s.com/example/java-utility-method/byte-array-to-boolean/bytestobooleans-byte-bytes-bd06b.html
boolean[] bytesToBooleans(byte[] bytes) {
  int tempValue = 0;
  boolean[] booleans = new boolean[bytes.length * 8];

  // Build FLAGS register
  for (int b = bytes.length - 1; b >= 0; b--) {
    for (int j = 0; j < 8; j++) {
      // Convert flag into boolean
      tempValue = (bytes[b] >> j) & 0x01;
      if (tempValue == 1) {
        booleans[((bytes.length - 1 - b) * 8) + j] = true;
      } else {
        booleans[((bytes.length - 1 - b) * 8) + j] = false;
      }
    }
  }
  return booleans;
}
