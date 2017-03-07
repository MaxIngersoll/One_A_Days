import gab.opencv.*;
import java.awt.Rectangle;
import java.util.Arrays;

OpenCV opencv;
Rectangle[] faces;

private boolean avoidBackgroundRegions = true;
private boolean[] visitedPixels;
private boolean[] similarColorPixels;
private Trace trace;
PImage origImg, curImg, curImg2, imgToPaint;
PImage threshold, blur, adaptive, gray;
private PGraphics canvas;
color curCol, origCol;
// Emotion values from Microsoft Emotion API
float anger, contempt, disgust, fear, happiness;
float neutral, sadness, surprise;
private float brushSizeDecrement = 1.3f;
private float sizeReductionFactor = 1.0f;
private float minTraceLength = 16;
private float averageBrushSize;
private float smallerBrushSize = 4;
private float traceSpeed = 2;
private float relativeTraceLength = 2.3f;
boolean trigger = false;
private int maxInvalidTrajectoriesForSmallerSize = 10000;
private int maxInvalidTrajectories = 5000;
private int maxInvalidTracesForSmallerSize = 350;
private int maxInvalidTraces = 250;
private int traceStep;
private int imgWidth;
private int imgHeight;
private int[] badPaintedPixels;
private int[] maxColorDiff = new int[] { 40, 40, 40 };
private int nBadPaintedPixels;
private int nTraces;
private int startTime;
int counter = 0;

color backgroundColor;
void setup() {


  size(960, 960);
  backgroundColor = color(255,0,0);
  frameRate(100);
  origImg = loadImage("MaxPortrait1.jpg");
  curImg = loadImage("MaxPortrait1.jpg");
  opencv = new OpenCV(this, "MaxPortrait1.jpg");
  imgWidth = round(origImg.width / sizeReductionFactor);
  imgHeight = round(origImg.height / sizeReductionFactor);

  // Sketch setup
  strokeCap(SQUARE);
  background(backgroundColor);

  canvas = null;

  int nPixels = imgWidth * imgHeight;
  similarColorPixels = new boolean[nPixels];
  visitedPixels = new boolean[nPixels];
  badPaintedPixels = new int[nPixels];
  nBadPaintedPixels = nPixels;

  visitedPixels = new boolean[nPixels];
  averageBrushSize = max(smallerBrushSize, max(imgWidth, imgHeight) / 6.0f);
  traceStep = 0;
  nTraces = 0;
  startTime = millis();
}

void draw() {

  if (trace == null) {
    trace = getValidTrace();
    traceStep = 0;
  }

  Sadness();

    origImg = imgToPaint;
    trace.paintStep(traceStep, visitedPixels, imgWidth, imgHeight, canvas, false); //<>//
    traceStep++;
    
    // Check if we finished painting the trace
    if (traceStep == trace.getNSteps()) {
      trace = null;
    }
  
  /* if(sadness > 0.5){
   
   }
   if(happiness > 0.5){
   
   }*/
}

