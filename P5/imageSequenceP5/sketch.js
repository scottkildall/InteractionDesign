/*
	Simple image display example

	mouse + space bar will invert
  Also, display a random bit of text
*/

var regularImg; // Declare variable 'img'.
var inverseImg;
var bRegular = true;
var imageList = [];
var img

var startMillis;

// preload() will execture before setup()
function preload() {
  imageList[0] = loadImage('assets/image1.jpg'); 			
  imageList[1] = loadImage('assets/image2.jpg');
  imageList[2] = loadImage('assets/image3.jpg');
  imageList[3] = loadImage('assets/image4.jpg');
  imageList[4] = loadImage('assets/image5.jpg');
}

function setup() {
	imageMode(CENTER);

  chooseNewImage();
  
	createCanvas(1024, 800);

  startMillis = millis();
}

function draw() {
	background(0);
	
  if( millis() > startMillis + 1000 ) {	
  // Displays the image at center point
  //image(img, width/2, height/2, random(mouseX), random(mouseY));
  chooseNewImage();
  startMillis = millis();

 }
  
  image(img, width/2, height/2);

}

function mousePressed() {
  bRegular = !bRegular;

  chooseNewImage();
}

function keyPressed() {
  if (key === ' ') {
  	bRegular = !bRegular;
  }

  chooseNewImage();
}

// chooses a new items from the array, select a random
// index 0 to length of array-1
function chooseNewImage() {
  img = random(imageList);
  print(img);
}

