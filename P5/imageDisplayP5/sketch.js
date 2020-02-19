/*
	Simple image display example
*/

let img; // Declare variable 'img'.

// preload() will execture before setup()
function preload() {
  img = loadImage('assets/image1.png'); // Load the image
}

function setup() {
	imageMode(CENTER);
	print("imageDisplayP5 Example");
	print(img);

	createCanvas(1024, 800);
}

function draw() {
	//
	background(0);
		
  	// Displays the image at center point
  	image(img, width/2, height/2, mouseX, mouseY);
}
