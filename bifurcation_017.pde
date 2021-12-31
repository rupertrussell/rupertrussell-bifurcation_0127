/*
For anyone interested, you can start with a bit of background here:
 https://en.wikipedia.org/wiki/Bifurcation_diagram
 
 For a briefer summary: This sketch feeds a massive array of values into an iterative formula,
 which lies somewhere between chaos & order.
 from: https://www.openprocessing.org/sketch/495138
 
 
 */

float iteration[][];
// A high density of values best illustrates the phenomenon,
// but is slow to run.  Adjust the variables to suit.
int bifurcationWidth = (8192/16)*4;
int bifurcationHeight = (128/16)*2;
float bifurcationPowers[];
int specificLine = 0;
int count, oldCount;

void setup() {
  size(1800, 600);
  colorMode(HSB);
  iteration  = new float[bifurcationWidth][bifurcationHeight];
  bifurcationPowers = new float[bifurcationWidth];
  for (int i = 0; i < bifurcationWidth; i++) {
    for (int j = 0; j < bifurcationHeight; j++) {
      //iteration[i][j] = random(1.0);
      iteration[i][j] = map(j, 0, bifurcationHeight, 0, 0.5);
    }
    bifurcationPowers[i] = map(i, 0, bifurcationWidth, 0.1, 0.0);
  }
  specificLine = int(random(bifurcationHeight));
  background(64);
}

void draw() {
  count ++;
  // Faking a transparent background to wash out older drawings
  fill(0, 20);
  rect(-1, -1, width+2, height+2);

  // Either draw a 2D grid of values...
  for (int j = 0; j < bifurcationHeight; j++) {
    // ... or watch the progress of a specific cross-section
    //int j = specificLine;
    stroke(j, 255, 255);
    stroke(j*(256/bifurcationHeight), 255, 255);  // adds colour
    for (int i = 0; i < bifurcationWidth; i++) {
      point(10+map(i, 0, bifurcationWidth, 0, 2000), height*(1-(float)iteration[i][j]));

      // The most interesting behaviour is found between 3 & 4
      // was float x = map(i, 0, bifurcationWidth, 2.5, 4);
      float x = map(i, 0, bifurcationWidth, 0.5, 4.5);
      // Calculate the position on the next frame
      iteration[i][j] = (x * iteration[i][j])*(1-iteration[i][j]);
    }
    // println("saved " + count + ".png");
    if (count == oldCount +5) {
      oldCount=count;
      save("0-4.5_" + count + ".png");
      count++;
    }
  }
}
