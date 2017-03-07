 PImage getScreen(){
  PImage prevImg;
  prevImg = new PImage();
  return prevImg.get();
}
void changeSaturation(float satLevel){
  
}
// postLevel should be 2-10, with 2 being the most intense
PImage posterize(float postLevel){
  PImage prevImg = get();
  filter(POSTERIZE, postLevel);
  curImg = get();
  image(prevImg,width/2,height/2);
  //return prevImg;
  return curImg;
}

void pointillize(){
  
}
// 5 is solid for blurLevel
PImage blur(PImage targetImg, float blurLevel){
 /* PImage prevImg = get();
  image(origImg,0,0);
  filter(BLUR, blurLevel);
  curImg = get();
  image(prevImg,0,0);
  */
  targetImg.filter(BLUR,blurLevel);
  return curImg;
}

//intensity should be from 0.1-0.9 0.8 looks good on maxportrait.jpg
PImage threshold(float intensity){
  PImage prevImg = get();
  image(origImg,0,0);
  filter(THRESHOLD,intensity);
  curImg = get();
  image(prevImg,0,0);
  return curImg;
}

PImage grayscale(){
 PImage prevImg = get();
 filter(GRAY);
 curImg = get();
 image(prevImg,width/2,height/2);
 return curImg;
}

PImage opencvThreshold(){
  PImage prevImg = get();
  opencv = new OpenCV(this, origImg);
  // but you can tell it explicitly to use color instead:
  opencv.useColor();  
  // if you convert the image to gray then you can
  // do gray-only operations
  opencv.gray();
  opencv.adaptiveThreshold(591, 1);
  gray = opencv.getSnapshot();
  curImg = get();
  //image(prevImg,0,0);
  return curImg;
}