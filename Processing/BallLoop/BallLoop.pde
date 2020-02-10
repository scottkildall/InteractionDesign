/*
  Ball Loop
  by Scott Kildall
  
  Draws various circles (balls) on the screen and animates with user input:
  1-8 will make the ball go up and change color and then go back down.
  
  This is a basic "state machine"
  
*/

// State machine
int state;              // will change to one of the states below
final int stateStatic = 1;
final int stateUp = 2;
final int stateDown = 3;

// Colors for each state
color staticColor = color(192);
color upColor = color(230,0,250);
color downColor = color(0,193,0);

// moving ball variables
int movingBallNum;
int ballOffset = 0;
int ballMaxOffset = 100;

// Globals for drawing balls
int ballDiameter = 50;
int numBalls = 8;
int hMargin = 200;
int ballCanvasWidth;      // calculated at startup
int ballDist;            // distance between each ball

void setup() {
  size(1000, 800);
  
  // Center-draw ball shapes
  ellipseMode(CENTER);
 
  // figure out where balls are positioned
  ballCanvasWidth = width - (hMargin * 2);
  ballDist = ballCanvasWidth/ (numBalls-1);
  
  // set intial state here
  state = stateStatic;
}

// everything in draw loop, better encapsulation would be to break it into functions
void draw() {
  background(0);
  
  
  // draw each ball
  for( int i = 0; i < numBalls; i++ ) {
    // DRAW the UP ball, if there is one
    if( state == stateUp && i == movingBallNum )
      drawUpBall(i);
    
    
    // DRAW the DOWN ball, if there is one
    else if( state == stateDown && i == movingBallNum )
      drawDownBall(i);
      
    else
      drawStaticBall(i);
  }
}

// changes the ball color, shifts ball offset and will CHANGE the state to down if the ball has reached apex
void drawUpBall(int ballNum) {
   // draw up ball here and decrement position  
   fill(upColor);
   ellipse(hMargin + (ballNum*ballDist), height/2 + ballOffset, ballDiameter, ballDiameter );
   ballOffset--;    // suv 1 to the ball offset
        
   // check to see if we have reached our minumum, if we do then CHANGE thes state
   // note: ballOffset is a negative number
   if( ballOffset < -ballMaxOffset )
       state = stateDown;      
}

// changes the ball color, shifts ball offset and will CHANGE the state to static if the ball has settled
void drawDownBall(int ballNum) {
   fill(downColor);
   ellipse(hMargin + (ballNum*ballDist), height/2 + ballOffset, ballDiameter, ballDiameter );
   ballOffset++;  
   if( ballOffset >= 0 )
    state = stateStatic;   
}

// draw static ball. Note: we do the state change in the keyPressed() command
void drawStaticBall(int ballNum) {
   fill(staticColor);
   ellipse(hMargin + (ballNum*ballDist), height/2, ballDiameter, ballDiameter );   
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
