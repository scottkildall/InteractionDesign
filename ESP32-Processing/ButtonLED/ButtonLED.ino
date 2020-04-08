/*
  Button LED
  by Scott Kildall
  
  Momentary button to lightup LED
  Also illustrates use of the Serial Monitor
  
  We use the built-in LED, but you can hook an external LED with
  a 250 Ohm (or thereabouts) resistor.  
 */


int ledPin = 15;
int buttonPin = 12;

//-- time between LED flashes, for startup
const int ledFlashDelay = 150;

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize pins and input and output
  pinMode(ledPin, OUTPUT);    
  pinMode(buttonPin, INPUT);
  
  Serial.begin(115200);
  Serial.println( "ButtonLED: Starting" ); 

   blinkLED(4);
}

// the loop function runs over and over again forever
void loop() {
  activateLED(); 
}

//-- blink that number of times
void blinkLED(int numBlinks ) {
  for( int i = 0; i < numBlinks; i++ ) {
    digitalWrite(ledPin, HIGH); 
    delay(ledFlashDelay);  
    digitalWrite(ledPin, LOW); 
    delay(ledFlashDelay);  
  }
}

//-- look at the momentary switch (button) and show on/off
//-- display in the serial monitor a well
void activateLED() {
  
  if( digitalRead(buttonPin) == true ) {
     // Button is ON turn the LED ON by making the voltage HIGH
    digitalWrite(ledPin, HIGH);   
    Serial.println( "ON" );  
  } 
  
  else {
    // Button is ON turn the LED ON by making the voltage LOW
    digitalWrite(ledPin, LOW);    // turn the LED off by making the voltage LOW 
    Serial.println( "OFF" );  
  }
}
