// MAX INGERSOLL
void setup()
{
  size(700, 700);
  background(20);
}

int counter = 0;
boolean countUp = true;
void draw()
{
  if (counter % 50 == 0)
  background(20);
  if (counter == 150)
    countUp = false;
    
  if (counter == 0)
    countUp = true;

 
  for ( int i = 5 ; i < 100 ; i++ )  {
    polarArray(i*4 + 60, i, width/2, height/2, 2*(int)random(counter));
  }
  if ( counter%10 == 0)
    polarArray(200, 4, width/2, height/2, 2*-counter);
  if ( counter%10 == 0)  {
    for ( int i = 5 ; i < 300 ; i+=5 )  {
    polarArray(i, 1, width/2, height/2, 2*(int)random(counter));
    }
  }
  if (countUp == true)
  counter ++;
  else
  counter --;
}

void mousePressed()
{
 
  
}
public void polarArray(int R, int r, int x, int y, int counter)
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
    curX = (R + counter) * cos(theta) + x;
    curY = (R - counter) * tan(theta) + y;
    ellipse(curX, curY, r, r);
   
//    if (i > 0)
//    line(prevX, prevY, curX, curY);
   }

}
