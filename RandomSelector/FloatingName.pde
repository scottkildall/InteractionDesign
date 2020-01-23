/*
  Class FloatingName
  
  Names will float on the screen using the update() and draw() cycles, which should be called repeatedly.
  
  dx and dy will be the change in x and y, which will be updated each loop. We do bounds-checking on
  xMin, xMax, yMin, yMax
*/

class FloatingName { 
    // variables
    float x, y; 
    float dx, dy;
    float xMin, xMax, yMin, yMax;
    String nameStr;

    FloatingName (String s) {  
      xMin = textWidth(s)/2;
      xMax = width - textWidth(s)/2;
      yMin = 15;
      yMax = height - 15;
      
      nameStr = s;
      
      initialize();
    }
    
    void initialize() {
      x = random(xMin, xMax);
      y = random(yMin, yMax);
      dx = random(-1,1);
      dy = random(-1,1);
    }
    
    void draw() {
      text(nameStr,x,y); 
    }
    
    void update() {
      x = x + dx;
      y = y + dy;
      
      checkBounds();
    }
    
    void checkBounds() {
      // check bounds
      if( x < xMin ) {
          x = xMin;
          dx = -dx;
      }
      else if( x > xMax ) {
          x = xMax;
          dx = -dx;
      }
      if( y < yMin ) {
          y = yMin;
          dy = -dy;
      }
      else if( y > yMax ) {
          y = yMax;
          dy = -dy;
      }
    }
 } 
