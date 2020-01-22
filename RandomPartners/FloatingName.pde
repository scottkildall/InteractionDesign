/*
  Class Name
*/

class FloatingName { 
    // variables
    float x, y; 
    String nameStr;
 
  
    FloatingName (String s) {  
      x = random(width);
      y = random(height);
      nameStr = s;
    }
    
    void draw() {
      text(nameStr,x,y); 
    }
 } 
