/*
  Scrolling Background Example
  
  Load and play continious scrollable backgrund
*/

// one that is loaded from a file — allocated MEMORY
PImage scrollingImage;     

// Scrolling from right to left
boolean bDrawImage1First = true;
float drawImage1X;
float drawImage2X;
float scrollRate = -200;


void setup() {
  size(500, 600);
  
  imageMode(CENTER);
  scrollingImage = loadImage("backgroundImage.png"); // Load the image
  
  drawImage1X  = width/2;
  drawImage2X = drawImage2X + scrollingImage.width;
}

void draw() {
  background(0);
    
  // Draw 1 side
  image(scrollingImage, drawImage1X, height/2);
  
  // Draw 1 side
  image(scrollingImage, drawImage2X, height/2);
  
  // update image position
  if( bDrawImage1First == true ) {
    // Add position 2 to position 1
    drawImage1X = drawImage1X + scrollRate;
    drawImage2X = drawImage1X + scrollingImage.width;
    
    // check to see if position 1 is offscreen
    if( drawImage1X < -scrollingImage.width/2 )
      bDrawImage1First = false;
  }
  

  else {
    // Add position 2 to position 1
    drawImage2X = drawImage2X + scrollRate;
    drawImage1X = drawImage2X + scrollingImage.width;
    
     // check to see if position 1 is offscreen
    if( drawImage2X < -scrollingImage.width/2 )
      bDrawImage1First = true;
  }
}
