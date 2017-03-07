void dripPaint(int thickness) {
  for (int i = 0; i<1000; i++) {
    if (prevX%width!=0 && prevY%height!=0)
    {
      color pix = curImg.get(prevX%width, prevY%height);
      strokeWeight(thickness);
      stroke(pix);
      if (dist(prevX%width, prevY%height, curX%width, curY%height)<100)
        line(prevX%width, prevY%height, curX%width, curY%height);
      prevX = curX;
      prevY = curY;
      if (i%101==0)
        curX = int(curX+random(-1, 3));
    } else if (prevX%width==0) {
      curX ++;
      prevX ++;
    }
    if (prevY%height==0) {
      curY++;
      prevY++;
    }
  }
  curY = int(curY+random(1, 5));
}

void dripPaintVert(int thickness) {
  if (yes) {
    prevX = int(random(0, width));
    prevY = 0;
    yes = false;
  }
  for (int i=0; i<199; i++) {
    if (curY<height && dist(prevX%width, prevY%height, curX%width, curY%height)<100) {

      color pix = curImg.get(prevX%width, prevY%height);
      strokeWeight(thickness);
      stroke(pix);
      line(prevX%width, prevY%height, curX%width, curY%height);
      prevX = curX;
      prevY = curY;
      if (i%25==0)
        curX = int(curX+random(-1, 4));
      curY++;
    } else {
      prevX = int(random(0, width));
      prevY = 0;
      curX = prevX;
      curY = 0;
    }
  }
}


/*
 for (int i = 0; i < 100; i++)
 {
 int val = int(random(3, 8));
 int x = getRandPosition("xDim");
 int y = getRandPosition("yDim");
 color pix = curImg.get(x, y);
 noStroke();
 fill(pix, 125);
 //ellipse(x, y, val, val);
 x = getRandPosition("xDim");
 y = getRandPosition("yDim");
 pix = curImg.get(x, y);
 fill(pix, 125);
 //ellipse(x, y, val, val);
 System.out.println(frameCount);
 if (frameCount % 50 == 0) {
 if (yes)
 yes = false;
 else
 yes = true;
 }
 if (i%100 ==0)
 streaks(x, y, 20, 10, false, true, pix);
 else
 streaks(x, y, 2, 1, false, true, pix);
 }
 */