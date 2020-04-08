
// Importing the serial library to communicate with the Arduino 
import processing.serial.*;    

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;      
String portName = "/dev/tty.SLAB_USBtoUART";

// Variable for changing the background color, 0-255
boolean buttonPressed = false;


void setup ( ) {
  size (800,  600);    
  
  // List all the available serial ports
  printArray(Serial.list());
  
  // Set the com port and the baud rate according to the Arduino IDE
  myPort  =  new Serial (this, Serial.list()[5],  9600); 
  
  // Uses newline as delimiter, so use println() with Arduino to send data
   myPort.bufferUntil(10);      // 10 is ASCII linefeed character
} 

// an interrupt routine that gets data 

void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    //println(inBuffer.getAt);
    
     println(inBuffer);
    //int inByte = int(inBuffer);
   // println(inByte);
  }
} 

//-- change background to red if we have a button
void draw ( ) {  
  checkSerial();
  
  if( buttonPressed )
    background( 255,0,0 );

  else
    background(0);
} 
