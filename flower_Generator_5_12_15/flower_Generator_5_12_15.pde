// MAX INGERSOLL
void setup()
{
  size(600, 600);
  background(20);
}

void draw()
{
  
}

void mousePressed()
{
  polarArray(10 - (int)random(0, 10), 3, mouseX, mouseY);
  polarArray(20 - (int)random(0, 10), 4, mouseX, mouseY);
  polarArray(30 - (int)random(0, 10), 3, mouseX, mouseY);
  
}
public void polarArray(int R, int r, int x, int y)
{
  int colorVal = (int)map(x, 0, width, 0, 255);
  int satVal = (int)map(y, 0, height, 0, 255);
  colorMode(HSB);
  float theta;
  float prevX = 0;
  float prevY = 0;
  float curX = 0;
  float curY = 0;
    for (int i = 0; i < 12; i++)
  {
    if (i > 0)
    {
    prevX = curX;
    prevY = curY;
    }
    theta = (2 * PI)/(12) * i;
    noStroke();
    fill(colorVal,satVal,255);
    curX = R * cos(theta) + x;
    curY = R * sin(theta) + y;
    ellipse(curX, curY, r, r);
   
//    if (i > 0)
//    line(prevX, prevY, curX, curY);
   }
}
