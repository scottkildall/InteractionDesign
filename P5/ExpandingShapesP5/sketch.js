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
var eWidth = 70;
var eHeight = 70;
var red;
var yellow;
var green;

// The y distance of the red stop light, which will jitter
var stopY = 200;

// the distance between each stop light
var stopDist = 200;

// the x position of each, which will change randomly
var redX, yellowX, greenX;

// grow = true, will expand the shapes horizontally, otherwise shrink them
var grow = true;

function setup() {
  createCanvas(1000, 800);
  ellipseMode(CENTER);
  
  red = color(255,0,0);
  yellow = color(255,255,0);
  green = color(0,255,0);
    
  // start with these centered 
  redX = width/2;
  greenX = width/2;
  yellowX = width/2;
}

function draw() {
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
function animateLights() {
  if( grow )
   eWidth = eWidth + 3;
 else
   eWidth = eWidth - 1;
   
 // hit max, set grow to false  
 if( eWidth > 200 ) {
    grow = false;
    print("MAX Reached");
 }
 else if( eWidth < 30 ) {
    grow = true; 
    print("MIN Reached");
 }
}

// move the x of each one to a random range
// move the y of the group to a random range
function jitter() {
  redX = redX + random(-1,1);
  greenX = greenX + random(-10,10);
  yellowX = yellowX + random(-4,4);
  stopY = stopY + random(-10,10);
}



