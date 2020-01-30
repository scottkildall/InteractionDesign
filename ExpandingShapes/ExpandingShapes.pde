/*
  Expanding Shapes
  by Scott Kildall
  
  Expand and grow various shapes
*/

int eWidth = 70;
int eHeight = 70;
color red = #FF0000;
color yellow = color(255,255,0);
color green = color(0,255,0);

float stopX;
float stopY = 200;
int stopDist = 200;

float redX, redY, greenX, greenY, yellowX, yellowY;

boolean grow = true;

void setup() {
  size(1800, 1000);
  ellipseMode(CENTER);
  
  stopX = width/2;
  redX = stopX;
  greenX = stopX;
  yellowX = stopX;
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

void jitter() {
  redX = redX + random(-1,1);
  greenX = greenX + random(-10,10);
  yellowX = yellowX + random(-4,4);
  stopY = stopY + random(-10,10);
}
