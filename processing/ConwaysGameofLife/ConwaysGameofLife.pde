/**
* Conway's Game of Life "game" visualiser
* Author: Julius Stopforth
* Date: 08.03.2016
**/

// 0 means empty 1 means alive
byte[][] grid = new byte[10][10];


void setup ()
{
  size(400,400);
  
  // General debug/testing seed
  grid[5][3] = 1;
  grid[5][6] = 1;

}

void draw()
{
  background(255);

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
  
  
  byte[][] newgrid = new byte [10][10];
  
  for (int i=0; i < oldgrid.length; i++)
  {
    
    for (int j=0; < oldgrid[i].length; i++)
    {
    
    }
   
  }
  
  return null;
}

int find_neighbours(byte[][] grid, int posx, int posy)
{
  if ((posx >= grid[0].length || posx < 0)||
  (posy >= grid.length || posy < 0))
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


}