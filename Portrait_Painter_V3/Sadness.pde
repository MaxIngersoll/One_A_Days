private void Sadness() {
  if (!trigger) {
    curImg2 = new PImage();
    imgToPaint = new PImage();
    //curImg = origImg;
    int[] faceCoords = getFaceCoords();
    curImg = threshold(0.8);
    // curImg.filter(BLUR,2);// = blur(2);
    curImg = blur(curImg, 5);

    image(curImg, 0, 0);
    curImg2 = get(faceCoords[0], faceCoords[1], faceCoords[2], faceCoords[3]);
    image(origImg, 0, 0);
    curImg = origImg;
    curImg = grayscale();
    curImg = blur(curImg, 2);
    image(curImg, 0, 0);
    image(curImg2, faceCoords[0], faceCoords[1]);
    
    imgToPaint = get();
    trigger = true;
  }
 //<>//
 
   /*for (int i=0; i<500; i++) {
   int x = getRandPosition("xDim");
   int y = getRandPosition("yDim");
   color pix = imgToPaint.get(x, y);
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
   */
}

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

// Returns a random position. Input "xDim" for x coord, and anything for y coord
int getRandPosition(String dimension) {
  if (dimension == "xDim")
    return int(random(0, width));
  return int(random(0, height));
}