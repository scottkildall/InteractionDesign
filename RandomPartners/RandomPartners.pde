/*
  Random Partners
  by Scott Kildall
  
  Writes Students Name on the screen and selects groups of 2 or 3 to work together
*/

// Global variable for our font, which we create at startup
PFont f;

//-- array of names, change numNames and addName() below if students are absent
int numNames = 15;
FloatingName [] names;
int addNameIndex = 0;

void setup() {
  size(1000, 600);
  textAlign(CENTER);

  // f is created here
  f = createFont("Helvetica",24,true); 
  
  initializeNames();
  
}


void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);
  
  // font and fill color
  textFont(f);       
  fill(0,255,128);
  
  for( int i = 0; i < numNames; i++ ) 
    names[i].draw();
  
}


//-- go through all students in list, comment out if people aren't here
//-- note: there is a better way!
void initializeNames() {
  int numStudents = 15;
  
  names = new FloatingName[numStudents];
  
  addName("Alvin");
  addName("Ari");
  addName("Ashley");
  addName("DJ");
  addName("Graham");
  addName("Jake");
  addName("Journ");
  addName("Juliet");
  addName("Kara");
  addName("Lauren");
  addName("My");
  addName("Natalie");
  addName("Reilly");
  addName("Taylor");
  addName("Tommy");
}

void addName(String s) {
  names[addNameIndex] = new FloatingName(s);
  addNameIndex++;
}
