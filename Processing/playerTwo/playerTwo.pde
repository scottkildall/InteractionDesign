/*
    Animation Sample
    by Scott Kildall
  
    Shows an animation class
    
    Uses the AnimatedPNG class to DRAW objects
    
    Press '1' to slow down animation
    Press '2' to speed it up
    Press SPACE to release projectile
    
    PNG files need to be numbered with LOWERCASE, start at ONE
    e.g. hearts1.png, hearts2.png, hearts3.png metc
 */
 
 
// an animated figure
AnimatedPNG animatedFigure;

// Three possible projectiles
AnimatedPNG hearts;
AnimatedPNG bananas;
AnimatedPNG lightning;

AnimatedPNG [] projectilesArray;

AnimatedPNG  projectile;      // we change which one we are using, so never load this file

//-------- PROJECTILE CODE
boolean bShootProjectile = false;
boolean bDrawProjectile = false;

int frameNum;    // we use this for determining when to release a projectile
int frameTimeMS = 100;

// dawing of projectile
float projectileX;
float projectileY;
float projectileSpeedX = -4;    // from right to left

void setup  () {
  size (1000, 600);  
  
  imageMode(CENTER);
  
// LOAD ANIMATED PNG files 
  // allocated 3 Animated PNGs
  
  // (1) allocate the array 
  projectilesArray = new AnimatedPNG[3];
  
  //// Allocate EACH element in the array
  projectilesArray[0] = new AnimatedPNG();  
 projectilesArray[0].load("figure", frameTimeMS); 
 
 animatedFigure = new AnimatedPNG();  
  animatedFigure.load("figure", frameTimeMS); // "figure1.png", "figure2.png", etc.
  
  hearts = new AnimatedPNG();  // "hearts1.png", "hearts2.png", etc.
  hearts.load("hearts", 100);
  
  bananas = new AnimatedPNG();  // "bananas1.png", "bananas1.png", etc.
  bananas.load("banana", 200);
  
  lightning = new AnimatedPNG();  // "lightning1.png", "lightning2.png", etc.
  lightning.load("lightning", 25);
} 

//-- Draw animated figures
//-- 
void draw () {  
  background(0); 
  
  // draw animation
  animatedFigure.draw(width/2,height/2);
 
 // show all the animations
  hearts.draw( mouseX, mouseY );
  bananas.draw( 150, height - 50 );
  lightning.draw( 250, height - 50 );

   // check for projectile release
  checkProjectileRelease();
  
  // draw projectile (or nothing if it is offscreen)
  drawProjectile();
}

// if a new frame on on frame 15, we release the projectile
void checkProjectileRelease() {
  // check flag, if no shoot, then we exit
  if( bShootProjectile == false )
    return;
    
  int newFrameNum = animatedFigure.getFrameNum();
  if( frameNum != newFrameNum && newFrameNum == 15 ) {
    println("RELEASE");
    bDrawProjectile = true;
    bShootProjectile = false;
    
    // choose a projectile
    selectProjectile();
    
    // this is the release point
    projectileX = width/2 - 100 ;
    projectileY = height/2 - 50;
    bDrawProjectile = true;
  } 
  
  frameNum = newFrameNum;
  
}

void drawProjectile() {
  // check flag, if draw then we look at timer
  if( bDrawProjectile == false )
    return;
    
  projectileX = projectileX + projectileSpeedX;
  
  projectile.draw(projectileX, projectileY );
  
  // check for offscreen
  if( projectileX < - 300 )
    bDrawProjectile = false;
}

// 1 = faster animation
// 2 = slower animation
// SPACE will shoot a projectile
void keyPressed() {
  if( key == '1' ) {
    println("slower");
    
    // slower
    frameTimeMS = frameTimeMS + 25;    
    if( frameTimeMS > 1000 )
      frameTimeMS = 1000;
      
     animatedFigure.setFrameTime(frameTimeMS);
  }
  
  if( key == '2' ) {
    // faster
    println("faster");
    
    frameTimeMS = frameTimeMS - 25;    
    if( frameTimeMS < 10 )
      frameTimeMS = 10;
      
     animatedFigure.setFrameTime(frameTimeMS);
  }
  
  // shoot a projectle!
  if( key == ' ' ) {
     bShootProjectile = true; 
  }
}

// choose a new projectile: bananas, hearts or lightning
void selectProjectile() {
  int projectileNum = int(random(1, 4));    // returns 1-3
  
  if( projectileNum == 1 ) {
    projectile = bananas;
    projectileSpeedX = -6;  // medium
    
  }
  else if( projectileNum == 2 ) {
    projectile = lightning;
    projectileSpeedX = -10;  // fast
  }
  else if( projectileNum == 3 ) {
    projectile = hearts;
    projectileSpeedX = -3;  // slow
  }
}
