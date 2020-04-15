/*
  ReceiveData
  by Scott Kildall

  Expects a string of comma-delimted Serial data from Arduino:
  ** field is 0 or 1 as a string (switch)
  ** second fied is 0-4095 (potentiometer)
  ** third field is 0-4095 (LDR) 
  
  
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

// animated ball
int minPotValue = 0;
int maxPotValue = 4095;    // will be 1023 on other systems
int minBallSpeed = 0;
int maxBallSpeed = 50;
int ballDiameter = 20;
int hBallMargin = 40;    // margin for edge of screen
int xBallMin;        // calculate on startup
int xBallMax;        // calc on startup
float xBallPos;        // calc on startup, use float b/c speed is float
int yBallPos;        // calc on startup
int direction = -1;    // 1 or -1

//-- image paramers
PImage flickerImg;
float xImagePos = 0;
float yImagePos = 0;

int minLDRValue = 400;
int maxLDRValue = 1700;
int minAlphaValue = 0;
int maxAlphaValue = 255;

void setup ( ) {
  size (800,  600);    
  
  // List all the available serial ports
  printArray(Serial.list());
  
  // Set the com port and the baud rate according to the Arduino IDE
  //-- use your port name
  myPort  =  new Serial (this, "/dev/cu.SLAB_USBtoUART",  115200); 
  
  // settings for drawing the ball
  ellipseMode(CENTER);
  xBallMin = hBallMargin;
  xBallMax = width - hBallMargin;
  xBallPos = width/2;
  yBallPos = height/2;

  // load our image, use your own!
  flickerImg = loadImage("flicker_image.jpg");
  imageMode(CORNER);      // draw from top left
  xImagePos = 20;
  yImagePos = 20;
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
   }
  }
} 

//-- change background to red if we have a button
void draw ( ) {  
  // every loop, look for serial information
  checkSerial();
  
  drawBackground();
  drawBall();
  drawFlicker();
} 

// if input value is 1 (from ESP32, indicating a button has been pressed), change the background
void drawBackground() {
   if( switchValue == 1 )
    background( 0,255,0 );
  else
    background(0); 
}

//-- animate ball left to right, use potValue to change speed
void drawBall() {
    fill(255,0,0);
    ellipse( xBallPos, yBallPos, ballDiameter, ballDiameter );
    float speed = map(potValue, minPotValue, maxPotValue, minBallSpeed, maxBallSpeed);
    
    //-- change speed
    xBallPos = xBallPos + (speed * direction);
    
    //-- make adjustments for boundaries
    adjustBall();
}

//-- check for boundaries of ball and make adjustments for it to "bounce"
void adjustBall() {
  if( xBallPos > xBallMax ) {
    direction = -1;    // go left
    xBallPos = xBallMax;
  }
  else if( xBallPos < xBallMin ) {
    direction = 1;    // go right
    xBallPos = xBallMin;
  }
}

void drawFlicker() {
  float alphaValue = map(ldrValue, minLDRValue, maxLDRValue, minAlphaValue, maxAlphaValue);
  
  // this applies an alpha value to the image
  tint(255, alphaValue);
  image(flickerImg, xImagePos, yImagePos);
}