private Trace getValidTrace() {
  // Update the similar color and bad painted pixel arrays
  updatePixelArrays();

  // Mask background regions if necessary
  if (avoidBackgroundRegions && nTraces == 0) {
    maskBackgroundRegions();
  }

  // Obtain a new valid trace
  Trace trace = null;
  boolean traceNotFound = true;
  int invalidTrajectoriesCounter = 0;
  int invalidTracesCounter = 0;
  PVector startingPosition = new PVector(0, 0);

  while (traceNotFound) {
    // Check if we should stop painting
    if (averageBrushSize == smallerBrushSize
      && (invalidTrajectoriesCounter > maxInvalidTrajectoriesForSmallerSize
      || invalidTracesCounter > maxInvalidTracesForSmallerSize)) {
      println("Total number of painted traces: " + nTraces); //<>//
      println("Processing time = " + (millis() - startTime) / 1000.0f + " seconds");

      // Stop the while loop
      trace = null;
      traceNotFound = false;
    } else {
      // Change the average brush size if there were too many invalid traces
      if (averageBrushSize > smallerBrushSize && (invalidTrajectoriesCounter > maxInvalidTrajectories
        || invalidTracesCounter > maxInvalidTraces)) {
        averageBrushSize = max(smallerBrushSize, 
          min(averageBrushSize / brushSizeDecrement, averageBrushSize - 2));

        println("Frame = " + frameCount + ", traces = " + nTraces + ", new average brush size = "
          + averageBrushSize);

        // Reset some of the variables
        invalidTrajectoriesCounter = 0;
        invalidTracesCounter = 0;

        // Reset the visited pixels array
        Arrays.fill(visitedPixels, false);

        // Mask background regions if necessary
        if (avoidBackgroundRegions) {
          maskBackgroundRegions();
        }
      }

      // Create new traces until one of them has a valid trajectory or we exceed a number of tries
      boolean validTrajectory = false;
      float brushSize = max(smallerBrushSize, averageBrushSize * random(0.95f, 1.05f));
      int nSteps = (int) (max(minTraceLength, relativeTraceLength * brushSize * random(0.9f, 1.1f))
        / traceSpeed);

      while (!validTrajectory && invalidTrajectoriesCounter % 500 != 499) {
        // Create the trace starting from a bad painted pixel
        int pixel = badPaintedPixels[floor(random(nBadPaintedPixels))];
        startingPosition.set(pixel % imgWidth, pixel / imgWidth);
        trace = new Trace(startingPosition, nSteps, traceSpeed);

        // Check if it has a valid trajectory
        validTrajectory = trace.hasValidTrajectory(similarColorPixels, visitedPixels, origImg);

        // Increase the counter
        invalidTrajectoriesCounter++;
      }

      // Check if we have a valid trajectory
      if (validTrajectory) {
        // Reset the invalid trajectories counter
        invalidTrajectoriesCounter = 0;

        // Set the trace brush size
        trace.setBrushSize(brushSize);

        // Calculate the trace colors and check that painting the trace will improve the painting
        if (trace.calculateColors(maxColorDiff, similarColorPixels, origImg, canvas, backgroundColor)) {
          // Test passed, the trace is good enough to be painted
          traceNotFound = false;
          nTraces++;
        } else {
          // The trace is not good enough, try again in the next loop step
          invalidTracesCounter++;
        }
      } else {
        // The trace is not good enough, try again in the next loop step
        invalidTrajectoriesCounter++;
        invalidTracesCounter++;
      }
    }
  }

  // Return the trace
  return trace;
}

/**
 * Updates the similar color and bad painted pixel arrays
 */
private void updatePixelArrays() {
  // Load the screen pixels
  loadPixels();

  // Update the arrays
  nBadPaintedPixels = 0;

  for (int x = 0; x < imgWidth; x++) {
    for (int y = 0; y < imgHeight; y++) {
      // Check if the pixel is well painted
      boolean wellPainted = false;
      int imgPixel = x + y * imgWidth;
      int paintedCol = pixels[x + y * width];
      int originalCol = origImg.pixels[imgPixel];

      if (paintedCol != backgroundColor) {
        wellPainted = abs(((originalCol >> 16) & 0xff) - ((paintedCol >> 16) & 0xff)) < maxColorDiff[0]
          && abs(((originalCol >> 8) & 0xff) - ((paintedCol >> 8) & 0xff)) < maxColorDiff[1]
          && abs((originalCol & 0xff) - (paintedCol & 0xff)) < maxColorDiff[2];
      } else if (originalCol == backgroundColor) {
        wellPainted = avoidBackgroundRegions;
      }

      similarColorPixels[imgPixel] = wellPainted;

      if (!wellPainted) {
        badPaintedPixels[nBadPaintedPixels] = imgPixel;
        nBadPaintedPixels++;
      }
    }
  }

  // Update the screen pixels
  updatePixels();
}
private void maskBackgroundRegions() {
  // Load the screen pixels
  loadPixels();

  // Mask all pixels in the canvas and the original image with a color equal to the background color
  for (int x = 0; x < imgWidth; x++) {
    for (int y = 0; y < imgHeight; y++) {
      int imgPixel = x + y * imgWidth;

      if (pixels[x + y * width] == backgroundColor && origImg.pixels[imgPixel] == backgroundColor) {
        visitedPixels[imgPixel] = true;
      }
    }
  }

  // Update the screen pixels
  updatePixels();
}