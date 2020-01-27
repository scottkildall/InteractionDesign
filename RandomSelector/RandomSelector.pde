/*
  Random Selector
  by Scott Kildall
  
 Choose a random students name and display it for presentation
  
  Improvements/problems
    * Right now this is cloned from RandomPartners, so has the same floating code in it and same fucntionality
    
    
*/


// Global variable for our font, which we create at startup
PFont bigFont;
PFont smallFont;
boolean bRouletteOn = false;
int delayTime = 30;

//-- array of names, change numNames and addName() below if students are absent
int numStudents = 16;      // array sizes
int numNames = 0;              // number actually added
DisplayName [] names;
boolean [] bSelected;

int rouletteNameIndex = -1;      // set to -1 if we are not using

// array-shuffling
IntList connections;


  
void setup() {
  size(1000, 600);
  textAlign(CENTER);
  randomSeed(mouseX * mouseY);       // seed off of mouse coordinates

  // create your fonts
  bigFont = createFont("Helvetica",36,true); 
  smallFont = createFont("Helvetica",24,true); 
  
  textFont(bigFont);
  
  connections = new IntList();
  initializeNames();
  
  //-- this shuffles our array, for the randomizer
  connections.shuffle();
}


void draw() {
  // background for the screen, 0-255 grayscale or an (r,g,b) color
  background(0);
  
  // font and fill color
  textFont(smallFont);       

  // draw all names in white, check for roulette wheel
  
  for( int i = 0; i < numNames; i++ ) {
    // unselected, draw in white
    if( i != rouletteNameIndex ) {
      textFont(smallFont);
      
      // unselected = white, selected = gray
      if( bSelected[connections.get(i)] )
         fill(100);
      else
        fill(255);
      
      names[connections.get(i)].draw();
    }
      
    // is current selection, draw in white
    else {
      textFont(bigFont); 
      fill(240,120,0);
      names[connections.get(rouletteNameIndex)].draw();
    }  
  }
  
  //-- spin roulette wheel
  if( bRouletteOn == true ) {
    nextRouletteName();
    
    delay(delayTime);
    
    // add some randomness here
    delayTime = delayTime + (int)random(15,20);
    if( delayTime > random(350,400) ) {
      bRouletteOn = false;
    }
  }
}

// SPACEBAR turns on the roulette wheel
void keyPressed() {
  if( key == ' ' ) {
    if( bRouletteOn == false ) {
      delayTime = 100;
      bRouletteOn = true;
      println("turning on roulette");
      
      if( rouletteNameIndex != -1 ) {
         bSelected[connections.get(rouletteNameIndex)] = true; 
      }
    } 
  }
}

//-- go through all students in list, comment out if people aren't here
//-- also set array of bSelected to false
//-- note: there is a better way!
void initializeNames() {
  names = new DisplayName[numStudents];
  bSelected = new boolean[numStudents];
    
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
  addName("Toff");
  addName("Tommy");
}

void addName(String s) {
  // for the connections, a shuffled list
  connections.append(numNames);
  
  names[numNames] = new DisplayName(s);
  bSelected[numNames] = false;
  
  numNames++;
}

void nextRouletteName() {
  if( areAllSelected() ) {
    bRouletteOn = false;
    rouletteNameIndex = -1;
  }
  
  rouletteNameIndex++;
  
  if( rouletteNameIndex == numNames )
   rouletteNameIndex = 0;
   
 
  while( bSelected[connections.get(rouletteNameIndex)] == true ) {
    rouletteNameIndex++;
    if( rouletteNameIndex == numNames )
     rouletteNameIndex = 0;
  
     println("skip"); 
  }
}

boolean areAllSelected() {
  for( int i = 0; i < numNames; i++ ) {
     if( bSelected[i] == false )
       return false;
  }
  
  return true;
}
