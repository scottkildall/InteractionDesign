/*
	Simple image display example

	space bar will inver
*/

var regularImg; // Declare variable 'img'.
var inverseImg;
var bRegular = true;

// preload() will execture before setup()
function preload() {
  regularImg = loadImage('assets/ferret.jpg'); 			// Load the regular image
  inverseImg = loadImage('assets/inverse_ferret.jpg'); 	// Load the inverse image
}

function setup() {
	imageMode(CENTER);

	createCanvas(1024, 800);
}

function draw() {
	//
	background(0);
		
  	// Displays the image at center point
  	if( bRegular )
  		image(regularImg, width/2, height/2);
  	else
  		image(inverseImg, width/2, height/2);
}

function mousePressed() {
  bRegular = !bRegular;
}

function keyPressed() {
  if (key === ' ') {
  	bRegular = !bRegular;
  }
}
