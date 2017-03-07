// identifies face and returns 4 numbers (coords of the top left vertex
// of the face rectangle, and the width and height) 
private int[] getFaceCoords(){
 // PImage prevImg = get();
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
  //image(opencv.getInput(), 0, 0);
    //rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
    int[] coords = new int[4];
    coords[0] = faces[0].x;
    coords[1] = faces[0].y;
    coords[2] = faces[0].width;
    coords[3] = faces[0].height;
//image(prevImg,0,0);
//background(20,200,20);
    return coords;
}

private color getBackgroundColor(){
  return color(0);
}