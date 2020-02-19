/*
  Rotate Example
  by Scott Kildall
  
  Rotation example using P5 and a slider for speed
*/

// Rotation
var r = 0;              // rotation itself
var rotSpeed = .01;     // speed of the rotation


// Speed Slider
var speedSlider;
var speedSliderVPos;    // vertical pos of the speed slider
var minSpeedSliderValue = 0;
var maxSpeedSliderValue = 100;

function setup() {
  createCanvas(800, 600);
  ellipseMode(CENTER);

  generateSliders();
}

function draw() {
  background(192);

   // draw labels for sliders
  drawSliderLabels();  

  // get values, map them      
  translateSliderValues();  

  // draw actual elipse 
  drawEllipse();            
}

function drawEllipse() {
  // draw an red at center
  fill(255,0,0);

  // move to origin and perform the translation
  translate(width/2, height/2);
  r = r + rotSpeed;
  rotate(r)

  // move to original spot
  translate(-width/2, -height/2);

  // do actual drawing
  ellipse( width/2, height/2, 200, 60);
}

// slider is drawn by HTML, so we only draw the labels
function drawSliderLabels() {
  fill(0);
  text('speed', speedSlider.x * 2 + speedSlider.width, speedSliderVPos + 12);
}

// grab all the slider values and map them
function translateSliderValues() {
  // get slider values
  var v;
  v = speedSlider.value();
  rotSpeed = map(v, minSpeedSliderValue,maxSpeedSliderValue, 0,.5);
}

// generate the actual sliders
function generateSliders() {
  speedSliderVPos = height - 40;

  // create sliders — the first 2 values are the min and max
  // 2nd value is the inital setting
  speedSlider = createSlider(minSpeedSliderValue, maxSpeedSliderValue, 50);
  speedSlider.position(20, speedSliderVPos);
}