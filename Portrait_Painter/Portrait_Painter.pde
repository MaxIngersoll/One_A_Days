float anger, contempt, disgust, fear, happiness;
float neutral, sadness, surprise;
int curX, curY;
int prevX, prevY;

PImage img;
PImage curImg;
boolean yes;
boolean on = false;
int counter;
void setup() {
  size(960, 960);
  frameRate(100);
  img = loadImage("MaxPortrait1.jpg");
  curImg = loadImage("MaxPortrait1.jpg");

  image(img, 0, 0);
  imageMode(CENTER);

  //background(0,125);
  curX = 1;
  curY = 1;
  prevX = 1;
  prevY = 1;
  yes = false;
  curImg = blur(10);
  //curImg = threshold(.8);
  //curImg = posterize(2);
  //curImg = grayscale();

  //background(200,125);
  contempt = .6;
  counter=0;
}

void draw() {
  if (sadness > .5) {
    curImg = blur(20);
    for (int i = 0; i<5; i++) {
      dripPaintVert(20);
      //if(counter == 50){
      //PImage img2 = new PImage();
      //img2 = img;
      //tint(255, 1);
      //image(img2,width/2,height/2);
      counter = 0;
      //}
    }
    counter++;
  }
  if (anger > .5) {
    curImg = threshold(.8);
    for (int i = 0; i<100; i++) {
      int val = int(random(3, 8));
      int x = getRandPosition("xDim");
      int y = getRandPosition("yDim");
      color pix = curImg.get(x, y);
      noStroke();
      fill(pix, 125);
      ellipse(x, y, val, val);
      x = getRandPosition("xDim");
      y = getRandPosition("yDim");
      pix = curImg.get(x, y);
      streaks(x, y, 2, 1, false, true, pix);
      if (i==99)
        streaks(x, y, 20, 10, false, true, pix);
    }
  }
  if (contempt > .5) {
    curImg = grayscale();
    for (int i=0; i<500; i++) {
      int x = getRandPosition("xDim");
      int y = getRandPosition("yDim");
      color pix = curImg.get(x, y);
      streaks(x, y, 5, 2, false, false, pix);
      if (counter == 40) {
        int val = int(random(50, 200)); 
        fill(pix, 60);
        stroke(pix, 150);
        ellipse(x, y, val+random(-5, 5), val+random(-5, 5));
        counter = 0;
      }
    }
    counter ++;
  }
  if (disgust > .5) {
    curImg = posterize(4);
    for (int i =0; i<100; i++) {
      int x = getRandPosition("xDim");
      int y = getRandPosition("yDim");
      color pix = curImg.get(x, y);
      streaks(x, y, 5, 2, false, false, pix);
      if (counter == 5) {
        int val = int(random(50, 200)); 
        fill(pix, 60);
        stroke(pix, 150);
        streaks(x, y, 150, 2, false, false, pix);
        //ellipse(x, y, val+random(-5, 5), val+random(-5, 5));
        counter = 0;
      }
    }
    counter ++;
  }
  if (fear > .5) {
    curImg = img;
    curImg = threshold(0.8);
    for (int i =0; i<100; i++) {
      int x = getRandPosition("xDim");
      int y = getRandPosition("yDim");
      color pix = img.get(x, y);
      streaks(x, y, 10, 4, true, false, pix);
      if (counter==2) {
        stroke(200, 0, 0, 200);
        //color pix2 = curImg.get(x,y);
        streaks(x, y, 150, 30, false, false, color(200, 0, 0, 125));
        counter = 0;
      }
    }
    counter++;
  }
  if (happiness > .5) {
    for (int i =0; i<300; i++) {
      int x = getRandPosition("xDim");
      int y = getRandPosition("yDim");
      color pix = img.get(x, y);
      fill(pix);
      streaks(x, y, 4, 2, false, false, pix);
      if (counter == 20) {
        int val = int(random(50, 400)); 
        int col = int(random(0, 3));
        if (col==0)
          fill(0, 200, 200, 100);
        else if (col==1)
          fill(255, 255, 0, 100);
        else if (col==2)
          fill(255, 0, 255, 100);
        noStroke();
        //stroke(pix, 150);
        //streaks(x, y, 150, 2, false, false, pix);
        ellipse(x, y, val+random(-5, 5), val+random(-5, 5));
        counter = 0;
      }
    }
    counter ++;
  }
  if (neutral > .5) {
    for (int i =0; i<200; i++) {
      int x = getRandPosition("xDim");
      int y = getRandPosition("yDim");
      color pix = img.get(x, y);
      fill(pix, 150);
      int val1 = int(random(3, 8));
      noStroke();
      ellipse(x, y, val1, val1);
      if (counter%25==0&&i%3==0) {
        x = getRandPosition("xDim");
        y = getRandPosition("yDim");
        pix = img.get(x,y);
        streaks(x, y, 20, 10, false, true, pix);
        counter = 0;
      } 

    }
    counter++;
  }
  if (surprise > .5) {
  }

  //if (frameCount % 250 == 0)
  //  System.out.println(frameCount/(millis()/1000) + " frames per second");
}
void mousePressed() {
  if (!on) {
    on = true; 
    curImg = threshold(.8);
  } else {
    on = false;
    curImg = blur(10);
  }
}

void keyPressed() {
  curImg = posterize(2);
}


// Returns a random position. Input "xDim" for x coord, and anything for y coord
int getRandPosition(String dimension) {
  if (dimension == "xDim")
    return int(random(0, width));
  return int(random(0, height));
}

//void pointillize()

void streaks(int x1, int y1, float streakLength, float thickness, boolean straightLines, boolean droopy, color col) {
  noFill();
  stroke(col);
  strokeWeight(random(1, thickness));
  if (straightLines) {
    line(x1, y1, x1+random(-streakLength, streakLength), y1+random(-streakLength, streakLength));
    return;
  }
  if (droopy) {
    curve(x1, y1, x1, y1+random(-streakLength, 0), x1, y1+random(-streakLength, 0), 
      x1, y1+random(-streakLength, 0));
  }
  curve(x1, y1, x1+random(-streakLength, streakLength), y1+random(-streakLength, streakLength), x1+random(-streakLength, streakLength), y1+random(-streakLength, streakLength), 
    x1+random(-streakLength, streakLength), y1+random(-streakLength, streakLength));
}