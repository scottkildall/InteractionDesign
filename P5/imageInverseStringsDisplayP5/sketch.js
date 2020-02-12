/*
	Simple image display example

	mouse + space bar will invert
  Also, display a random bit of text
*/

var regularImg; // Declare variable 'img'.
var inverseImg;
var bRegular = true;
var stringList;
var displayString = "";    // which string we will display

// preload() will execture before setup()
function preload() {
  regularImg = loadImage('assets/ferret.jpg'); 			// Load the regular image
  inverseImg = loadImage('assets/inverse_ferret.jpg'); 	// Load the inverse image
  stringList = ["hello", "hi", "greetings", "yo"];

  // uncomment to load from a file
  //stringList = loadStrings('assets/displaytext.txt');
}

function setup() {
  print("imageInverseStringsDisplay Example")
	imageMode(CENTER);
  
	createCanvas(1024, 800);

  // show how many elements are in the array
  print(stringList.length + " elements");
  print(stringList);
}

function draw() {
	background(0);
  textSize(64);
		
  	// Displays the image at center point
  	if( bRegular ) {
  		image(regularImg, width/2, height/2);
    }
  	else {
  		image(inverseImg, width/2, height/2);

      fill(255,255,0);
      text(displayString,100,100);
    }
}

function mousePressed() {
  bRegular = !bRegular;

  chooseNewItem();
}

function keyPressed() {
  if (key === ' ') {
  	bRegular = !bRegular;
  }

  chooseNewItem();
}

// chooses a new items from the array, select a random
// index 0 to length of array-1
function chooseNewItem() {
  displayString = random(stringList);
  print(displayString);
}

