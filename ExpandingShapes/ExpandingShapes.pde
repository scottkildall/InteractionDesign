/*
  Expanding Shapes
  by Scott Kildall
  
  Expand and grow various shapes
*/


void setup() {
  size(1800, 1000);
  
  ellipseMode(CENTER);
}

void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);

  fill(255,0,0);
  ellipse( width/2, 100, 50, 70);
  
  fill(255,255,0);
  ellipse( width/2, 300, 50, 70);
  
  fill(0,255,0);
  ellipse( width/2, 500, 50, 70);
}
