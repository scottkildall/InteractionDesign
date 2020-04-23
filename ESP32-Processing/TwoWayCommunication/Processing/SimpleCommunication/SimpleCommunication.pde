/*
  Simple Communication
  by Scott Kildall
  
  This is based on the BubbleTimer sketch, which
  * Shows timer remaining
  * Decrease a diameter circle according to time remaining percentage
  * Shows a progress bar as well
  
  Added things:
  * Potentiometer now controls the timing
 */
 
 
Timer bubbleTimer;
int bubbleTimerMS = 5000;  // how long in MS the timer will be (default)

PFont displayFont;

// Drawing things
int hMargin = 100;
float progressBarWidth = 400;    // change according to the width in setup()
float progressBarHeight = 20;
float maxBubbleDiameter = 300;

// MAPPING the potentiometer input
float minBubbleTime = 500;
float maxBubbleTime = 4000;

// mapping pot values
float minPotValue = 0;
float maxPotValue = 4095;

// SERIAL COMMUNICATION
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

Timer serialCheckTimer;
int serialCheckTime = 20;    // every ms, during our loop, we check it
 
// RGB LED
boolean bRedLEDOn = false;
boolean bGreenLEDOn = false;
boolean bBlueLEDOn = false;

void setup() {
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
  
   // Set the com port and the baud rate according to the Arduino IDE
  //-- use your port name
  myPort  =  new Serial (this, "/dev/cu.SLAB_USBtoUART",  115200); 
  
  serialCheckTimer = new Timer(serialCheckTime);
  serialCheckTimer.start();
} 



//-- change background to red if we have a button
void draw () {  
   // every loop, look for serial information but use a timer so that
   // we don't spend too much tkme here
   if( serialCheckTimer.expired() ) {  
    checkSerial();
    sendSerialData();
    serialCheckTimer.start();
  }
  
  // draws all our bubble graphics
  drawGraphics();
  drawLEDs();
}


//-- 'r' 'g' 'b' keys just toggle the led
void keyPressed() {
  if( key == 'r' )
    bRedLEDOn = !bRedLEDOn;
    
  else if( key == 'g' )
    bGreenLEDOn = !bGreenLEDOn;
    
  else if( key == 'b' )
    bBlueLEDOn = !bBlueLEDOn;
}

//-- looks for data stream from ESP32
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
      float bubbleTime = map( potValue, minPotValue, maxPotValue, minBubbleTime, maxBubbleTime );
      bubbleTimer.setTimer( int(bubbleTime));
   }
  }
} 

// we will format the data as a string with 3 fields:
// which will be RGB Data, red, green then blue
// "1,0,1"
// above the example is that red = 255, green = 0, blue 255
// *currently* we just send out 0 or 1, but could alter this in the future
void sendSerialData() {
  // convert to 0-255
  int red = 0;
  int blue = 0;
  int green = 0;
  
  // change the values if the LED is on
  if( bRedLEDOn )
    red = 1;
  if( bGreenLEDOn )
    green = 1;
  if( bBlueLEDOn )
    blue = 1;
  
  // Form the data string. The '\r' stands for the RETURN character, which 
  // we will check for in the ESP32
  String dataStr = str(red) + ","  + str(blue) + "," + str(green); 
  
  myPort.write(dataStr);
}

void drawGraphics() {
 background(0); 
  
  // draw title
  noStroke();
  fill(255);
  textSize(32);
  text("SimpleCommunication Example", hMargin, 40 ); 
  
  // check to see if timer is expired, then restart timer
  if( bubbleTimer.expired() ) {
    bubbleTimer.start();
  }
  
 
 // SHOW REMAING TIME
  fill(255);
  textSize(28);

  // make it into seconds with a single decimal point — these two lines seem to do the proper formatt
  float secondsDisplay = bubbleTimer.getRemainingTime()/100;
  secondsDisplay = secondsDisplay/10;
  
  text("Time remaining (ms): " + str(secondsDisplay), hMargin, 80 ); 
  
  // SHOW INSTRUCTIONS
  fill(0,240,120);
  textSize(20);
  text("Press 'r', 'g' and 'b' to toggle states of the RGB LED", hMargin, 120 ); 
  
  
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

void drawLEDs() {
  int hOffset = 100;        // from center
  int vOffset = 50;        // from bottom
  int ledDiameter = 20;
  
  strokeWeight(1);
  stroke(128);
  
  if( bRedLEDOn ) {
    fill(255,0,0);
    ellipse( width/2 - hOffset, height - vOffset, ledDiameter, ledDiameter );
  }
  
  if( bGreenLEDOn ) {
    fill(0,255,0);
    ellipse( width/2 , height - vOffset, ledDiameter, ledDiameter );
  }
  
  if( bBlueLEDOn ) {
    fill(0,0,255);
    ellipse( width/2 + hOffset, height - vOffset, ledDiameter, ledDiameter );
  }
}
