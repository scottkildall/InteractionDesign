/*
  Ball Loop
  by Scott Kildall
  
  Draws various circles (balls) on the screen and animates them in various ways,
  using for loops and user input
*/

// Global variable for our font, which we create at startup
int ballDiameter = 50;

// This is a font that we will use for debugging
PFont f;

void setup() {
  size(1000, 600);
  
  // Center text and shapes
  textAlign(CENTER);
  ellipseMode(CENTER);

  // f is created here
  f = createFont("Helvetica",24,true); 
}

void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);
  
  // draw one red ball on the screen
  fill(255,0,0);
  ellipse(width/2, height/2, ballDiameter, ballDiameter ); 
}
