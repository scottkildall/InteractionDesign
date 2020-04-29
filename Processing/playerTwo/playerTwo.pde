/*
    Animation Sample
    by Scott Kildall
  
    Shows an animation class
 */
 
 
AnimatedPNG animatedFigure;

AnimatedPNG hearts;
AnimatedPNG bananas;
AnimatedPNG lightning;
AnimatedPNG spirals;

AnimatedPNG  projectile;      // we change which one we are using, so never load this file
boolean bShootProjectile = false;
boolean bDrawProjectile = false;

int frameNum;    // we use this for determining when to release a projectile
int frameTimeMS = 100;


float projectileX;
float projectileY;
float projectileSpeedX = -4;    // from right to left

void setup  () {
  size (1000, 600);  
  
  imageMode(CENTER);
  //ellipseMode(CENTER);
  //rectMode(CORNER);
  //textAlign(LEFT);
  
  // this will allocate and load all the images  
  animatedFigure = new AnimatedPNG();  
  animatedFigure.load("figure", frameTimeMS); // "figure1.png", "figure2.png", etc.
  
  hearts = new AnimatedPNG();  // "hearts1.png", "hearts2.png", etc.
  hearts.load("hearts", 100);
  
  bananas = new AnimatedPNG();  // "bananas1.png", "bananas1.png", etc.
  bananas.load("banana", 200);
  
  lightning = new AnimatedPNG();  // "lightning1.png", "lightning2.png", etc.
  lightning.load("lightning", 25);
} 

//-- change background to red if we have a button
void draw () {  
  background(0); 
  
  // draw animation
  animatedFigure.draw(width/2,height/2);
  
  // check for projectile release
  checkProjectileRelease();
 
 // show all the animations
  hearts.draw( 50, height - 50 );
  bananas.draw( 150, height - 50 );
  lightning.draw( 250, height - 50 );

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
