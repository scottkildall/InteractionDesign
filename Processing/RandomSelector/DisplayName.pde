/*
  Class DisplayName
  
  Names will float on the screen using the update() and draw() cycles, which should be called repeatedly.
  
  dx and dy will be the change in x and y, which will be updated each loop. We do bounds-checking on
  xMin, xMax, yMin, yMax
*/

class DisplayName { 
    // variables
    float x, y; 
    float xMin, xMax, yMin, yMax;
    String nameStr;

    DisplayName (String s) {  
      xMin = textWidth(s)/2;
      xMax = width - textWidth(s)/2;
      yMin = 30;
      yMax = height - 30;
      
      nameStr = s;
      
      initialize();
    }
    
    void initialize() {
      x = random(xMin, xMax);
      y = random(yMin, yMax);
    }
    
    void draw() {
      text(nameStr,x,y); 
    }
 } 
