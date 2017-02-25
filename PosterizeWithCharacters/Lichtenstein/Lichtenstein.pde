

PImage img1;
PImage img2;
float threshold;
float bright;
float dotSize;
color deepRed = color(185, 50, 50);
color paleYellow = color(255, 253, 176);

void setup() {
  img1 = loadImage("MaxPortrait1.jpg");
  img2 = loadImage("MaxPortrait1.jpg");
  size(960, 960);
  ellipseMode(RADIUS);
  threshold = 200;
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      bright = brightness(img1.get(x, y));
      if (bright<threshold)
        img2.set(x, y, deepRed);
      else
        img2.set(x, y, paleYellow);
    }
  }
  image(img2, 0, 0);

  for (int x=0; x<width; x+=3) {
    for (int y=0; y<height; y+=3) {
      bright = brightness(img1.get(x, y));
      dotSize = map(bright, 0, 255, 0, 1.5);
      if (bright<threshold)
        fill(paleYellow);
      else
        fill(deepRed);
      ellipse(x, y, dotSize, dotSize);
    }
  }
}


void draw() {
}