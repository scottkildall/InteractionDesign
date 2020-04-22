/*
  BubbleTimer
  by Scott Kildall
  
  Decrease a diameter circle according to time remaining percentage
  
  Shows a progress bar as well
 */
 
 
Timer bubbleTimer;
int bubbleTimerMS = 5000;  // how long in MS the timer will be

PFont displayFont;

int hMargin = 100;

float progressBarWidth = 400;    // change according to the width in setup()
float progressBarHeight = 20;

float maxBubbleDiameter = 300;

void setup  () {
  size (1000, 600);  
  frameRate(15);
  
  ellipseMode(CENTER);
  rectMode(CORNER);
  textAlign(LEFT);
  
  displayFont = createFont("Georgia", 32);
  
  // adjust progress bar length to width of sceeen
  progressBarWidth = width - (hMargin *2);
  
  // Allocate the timer
  bubbleTimer = new Timer(bubbleTimerMS);    // 3 second timer
  
  
  // start the timer. Every 1/2 second, it will do something
  bubbleTimer.start();
} 



//-- change background to red if we have a button
void draw () {  
  background(0); 
  
  
  // draw title
  noStroke();
  fill(255);
  textSize(32);
  text("Bubble Timer Example", hMargin, 80 ); 
  
  // check to see if timer is expired, then restart timer
  if( bubbleTimer.expired() ) {
    bubbleTimer.start();
  }
  
 
 // SHOW REMAING TIME
  fill(255);
  textSize(32);

  // make it into seconds with a single decimal point — these two lines seem to do the proper formatt
  float secondsDisplay = bubbleTimer.getRemainingTime()/100;
  secondsDisplay = secondsDisplay/10;
  
  text("Time remaining (ms): " + str(secondsDisplay), hMargin, 120 ); 
  
 // DISPLAY PROGRESS BAR BASED ON PERCENTAGE
    float elapsedPercentage = bubbleTimer.getPercentageElapsed();
    
   
    // draw fill
    fill( 240,100,100);
    rect( hMargin, height - 100, progressBarWidth * elapsedPercentage, progressBarHeight);
    
    // drawOutine
    noFill();
    stroke(128);
    strokeWeight(1);
    rect( hMargin, height - 100, progressBarWidth, progressBarHeight);
    
    
  // DRAW CIRCLE BASED ON PERCENTAGE
    float remainingPercentage =  bubbleTimer.getPercentageRemaining();
    fill(255,192,203);  // pink
    ellipse( width/2, height/2, maxBubbleDiameter * remainingPercentage, maxBubbleDiameter * remainingPercentage ); 
}
