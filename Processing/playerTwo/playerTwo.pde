/*
    Animation Sample
    by Scott Kildall
  
    Shows an animation class
  
 */
 
 
AnimatedPNG animation1;


void setup  () {
  size (1000, 600);  
  
  imageMode(CENTER);
  //ellipseMode(CENTER);
  //rectMode(CORNER);
  //textAlign(LEFT);
  
  // this will allocate and load all the images  
  animation1 = new AnimatedPNG("figure", 40);  // "figure1.png", "figure2.png", etc.
   
} 



//-- change background to red if we have a button
void draw () {  
  background(0); 
  
  animation1.draw(width/2,height/2);
}
