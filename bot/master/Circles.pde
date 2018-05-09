import java.nio.*;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.MatOfRect;
import org.opencv.core.MatOfPoint;
import org.opencv.core.MatOfPoint2f;
import org.opencv.core.MatOfInt;
import org.opencv.core.MatOfFloat;
import org.opencv.core.Rect;
import org.opencv.core.Scalar;
import org.opencv.core.Size;
import org.opencv.core.Point;
import org.opencv.calib3d.Calib3d;
import org.opencv.core.CvException;
import org.opencv.core.Core.MinMaxLocResult;
import org.opencv.video.BackgroundSubtractorMOG;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.imgproc.Imgproc;
import gab.opencv.*;

class Circle
{
  public float x,y,r;
  
  Circle(float x,float y,float r)
  {
    this.x = x;
    this.y = y;
    this.r = r;
  }
}

ArrayList<Circle> detectCircle(PImage image)
{
    ArrayList<Circle> result = new ArrayList<Circle>();
    
    Mat circleMat = new Mat();
    Mat grey = toMat(image);
    Imgproc.cvtColor(grey, grey, Imgproc.COLOR_BGR2GRAY, 0);
    double minRadius = 1;
    if(!grey.empty()){
      Imgproc.HoughCircles( grey, circleMat , Imgproc.CV_HOUGH_GRADIENT , 1 , minRadius);
      for (int i = 0; i < circleMat.cols(); i++) {
          double[] coords = circleMat.get(0, i);
          result.add(new Circle((float)coords[0], (float)coords[1],(float) coords[2]));
      }
      println("into");
    }
    
    
    return result;
}

void runCircleDetection()
{
  ArrayList<Circle> cs = detectCircle(dst);
  println("Circle Found : " + cs.size() );
  noFill();
  strokeWeight(3);
  for (Circle c : cs)
  {
    stroke(0, 255, 0);
    ellipse(c.x,c.y,c.r,c.r);
  }
}

// Convert PImage (ARGB) to Mat (CvType = CV_8UC4)
Mat toMat(PImage image) {
  int w = image.width;
  int h = image.height;
  
  Mat mat = new Mat(h, w, CvType.CV_8UC4);
  byte[] data8 = new byte[w*h*4];
  int[] data32 = new int[w*h];
  arrayCopy(image.pixels, data32);
  
  ByteBuffer bBuf = ByteBuffer.allocate(w*h*4);
  IntBuffer iBuf = bBuf.asIntBuffer();
  iBuf.put(data32);
  bBuf.get(data8);
  mat.put(0, 0, data8);
  
  return mat;
}

// Convert Mat (CvType=CV_8UC4) to PImage (ARGB)
PImage toPImage(Mat mat) {
  int w = mat.width();
  int h = mat.height();
  
  PImage image = createImage(w, h, ARGB);
  byte[] data8 = new byte[w*h*4];
  int[] data32 = new int[w*h];
  mat.get(0, 0, data8);
  ByteBuffer.wrap(data8).asIntBuffer().get(data32);
  arrayCopy(data32, image.pixels);
  
  return image;
}
