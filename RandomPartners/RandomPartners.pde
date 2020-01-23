/*
  Random Partners
  by Scott Kildall
  
  Writes Students Name on the screen and selects groups of 2 to work together
  
  Improvements/problems
    * Aesthetics! It looks like programmer art
    * Do we always want 3 connections if we have an odd number?
    
*/

// Global variable for our font, which we create at startup
PFont f;

//-- array of names, change numNames and addName() below if students are absent
int numStudents = 16;      // array sizes
int numNames = 0;              // number actually added
FloatingName [] names;

// toggle between these two
boolean bDrawConnections = false;

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
}


void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);
  
  // font and fill color
  textFont(f);       
  fill(0,255,128);
  
  for( int i = 0; i < numNames; i++ ) {
    names[i].update();
    names[i].draw();
  }
  
  // now draw lines
  stroke(255);
  strokeWeight(1);
  
  if( bDrawConnections )  {
    for(int i = 0; i < numNames-1; i = i +2 ) {
      line(names[connections.get(i)].x, names[connections.get(i)].y,names[connections.get(i+1)].x, names[connections.get(i+1)].y );
    }
    
    // check for odd number
    if( (numNames % 2) == 1 ) {
      line(names[connections.get(numNames-1)].x, names[connections.get(numNames-1)].y,names[connections.get(numNames-2)].x, names[connections.get(numNames-2)].y );
    }  
  }
  
  // account for numNames being an odd number here
}


void keyPressed() {
  if( key == ' ' ) {
    for( int i = 0; i < numNames; i++ ) 
    names[i].initialize();
  }
  
  if( key == '1' ) {
     bDrawConnections = !bDrawConnections;
     
     if( bDrawConnections )
       makeConnections(); 
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
  //addName("Tommy");
}

void addName(String s) {
  // for the connections, a shuffled list
  connections.append(numNames);
  
  names[numNames] = new FloatingName(s);
  numNames++;
}

void makeConnections() {
  connections.shuffle();
}
