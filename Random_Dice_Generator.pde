/**
 * Simplified Yahtzee game - phase 4
 * Test the freqCount and maxOfAKind functions
 * For a better test, increase NUM_SIDES (to no more than 9),
 * and/or NUM_DICE.
 */

//Constants controlling the game.
//The number of sides should not be changed since the
//graphics only handles from 1-6 dots.
//In this version, the number of dice could be varied.
final int NUM_SIDES=6;   //Sides on the dice
final int NUM_DICE=5;    //The number of dice used
int[] location = new int[NUM_DICE];
int[] arr = new int[NUM_SIDES];


//*****INSERT YOUR LAB 10 BRONZE CODE HERE*****

void rollDice() {
  for (int i=0; i<location.length; i++) {
    location[i] = int(random(1, NUM_SIDES+1));
  }
}//rollDice

//--------------------------------------------------------------

void showDiceRoll() {
  for (int i=0; i<location.length; i++) {
    drawDie(i, location[i]);
  }
}//showDiceRoll

//***** ALSO CHANGE mouseClicked() IN THE PLACE INDICATED *****
//***** TO MATCH THE NAME OF YOUR DICE ARRAY VARIABLE *****

//-------- Lab 11 Bronze -------------------------------------

int[] freqCount(int[] roll) {
  for (int i=0; i<roll.length; i++) {
    for (int j=0; j<arr.length; j++) {
      if (roll[i]==j+1) {
        arr[j] += 1;
      }
    }
  }
  println(arr);
  return arr;
}//freqCount

int maxOfAKind(int[] freqs) {
  int max = 0;
  for (int i=0; i<freqs.length; i++) {
    if (max<freqs[i]) {
      max = freqs[i];
    }
  }
  return max;
}//maxOfAKind



void setup() {
  size(500, 500);
  displayMessage("Click to roll");
}//setup

//--------------------------------------------------------------

void draw() {
}//draw

//--------------------------------------------------------------

void mouseClicked() {
  background(192);
  rollDice();
  showDiceRoll();
  displayStats(location); //*****CHANGE TO THE NAME OF YOUR VARIABLE
}

//--------------------------------------------------------------

void displayMessage(String message) {
  //Display the given message in the centre of the window.
  final int TEXT_SIZE = 20;
  textSize(TEXT_SIZE);
  fill(0);
  //Allow for multi-line messages. Count the \n characters to see.
  int numLines = 1; //One by default
  for (int i=0; i<message.length(); i++)
    if (message.charAt(i) == '\n')
      numLines++; //Add one more line for every \n character found
  text(message, (width-textWidth(message))/2, 
    height/2-TEXT_SIZE*numLines/2);
}

//--------------------------------------------------------------

void displayStats(int[] theDice) {
  //Test the freqCount and maxOfAKind functions by calling them
  //and displaying the results as a message.
  int[] freqs = freqCount(theDice);
  int maxFreq = maxOfAKind(freqs);
  String message = "Frequencies of 1.."+NUM_SIDES+" are:\n";
  for (int i=0; i<NUM_SIDES; i++)
    message += freqs[i]+"   ";
  message += "\nLargest one is "+maxFreq+" of a kind.\n";
  message += "Click to roll again.";
  displayMessage(message);
}

//--------------------------------------------------------------

void drawDie(int position, int value) {
  /* Draw one die in thecanvas.
   * **This will only work for dice with up to 6 sides.**
   *   position - must be 0..NUM_DICE-1, indicating which die is being drawn
   *   value - must be 1..6, the amount showing on that die
   */
  final float X_SPACING = (float)width/NUM_DICE;       //X spacing of the dice
  final float DIE_SIZE = X_SPACING*0.8;    //width and height of one die
  final float X_LEFT_DIE = X_SPACING*0.1;  //left side of the leftmost die
  final float Y_OFFSET = X_SPACING*0.15;   //slight Y offset of the odd-numbered ones
  final float Y_POSITION = height-DIE_SIZE-Y_OFFSET; //Y coordinate of most dice
  final float PIP_OFFSET = DIE_SIZE/3.5;  //Distance from centre to pips, and between pips
  final float PIP_DIAM = DIE_SIZE/5;    //Diameter of the pips (dots)

  //From the constants above, and which die it is, find its top left corner
  float dieX = X_LEFT_DIE+position*X_SPACING;
  float dieY = Y_POSITION-Y_OFFSET*(position%2);

  //1.Draw a red square with a black outline
  stroke(0); //Black outline
  fill(255, 0, 0); //Red fill
  rect(dieX, dieY, DIE_SIZE, DIE_SIZE);

  //2.Draw the pips (dots)
  fill(255);   //White dots
  stroke(255); //White outline

  //The centre dot (if the value is odd)
  if (1 == value%2)
    ellipse(dieX+DIE_SIZE/2, dieY+DIE_SIZE/2, PIP_DIAM, PIP_DIAM);

  //The top-left and bottom-right dots (if the value is more than 1)
  if (value>1) {
    ellipse(dieX+DIE_SIZE/2-PIP_OFFSET, 
      dieY+DIE_SIZE/2+PIP_OFFSET, PIP_DIAM, PIP_DIAM);
    ellipse(dieX+DIE_SIZE/2+PIP_OFFSET, 
      dieY+DIE_SIZE/2-PIP_OFFSET, PIP_DIAM, PIP_DIAM);
  }//if

  //The bottom-left and top-right dots (if the value is more than 3)
  if (value>3) {
    ellipse(dieX+DIE_SIZE/2+PIP_OFFSET, 
      dieY+DIE_SIZE/2+PIP_OFFSET, PIP_DIAM, PIP_DIAM);
    ellipse(dieX+DIE_SIZE/2-PIP_OFFSET, 
      dieY+DIE_SIZE/2-PIP_OFFSET, PIP_DIAM, PIP_DIAM);
  }//if

  //The left and right dots (if the value is 6 or more)
  if (value>=6) {
    ellipse(dieX+DIE_SIZE/2-PIP_OFFSET, 
      dieY+DIE_SIZE/2, PIP_DIAM, PIP_DIAM);
    ellipse(dieX+DIE_SIZE/2+PIP_OFFSET, 
      dieY+DIE_SIZE/2, PIP_DIAM, PIP_DIAM);
  }//if

  //The top and bottom centre dots (if the value is 8 or more)
  //Normal dice don't have these, but this function allows for
  //dice with up to 9 "sides" (values from 1-9).
  if (value>=8) {
    ellipse(dieX+DIE_SIZE/2, 
      dieY+DIE_SIZE/2-PIP_OFFSET, PIP_DIAM, PIP_DIAM);
    ellipse(dieX+DIE_SIZE/2, 
      dieY+DIE_SIZE/2+PIP_OFFSET, PIP_DIAM, PIP_DIAM);
  }//if
}//drawDie
