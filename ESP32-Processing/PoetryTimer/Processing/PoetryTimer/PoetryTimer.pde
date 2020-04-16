/*
  PoetryTimer
  by Scott Kildall

  Expects a string of comma-delimted Serial data from Arduino:
  ** field is 0 or 1 as a string (switch) — not used
  ** second fied is 0-4095 (potentiometer)
  ** third field is 0-4095 (LDR) — not used, we only check for 2 data fields
  
  
    Will change the background to red when the button gets pressed
    Will change speed of ball based on the potentiometer
    
 */
 

// Importing the serial library to communicate with the Arduino 
import processing.serial.*;    

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;      

// Data coming in from the data fields
// data[0] = "1" or "0"                  -- BUTTON
// data[1] = 0-4095, e.g "2049"          -- POT VALUE
// data[2] = 0-4095, e.g. "1023"        -- LDR value
String [] data;

int switchValue = 0;
int potValue = 0;
int ldrValue = 0;

// Change to appropriate index in the serial list — YOURS MIGHT BE DIFFERENT
int serialIndex = 2;

// display for poem
PFont poetryFont;

// lines for the poem  
String[] lines;
int currentLineNum = 0;

// timing for poem
Timer displayTimer;
float timePerLine = 0;
float minTimePerLine = 100;
float maxTimePerLine = 2000;
int defaultTimerPerLine = 1500;

// mapping pot values
float minPotValue = 0;
float maxPotValue = 4095;


void setup ( ) {
  size (1000,  600);    
  
  textAlign(CENTER);
  poetryFont = createFont("Georgia", 32);
 
  
  // List all the available serial ports
  printArray(Serial.list());
  
  // Set the com port and the baud rate according to the Arduino IDE
  //-- use your port name
  myPort  =  new Serial (this, "/dev/cu.SLAB_USBtoUART",  115200); 
  
  
  // Allocate the timer
  displayTimer = new Timer(defaultTimerPerLine);
  
   // settings for drawing the ball
  loadPoem();
  startPoem();
} 


// We call this to get the data 
void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    print(inBuffer);
    
    // This removes the end-of-line from the string 
    inBuffer = (trim(inBuffer));
    
    // This function will make an array of TWO items, 1st item = switch value, 2nd item = potValue
    data = split(inBuffer, ',');
   
   // we have THREE items — ERROR-CHECK HERE
   if( data.length >= 3 ) {
      switchValue = int(data[0]);           // first index = switch value 
      potValue = int(data[1]);               // second index = pot value
      ldrValue = int(data[2]);               // third index = LDR value
      
      // change the display timer
      timePerLine = map( potValue, minPotValue, maxPotValue, minTimePerLine, maxTimePerLine );
      displayTimer.setTimer( int(timePerLine));
   }
  }
} 

//-- change background to red if we have a button
void draw ( ) {  
  // every loop, look for serial information
  checkSerial();
  
  drawBackground();
  checkTimer();
  drawPoem();
} 

// if input value is 1 (from ESP32, indicating a button has been pressed), change the background
void drawBackground() {
    background(0); 
}

void loadPoem() {
   lines = loadStrings("poem.txt");
   
   // This shoes the poem lines in the debugger
  println("there are " + lines.length + " lines");
  for (int i = 0 ; i < lines.length; i++) {
    println(lines[i]);
  } 
}

//-- resets all variables
void startPoem() {
  currentLineNum = 0;
  displayTimer.start();
}

//-- look at current value of the timer and change it
void checkTimer() {
  //-- if timer is expired, go to next  the line number
  if( displayTimer.expired() ) {
     currentLineNum++;
     
     // check to see if we are at the end of the poem, then go to zero
     if( currentLineNum == lines.length ) 
       currentLineNum = 0;
       
     displayTimer.start(); 
  }
}

//-- draw the Title (always the same)
//-- draw current line of poem
void drawPoem() {
  //-- TITLE
  fill(255);
  textSize(32);
  text("Still I Rise", width/2, 80 ); 
  
  textSize(20);
  text("by Maya Angelou", width/2, 120 ); 
  
  //-- CURRENT LINE (may be blank!)
  textFont(poetryFont);
  textSize(36);
  text(lines[currentLineNum], width/2, height/2 ); 
}
