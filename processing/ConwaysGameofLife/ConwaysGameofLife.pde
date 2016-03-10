/**
* Conway's Game of Life "game" visualiser
* Author: Julius Stopforth
* Date: 08.03.2016
**/

// 0 means empty 1 means alive
byte[][] grid = new byte[100][100];


void setup ()
{
  frameRate(10);
  size(400,400);
  
  //noLoop();
  noStroke();
  
  // General debug/testing seed (Glider)
  grid[4][4] = 1;
  grid[5][5] = 1;
  grid[5][6] = 1;
  grid[4][6] = 1;
  grid[3][6] = 1;
  
  /*
  {0,0,1}
  {1,0,1}
  {0,1,1}
  */

}

void draw()
{
  background(255);
  grid = update_grid(grid);
  println("Starting to draw");
  draw_grid(grid);
}

byte[][] update_grid(byte[][] oldgrid)
{
  /**
  * ---Rules for updating---
  * For any cell x where number of live neighbours is N:
  * 1. x = 0  if x = 1 && N < 2
  * 2. x = 1  if x = 1 && N e {2,3}
  * 3. x = 0  if x = 1 && N > 3
  * 4. x = 1  if x = 0 && N = 3
  */
  
  byte[][] newgrid = new byte [100][100];
  
  for (int i=0; i < oldgrid.length; i++)
  {
    String row = "";
    for (int j=0; j < oldgrid[i].length; j++)
    {
      row += oldgrid[i][j] + ", ";
      
      int N = find_neighbours(oldgrid, j, i);
      
      if (N < 0)
      {
        println("Error occurred updating grid!");
        return null;
      }
      
      if (oldgrid[i][j] > 0)
      {
        if ( N < 2 || N > 3) { newgrid[i][j] = 0; }
        else { newgrid[i][j] = 1;}
      }
      else if (oldgrid[i][j] == 0)
      {
        if (N == 3) { newgrid[i][j] = 1; }
      }
      
    }
    println(row);
   
  }
  
  println("Completed update!");
  return newgrid;
}

int find_neighbours(byte[][] agrid, int posx, int posy)
{
  if ((posx >= agrid[0].length || posx < 0)||
  (posy >= agrid.length || posy < 0))
  {
    println("Error: Position of x:", posx, " y:", posy, " is outside the grid!");
    return -1;
  }
  
  /**
  * Cardinal directions to check are:
  *
  * (-1,-1) ( 0,-1) (+1,-1)
  *        \   |   /
  * (-1, 0)-( x,y )-(+1, 0)
  *        /   |   \
  * (-1,+1) ( 0,+1) (+1,+1)
  **/
  
  int num = 0;
  
  for (int y= -1; y <= 1; y++)
  {
    // If the y value is out of bounds then the posistion is right at the top or bottom border of the grid
    if ((posy + y) >= agrid.length || (posy + y) < 0 ) { continue; }
    

    
    for (int x = -1; x <=1; x++)
    {
      //println("X:", x, " XPOS:", posx, " Y:", y, " YPOS:", posy );
      // If the x value is out of bounds skip it
      if ((posx + x) >= agrid[posy].length || (posx + x) < 0 ) { continue; }
      
      if (agrid[posy+y][posx+x] > 0 && !(x==0 && y==0)) { num++; }
    
    }
  }
  
  return num;

}

void draw_grid(byte[][] agrid)
{
  println("In the draw function!");
  float colwidth = width/(float)agrid[0].length;
  float rowheight = height/(float)agrid.length;

  for(int i=0; i < agrid.length; i++)
  {
    for(int j=0; j < agrid[i].length; j++)
    {
      if (agrid[i][j] == 0) { continue; }
      float xpos = j*colwidth;
      float ypos = i*rowheight;
      
      println("drawing!");
      

      fill(0);
      ellipse(xpos, ypos, colwidth, rowheight );
    }

  }

}