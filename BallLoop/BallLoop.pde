/*
  Ball Loop
  by Scott Kildall
  
  Draws various circles (balls) on the screen and animates them in various ways,
  using for loops and user input
  
*/

// Global variable for our font, which we create at startup
int ballDiameter = 50;

// state machine
int state;              // will change to one of the states below
final int stateStatic = 1;
final int stateUp = 2;
final int stateDown = 3;

// moving ball variables
int movingBallNum;
int ballOffset = 0;
int ballMaxOffset = 100;

// This is a font that we will use for debugging
PFont f;
int numBalls = 8;
int hMargin = 200;
int ballCanvasWidth;
int ballDist;      // distance between each ball

color staticColor = color(192);
color upColor = color(230,0,250);
color downColor = color(0,193,0);

void setup() {
  size(1800, 800);
  
  // Center text and shapes
  textAlign(CENTER);
  ellipseMode(CENTER);

  // f is created here
  f = createFont("Helvetica",24,true); 
  
  // figure out where balls are positioned
  ballCanvasWidth = width - (hMargin * 2);
  ballDist = ballCanvasWidth/ (numBalls-1);
  
  // set intial state here
  state = stateStatic;
}

void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);
  
  // draw one red ball on the screen
  fill(255,0,0);
  
  // draw each ball
  for( int i = 0; i < numBalls; i++ ) {
      if( state == stateUp && i == movingBallNum ) {
        // draw up ball here and decrement position  
        fill(upColor);
        ellipse(hMargin + (i*ballDist), height/2 + ballOffset, ballDiameter, ballDiameter );
        ballOffset--;    // suv 1 to the ball offset
        
        // check to see if we have reached our minumum
        // note: ballOffset is a negative number
        if( ballOffset < -ballMaxOffset ) {
          state = stateDown;
        }
          
    }
      else if( state == stateDown && i == movingBallNum ) {
         fill(downColor);
         ellipse(hMargin + (i*ballDist), height/2 + ballOffset, ballDiameter, ballDiameter );
         ballOffset++;  
         if( ballOffset >= 0 ) {
          state = stateStatic;
        }
   }
      else {
        fill(staticColor);
        ellipse(hMargin + (i*ballDist), height/2, ballDiameter, ballDiameter );
      }
  }
}

void keyPressed() {
   // hard-coding this to 8 balls
   if( key >= '1' && key <= '8' ) {
     // Convert ASCII key to ball number, e.g. '1' translates to 0
     int ballNum = key - '1';
     println(ballNum);
     
     // change the ball state
     if( state == stateStatic ) {
       state = stateUp;
       movingBallNum = ballNum;
     }
   }
}
