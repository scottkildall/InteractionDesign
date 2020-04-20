/*
  DrumMachine
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

// Sound libraries
import processing.sound.*;
SoundFile cymbal;
SoundFile bassDrum;
SoundFile snareRoll;
SoundFile snare;
SoundFile hihat;


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

// timing for serial data
Timer beatTimer;
Timer snareRollTimer;

Timer serialCheckTimer;

int serialCheckTime = 50;    // every ms, during our loop, we check it

float timePerLine = 0;
float minTimePerLine = 150;
float maxTimePerLine = 1000;
int defaultTimerPerLine = 1500;

// mapping pot values
float minPotValue = 0;
float maxPotValue = 4095;

// drum machine stuff
boolean bPlayBeat = false;
int beatNum = 1;    // 1-8, we are 4/4, 2,4,6,8 are half beats
int maxBeat = 8;

boolean bPlayCymbal = false;
boolean bPlayBass = false;

// startup with a snare!
int snareRollTime = 2000;

// two-state state machine
int state;
int stateStartup = 1;
int stateSamplesLoaded = 2;
int stateDrumMachine = 3;

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
  beatTimer = new Timer(defaultTimerPerLine);
  
  snareRollTimer = new Timer(snareRollTime);
  snareRollTimer.start();
  
  serialCheckTimer = new Timer(serialCheckTime);
  serialCheckTimer.start();
  
  
  state = stateStartup;
  
  // Load all the sound samples
  loadSamples();
} 


// We call this to get the data 
void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    //print(inBuffer);
    
    // This removes the end-of-line from the string 
    inBuffer = (trim(inBuffer));
    
    // This function will make an array of TWO items, 1st item = switch value, 2nd item = potValue
    data = split(inBuffer, ',');
   
   // we have THREE items — ERROR-CHECK HERE
   if( data.length >= 2 ) {
      switchValue = int(data[0]);           // first index = switch value 
      potValue = int(data[1]);               // second index = pot value
      ldrValue = int(data[2]);               // third index = LDR value
      
      // change the display timer
      timePerLine = map( potValue, minPotValue, maxPotValue, minTimePerLine, maxTimePerLine );
      beatTimer.setTimer( int(timePerLine));
      
      // ANALYZE DATA
      
      // switch down indicates whether we are going to be playing a cymbal or not
      bPlayCymbal = boolean(switchValue);      // convert to boolean
      
   }
  }
} 

//-- change background to red if we have a button
void draw ( ) {  
  if( serialCheckTimer.expired() ) {  
    // every loop, look for serial information
    checkSerial();
    serialCheckTimer.start();
  }
  
  drawBackground();
  checkTimer();
  
  if( state == stateStartup ) {
     redraw();
     loadSamples();
     state = stateSamplesLoaded;
  }
  else if( state == stateSamplesLoaded ) {
    if( snareRollTimer.expired() ) {
      state = stateDrumMachine;   
    }
  }  
  else {
     drawBeats(); 
  }  
} 

// if input value is 1 (from ESP32, indicating a button has been pressed), change the background
void drawBackground() {
    background(0); 
}


void loadSamples() {
  // Load snare roll first, then play
  snareRoll = new SoundFile(this, "samples/real-snare-roll.wav");
  snareRoll.play();
  
  cymbal = new SoundFile(this, "samples/real-01.8ACSM.wav");
  bassDrum = new SoundFile(this, "samples/real-kick-F009.wav");
  snare = new SoundFile(this, "samples/real-03SS-snare-R2C-L.wav");
  hihat = new SoundFile(this, "samples/real-03PD.UF-HiHat-A-L.wav");
}

//-- resets all variables
void startDrumMachine() {
  beatTimer.start();
}

//-- look at current value of the timer and change it
void checkTimer() {
  //-- if timer is expired, go to next  the line number
  if( beatTimer.expired() ) {
     bPlayBeat = true;
     beatNum++;
     if( beatNum > maxBeat )
       beatNum = 1;
     
     beatTimer.start(); 
  }
}


void drawBeats() {
  //-- TITLE
  fill(255);
  textSize(32);
  
  // we could do 1-and, here 
  text(beatNum, width/2, 80 ); 
  
   if( bPlayBeat ) {
      bPlayBeat = false;
      
      if( (beatNum % 2) == 1 )
        bassDrum.play();
      else {
        if( beatNum == 8 )
           hihat.play();
         else   
           snare.play();
      }
      
      if( bPlayCymbal )
       cymbal.play();
   }
  
  ////-- CURRENT LINE (may be blank!)
  //textFont(poetryFont);
}
