/*
  Hello, World
  by Scott Kildall
  
  Writes "Hello, World" on the screen with some sort of color
*/

// Global variable for our font, which we create at startup
PFont f;

void setup() {
  size(1000, 600);
  textAlign(CENTER);

  // f is created here
  f = createFont("Helvetica",24,true); 
}

void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);
  
  // font and fill color
  textFont(f);       
  fill(0,255,128);
  
  text("Hello, World",width/2,200); 
}
