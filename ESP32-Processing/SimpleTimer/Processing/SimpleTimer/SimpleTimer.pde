/*
  SimpleTimer
  by Scott Kildall
 */
 
 
Timer displayTimer;
Timer anotherTimer;

PFont displayFont;

void setup  () {
  size (1000,  600);    
  
  textAlign(CENTER);
  displayFont = createFont("Georgia", 32);
  
  // Allocate the timer
  displayTimer = new Timer(500);
  anotherTimer = new Timer(750);
  
  // start the timer. Every 1/2 second, it will do something
  displayTimer.start();
  anotherTimer.start();
} 



//-- change background to red if we have a button
void draw () {  
  background(0); 
  
  // draw title
  fill(255);
  textSize(32);
  text("SimpleTimer Example", width/2, 80 ); 
  
  // check to see if timer is expired, do something and then restart timer
  if( displayTimer.expired() ) {
    // do something
    fill(255,0,0);
    textSize(48);
    text("MEOW", width/2, height/2 ); 
    
    displayTimer.start();
  }
  
  if( anotherTimer.expired() ) {
     // do something
    fill(0,255,0);
    textSize(48);
    text("WOOF", width/2, height/2 + 200 ); 
     anotherTimer.start(); 
  }
}
