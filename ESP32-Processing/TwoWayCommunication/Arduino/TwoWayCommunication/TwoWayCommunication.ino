/*
  SensorsToSerial
  by Scott Kildall

  Designed for ESP32 but will also work for Arudino
  Sends data to Processing
  * 0 or 1 for button pressed
  * 0-4095 for potentiometer (ESP32 has 10-bit analog input)
  * data for LDR (not yet implemented)
  
  Also illustrates use of the Serial Monitor
  
  We use the built-in LED, but you can hook an external LED with
  a 250 Ohm (or thereabouts) resistor.  

    Serial INPUT will affect an RGB LED
    The data stream will look like "1,0,0" (R, G, B)
    And we will each leg to on/off as a result

    You can test it in the Serial monitor!
 */


int ledPin = 15;
int buttonPin = 12;
int potInputPin = A2;
int ldrInputPin = A1;

//-- analog values, track for formatting to serial
int switchValue = 0;
int potValue = 0;
int ldrValue = 0;

int redLEDPin = 4;
int blueLEDPin = 5;
int greenLEDPin = 18;

//-- time between LED flashes, for startup
const int ledFlashDelay = 150;

const int maxDataSize = 8;
char data[maxDataSize];
int dataOffset = 0;

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize pins and input and output
  pinMode(ledPin, OUTPUT);    

  pinMode(redLEDPin, OUTPUT);  
  pinMode(blueLEDPin, OUTPUT);  
  pinMode(greenLEDPin, OUTPUT);  
  
  pinMode(buttonPin, INPUT);
  pinMode(potInputPin, INPUT);    // technically not needed, but good form
  pinMode(ldrInputPin,INPUT);
  
  Serial.begin(115200);
 // Serial.println( "ButtonLED: Starting" ); 

   blinkLED(6);
}

// the loop function runs over and over again forever
void loop() {
  // gets switch Value AND changed LED
  getSwitchValue();
  getPotValue();
  getLDRValue();

  // send our data stream
  //sendSerialData();

  // check our data stream
  checkSerial();
  
  // delay so as to not overload serial buffer
  delay(20);
}

//-- blink that number of times
void blinkLED(int numBlinks ) {
  for( int i = 0; i < numBlinks; i++ ) {
    digitalWrite(ledPin, HIGH); 

    // blink Red, Blue, Green in sequence
    if( i % 3 == 0 )
      digitalWrite(redLEDPin, HIGH); 
     else if( i % 3 == 1 )
      digitalWrite(blueLEDPin, HIGH); 
    else
      digitalWrite(greenLEDPin, HIGH);
    
    delay(ledFlashDelay);
    
    digitalWrite(ledPin, LOW); 
    
     if( i % 3 == 0 )
      digitalWrite(redLEDPin, LOW); 
     else if( i % 3 == 1 )
      digitalWrite(blueLEDPin, LOW); 
    else
      digitalWrite(greenLEDPin, LOW);
      
    delay(ledFlashDelay);  

    
  }
}

//-- look at the momentary switch (button) and show on/off
//-- display in the serial monitor a well
void getSwitchValue() {
  switchValue = digitalRead(buttonPin);
  
  if( switchValue == true ) {
     // Button is ON turn the LED ON by making the voltage HIGH
    digitalWrite(ledPin, HIGH);   
  } 
  else {
    // Button is ON turn the LED ON by making the voltage LOW
    digitalWrite(ledPin, LOW);    // turn the LED off by making the voltage LOW      
  }
}

void getPotValue() {
  potValue = analogRead(potInputPin); 
}

void getLDRValue() {
  ldrValue = analogRead(ldrInputPin); 
}


//-- this could be done as a formatted string, using Serial.printf(), but
//-- we are doing it in a simpler way for the purposes of teaching
void sendSerialData() {
  // Add switch on or off
  if( switchValue ) {
    Serial.print(1);
  }
  else {
    Serial.print(0);
  }

   Serial.print(",");
   Serial.print(potValue);

   Serial.print(",");
   Serial.print(ldrValue);
   
  // end with newline
  Serial.println();

  //Serial.flush();
}

// looks for a 
void checkSerial() {
  // send data only when you receive data:

  int dataBytesRead = 0;
  while (Serial.available() > 0) {
    data[dataBytesRead] = Serial.read();
    dataBytesRead++;
    
    // don't exceed our buffer
    if( dataBytesRead >= maxDataSize )
      break;
  }
  
  // no data
  if( dataBytesRead == 0 )
    return;

  // correct for incrementing above
  dataBytesRead--;
  
  // parse the string (this is the tedious part):
  // we expect a fixed string length of "1,0,1" — ALWAYS 5 characters
  if(  dataBytesRead >= 5 ) {
    // change LEDs
    changeLEDs();
  }
  else {
      // bad data string size here
      //Serial.print("bad data:");
      //Serial.println(dataBytesRead);
  }
}

// look at our data stream and flip leds on/off
// [0] = red ('0' or '1'), anything other than '1' will turn off
// [2] = green ('0' or '1'), anything other than '1' will turn off
// [4] = blue ('0' or '1'), anything other than '1' will turn off   
void changeLEDs() {
  // Red
  if( data[0] == '1' )
    digitalWrite(redLEDPin, HIGH);
  else
    digitalWrite(redLEDPin, LOW);

  // Green
 /* if( data[2] == '1' )
    digitalWrite(greenLEDPin, HIGH);
  else
    digitalWrite(greenLEDPin, LOW);

 // Blue
  if( data[4] == '1' )
    digitalWrite(blueLEDPin, HIGH);
  else
    digitalWrite(blueLEDPin, LOW);
    */
}
