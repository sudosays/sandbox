void setup()
{

  size(512,512);
  background(#ffffff);
  stroke(#000000);
  fill(#000000);
  
}

void draw()
{

 if (mousePressed)
 {
   float size = random(16,64);
   
   ellipse(mouseX, mouseY, size,size);
   ellipse(width-mouseX, mouseY,size,size);
   
 }
  
}

void keyPressed()
{
 
  background(#ffffff);

}