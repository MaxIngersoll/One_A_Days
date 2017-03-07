/*private void paint(PImage imgToPaint) {
  trace.paintStep(traceStep, visitedPixels, imgWidth, imgHeight, canvas, false);
          traceStep++;
}
 */

/*private void paint2(PImage img) {
  boolean wellPainted = false;
  if (invalidTrajectories>=maxInvalidTrajectories)
    continuePainting = false;
  else
    continuePainting = true;

  if (continuePainting) {
    int[] pixelCoords = new int[2];

    pixelCoords = selectPixelCoords(7/8, 7/8);
    curCol = get(pixelCoords[0], pixelCoords[1]);
    origCol = img.get(pixelCoords[0], pixelCoords[1]);
    if (curCol!=origCol) {
      wellPainted = abs(((origCol >> 16) & 0xff) - ((curCol >> 16) & 0xff)) < maxColorDiff[0]
        && abs(((origCol >> 8) & 0xff) - ((curCol >> 8) & 0xff)) < maxColorDiff[1]
        && abs((origCol & 0xff) - (curCol & 0xff)) < maxColorDiff[2];
    }
    if (!wellPainted&&wasEmpty) {
      streaks(pixelCoords[0], pixelCoords[1], 80, 20, false, false, img.get(pixelCoords[0], pixelCoords[1]));
    }
    else if(!wellPainted&&!wasEmpty){
      streaks(pixelCoords[0], pixelCoords[1], 80, 20, false, false, img.get(pixelCoords[0], pixelCoords[1]));
      invalidTrajectories ++;
    }
  }
}
*/
/*private int[] selectPixelCoords(float xPercentage, float yPercentage) {
  int[] coords = new int[2];
  if (int(random(0, 1))==0) {
    coords[0] = int(random(0, imgWidth));
    if (int(random(0, 1))==0)
      coords[1] = imgHeight/2 + int((random((yPercentage*imgHeight), imgHeight))/2);
    else {
      coords[1] = imgHeight/2 - int((random((yPercentage*imgHeight), imgHeight))/2);
    }
  }
  return coords;
  */