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
PImage blur(float blurLevel){
  PImage prevImg = get();
  filter(BLUR, blurLevel);
  curImg = get();
  image(prevImg,width/2,height/2);
  return curImg;
}
//intensity should be from 0.1-0.9 0.8 looks good on maxportrait.jpg
PImage threshold(float intensity){
  PImage prevImg = get();
  filter(THRESHOLD,intensity);
  curImg = get();
  image(prevImg,width/2,height/2);
  return curImg;
}

PImage grayscale(){
 PImage prevImg = get();
 filter(GRAY);
 curImg = get();
 image(prevImg,width/2,height/2);
 return curImg;
}