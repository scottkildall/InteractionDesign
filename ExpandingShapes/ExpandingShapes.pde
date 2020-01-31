/*
  Expanding Shapes
  by Scott Kildall
  
  Expand and grow various shapes. This will show a 
  traffic light-style pattern that will jitter and expand.
  The traffic lights will stay in the same vertical orientation
  from one another.
  
  This sketch will show principles of:
  (1) use of global variables
  (2) println() for debug messages
  (3) encapsulation through various functions
  (4) using randomness to make unpredicatable behavior
*/

// Ellipse parameters
int eWidth = 70;
int eHeight = 70;
color red = #FF0000;
color yellow = color(255,255,0);
color green = color(0,255,0);

// The y distance of the red stop light, which will jitter
float stopY = 200;

// the distance between each stop light
int stopDist = 200;

// the x position of each, which will change randomly
float redX, yellowX, greenX;

// grow = true, will expand the shapes horizontally, otherwise shrink them
boolean grow = true;

void setup() {
  size(1000, 800);
  ellipseMode(CENTER);
  
  // start with these centered 
  redX = width/2;
  greenX = width/2;
  yellowX = width/2;
}

void draw() {
  background(0);

  // draw stop light
  fill(red);
  ellipse( redX, stopY, eWidth, eHeight);
  
  fill(yellow);
  ellipse( yellowX, stopY + stopDist, eWidth, eHeight);
  
  fill(green);
  ellipse( greenX, stopY + (2*stopDist), eWidth, eHeight);
  
  // animate them in a creative way
  animateLights();
  jitter();
}

// we will grow to a max value, shrink to a minimum value
// use println() to show MIN or MAX reached
void animateLights() {
  if( grow )
   eWidth = eWidth + 3;
 else
   eWidth = eWidth - 1;
   
 // hit max, set grow to false  
 if( eWidth > 200 ) {
    grow = false;
    println("MAX Reached");
 }
 else if( eWidth < 30 ) {
    grow = true; 
    println("MIN Reached");
 }
}

// move the x of each one to a random range
// move the y of the group to a random range
void jitter() {
  redX = redX + random(-1,1);
  greenX = greenX + random(-10,10);
  yellowX = yellowX + random(-4,4);
  stopY = stopY + random(-10,10);
}
