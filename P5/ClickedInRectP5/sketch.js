/*
  Clicked in Rect Example
  by Scott Kildall
  
  Draw 3 rectangles and see if user clicked in them

  Somewhat hard-coded, ie no arrays
*/

// Rect 1
rect1Left = 100;
rect1Width = 200;
rect1Top = 400;
rect1Height = 50;

// Rect 2
rect2Left = 300;
rect2Width = 100;
rect2Top = 100;
rect2Height = 60;

// Rect 3
rect3Left = 250;
rect3Width = 300;
rect3Top = 200;
rect3Height = 100;

msgString = "try clicking on a rect";     // tell us what's going on

function setup() {
  createCanvas(800, 600);
  rectMode(CORNER);
}

function draw() {
  background(0);

  drawRects();         

  // draw message text
  drawDebugMsg();
}

function drawDebugMsg() {
  textFont("Arial");
  textSize(32);
  fill(255);
  noStroke();
  text( msgString, width/2, height - 30); 
}

function drawRects() {
  // draw an red at center
  noFill(255,0,0);
  stroke(0,255,0);
  strokeWeight(2);
  
  rect(rect1Left,rect1Top,rect1Width,rect1Height);
  rect(rect2Left,rect2Top,rect2Width,rect2Height);
  rect(rect3Left,rect3Top,rect3Width,rect3Height);
}

function mousePressed() {
  if( isMouseInRect(rect1Left,rect1Top,rect1Width,rect1Height) )
    msgString = "rect 1"
  else if( isMouseInRect(rect2Left,rect2Top,rect2Width,rect2Height) )
    msgString = "rect 2"
  else if( isMouseInRect(rect3Left,rect3Top,rect3Width,rect3Height) )
    msgString = "rect 3"
  else
    msgString = "no rect"
}

// rectL = left edge
// rectW = width
// right edge = left edge + width
function isMouseInRect(rectL, rectT, rectW, rectH) {
  // check X first
  if( mouseX >= rectL && mouseX <= rectL + rectW ) {
    if( mouseY >= rectT && mouseY <= rectT + rectH ) {
      // must satisfy *both* conditions
      return true;
    }
  }

  return false;
}
