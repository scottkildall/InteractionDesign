/*
  Simple image display example
*/

PImage img; // Declare variable 'img'.

void setup() {
  size(1024, 800);
  
  imageMode(CENTER);
  img = loadImage("assets/ferret.jpg"); // Load the image
  
}

void draw() {
  background(0);
    
  // Displays the image at center point
  image(img, width/2, height/2);
}
