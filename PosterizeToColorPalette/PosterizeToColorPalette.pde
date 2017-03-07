PImage img1;
PImage img2;
color[] colorPal;
void setup() {
  colorPal = new color[5];
  // Happy color palette
  /*colorPal[0] = color(255, 154, 85);
  colorPal[1] = color(255, 234, 108);
  colorPal[2] = color(84, 255, 251);
  colorPal[3] = color(231, 178, 255);
  colorPal[4] = color(137, 255, 204);
  */
  
  // Sad color palette
  colorPal[0] = color(36,36,36);
  colorPal[1] = color(84,68,68);
  colorPal[2] = color(118,118,97);
  colorPal[3] = color(129,146,121);
  colorPal[4] = color(193,190,132);


 
  img1 = loadImage("MaxPortrait1.jpg");
  img2 = loadImage("MaxPortrait1.jpg");
  size(960, 960);
}

void draw() {
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      int colorDif[] = new int[colorPal.length];
      color curCol = img1.get(x, y);
      int curColDif;
      int[] whichCol = {0,1000};
      for (int i=0; i<colorPal.length; i++) {
        curColDif = 0;
        curColDif += abs((curCol >> 16 & 0xFF)-(colorPal[i] >> 16 & 0xFF));
        curColDif += abs((curCol >> 8 & 0xFF)-(colorPal[i] >> 8 & 0xFF));
        curColDif += abs((curCol & 0xFF)-(colorPal[i] & 0xFF));
        colorDif[i] = curColDif;
        if(curColDif<whichCol[1]){
          whichCol[0] = i;
          whichCol[1] = curColDif;
        }
      }
        img2.set(x,y,colorPal[whichCol[0]]); 
    }
  }
  image(img2,0,0);
}