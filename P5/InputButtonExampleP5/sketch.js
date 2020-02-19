/*
  Input Button Example
  by Scott Kildall
  
  Input with a button and text, adapted from P5 examples
  Creates elements in the DOM

  Uses 3 different elements
*/

// these are HTML elements
var input, button, greeting;

function setup() {
  // create canvas
  createCanvas(800, 600);

  // Creates inputs
  input = createInput();
  input.position(20, 65);

  button = createButton('submit');
  button.position(input.x + input.width + 10, 65);

  // this is a callback handler
  button.mousePressed(greet);

  // text element
  greeting = createElement('h2', 'what is your name?');
  greeting.position(20, 5);

  textAlign(CENTER);
  textSize(50);
}

function greet() {
  const name = input.value();

  // make sure it's not empty
  if(name.length == 0 )
    return;

  // change the greeting label
  greeting.html('hello ' + name + '!');
  
  // clears the input value
  input.value('');

  // generates random text with random rotations
  for (let i = 0; i < 200; i++) {
    push();
    fill(random(255), 255, 255);
    translate(random(width), random(height));
    rotate(random(2 * PI));
    text(name, 0, 0);
    pop();
  }
}
