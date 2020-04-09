/*
  SimpleButton
  by Scott Kildall

  Expects Serial data from Arduino, 0 or 1 as a string
  Will change the background to red when the button gets pressed
 */
 

// Importing the serial library to communicate with the Arduino 
import processing.serial.*;    

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;      
String portName = "/dev/tty.SLAB_USBtoUART";

// Variable for changing the background color, 0 or 1. Note: integer is easier for casting from string
int inputValue = 0;

// Change to appropriate index in the serial list — YOURS MIGHT BE DIFFERENT
int serialIndex = 5;

void setup ( ) {
  size (800,  600);    
  
  // List all the available serial ports
  printArray(Serial.list());
  
  // Set the com port and the baud rate according to the Arduino IDE
  myPort  =  new Serial (this, Serial.list()[serialIndex],  115200); 
} 


// We call this to get the data 
void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    // This removes the end-of-line from the string AND casts it to an integer
    inputValue = int(trim(inBuffer));
    
    print(inputValue);
  }
} 

//-- change background to red if we have a button
void draw ( ) {  
  // every loop, look for serial information
  checkSerial();
  
  // if input value is 1 (from ESP32, indicating a button has been pressed), change the background
  if( inputValue == 1 )
    background( 255,0,0 );
  else
    background(0);
} 
