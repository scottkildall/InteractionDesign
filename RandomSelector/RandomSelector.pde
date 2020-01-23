/*
  Random Selector
  by Scott Kildall
  
 Choose a random students name and display it for presentation
  
  Improvements/problems
    * Right now this is cloned from RandomPartners, so has the same floating code in it and same fucntionality
    
    
*/

// Global variable for our font, which we create at startup
PFont f;

//-- array of names, change numNames and addName() below if students are absent
int numStudents = 16;      // array sizes
int numNames = 0;              // number actually added
FloatingName [] names;



// array-shuffling
IntList connections;

void setup() {
  size(1000, 600);
  textAlign(CENTER);
  randomSeed(mouseX * mouseY);       // seed off of mouse coordinates

  // f is created here
  f = createFont("Helvetica",24,true); 
  textFont(f); 
  
  connections = new IntList();
  initializeNames();
  
  //-- this shuffles our array, for the randomizer
  connections.shuffle();
}


void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);
  
  // font and fill color
  textFont(f);       
  fill(0,255,128);
  
  for( int i = 0; i < numNames; i++ ) {
    names[i].draw();
  }
}


void keyPressed() {
  if( key == ' ' ) {
    for( int i = 0; i < numNames; i++ ) 
    names[i].initialize();
  }
}

//-- go through all students in list, comment out if people aren't here
//-- note: there is a better way!
void initializeNames() {
  names = new FloatingName[numStudents];
  
  addName("Alvin");
  addName("Ashley");
  addName("DJ");
  addName("Graham");
  addName("Jake");
  addName("Jeffrey");
  addName("Journ");
  addName("Juliet");
  addName("Kara");
  addName("Lauren");
  addName("My");
  addName("Natalie");
  addName("Reilly");
  addName("Taylor");
  addName("Tiffany");
  addName("Tommy");
}

void addName(String s) {
  // for the connections, a shuffled list
  connections.append(numNames);
  
  names[numNames] = new FloatingName(s);
  numNames++;
}
