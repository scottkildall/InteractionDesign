/*******************************************************************************************************************
//
//  Class: animatedPNG
//
//  Written by Scott Kildall
//
//------------------------------------------------------------------------------------------------------------------
//  NOTES:
//  
//  LOADING IMAGES
//  * Expects *numbered* PNG files, start with 0, e.g. 1, "figure1.png", "figure2.png"
//  * is case sensitive, use LOWERCASE ".png"
//  * Will be in sketch path, but can include subdirectories for the load function
//
//  * PNGS should be same size, otherwise you will have registration probs while drawing
//  * drawing uses whatever the current imageMode() is

*********************************************************************************************************************/


public class AnimatedPNG {
  //-------- PUBLIC FUNCTIONS --------/
  public AnimatedPNG(String _baseFilename, long frameTime) {
      // just copy the base filename
      baseFilename = new String(_baseFilename);
      
      displayTimer = new Timer(frameTime);
      
      numImages = 0;
      currentImage = 0;
      
      load();
      displayTimer.start();
  }
  
  
  
  //-------- PRIVATE VARIABLES --------/
  String baseFilename;
  PImage [] images;
  int numImages;
  int currentImage;
  Timer displayTimer;
 
  //-------- PRIVATE FUNCTIONS --------/
  // this does the actual loading, returns the number of images loaded
  private int load() { 
    // count the files
    numImages = 1;
    
   
    while(true) {
      File f = dataFile(sketchPath(baseFilename + str(numImages) + ".png"));
      if( f.isFile() == false ) {
        // subtract 1 for the not loaded file and exit loop,
        numImages = numImages - 1;
        break;
      }
     
      numImages = numImages + 1;
    }
   
    
    // allocate the array
    images = new PImage[numImages];
    
    // now load the images
    for( int i = 0; i< numImages; i++ ) {
      images[i] = loadImage(sketchPath(baseFilename + str(i+1) + ".png"));
    }
    
    println("AnimatedPNG Class, basefilename = " + baseFilename + "loaded num images = " + str(numImages) );
    
    return numImages;
  }
  
  
  
  // draws current image at that location
  public void draw( float x, float y) {
    update();
    
    // don't draw if there are no images
    if( numImages == 0 )
      return;
      
    image( images[currentImage], x, y );
  }
  
  // updates the timer, no need to call this if you are drawing
  public void update() {
    // no update if no images
    if( numImages == 0 )
      return;
      
    if( displayTimer.expired() ) {
       // increment image number and restart
       currentImage++;
       if( currentImage == numImages )
         currentImage = 0;
       
       displayTimer.start();
     } 
  }
}
