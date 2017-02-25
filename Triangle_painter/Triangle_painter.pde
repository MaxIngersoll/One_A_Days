PImage img1;
color col;
int x;
int y;
int range;
void setup(){
  img1 = loadImage("MaxPortrait1.jpg");
  noStroke();
}

void draw(){
  x = int(random(0,width));
  y = int(random(0,height));
  col = img1.get(x,y);
  fill(col);
  beginShape();
  vertex(x, y);
  vertex(x+random(0,range), y+random(0,range));
  vertex(x+random(0,range), y+random(0,range));
  endShape();
}