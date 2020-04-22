/*
  SimpleTimer
  by Scott Kildall
  
  Two examples of timers
 */
 
 
Timer meowTimer;
Timer woofTimer;

PFont displayFont;

void setup  () {
  size (1000,  600);    
  frameRate(5);
  
  textAlign(CENTER);
  displayFont = createFont("Georgia", 32);
  
  // Allocate the timer
  meowTimer = new Timer(500);
  woofTimer = new Timer(750);
  
  // start the timer. Every 1/2 second, it will do something
  meowTimer.start();
  woofTimer.start();
} 



//-- change background to red if we have a button
void draw () {  
  background(0); 
  
  // draw title
  fill(255);
  textSize(32);
  text("SimpleTimer Example", width/2, 80 ); 
  
  // check to see if timer is expired, do something and then restart timer
  if( meowTimer.expired() ) {
    // flash "Meow" on the screen
    fill(255,0,0);
    textSize(48);
    text("MEOW", width/2, height/2 ); 
    
    meowTimer.start();
  }
  
  // check to see if other timer is expired, do something and then restart timer
  if( woofTimer.expired() ) {
     // Flash "Woof" on the screen
    fill(0,255,0);
    textSize(48);
    text("WOOF", width/2, height/2 + 200 ); 
     woofTimer.start(); 
  }
}
