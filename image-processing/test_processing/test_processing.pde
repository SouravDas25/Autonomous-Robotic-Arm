import gab.opencv.*;
import g4p_controls.*;
import java.awt.Rectangle;

OpenCV opencv;

String url="http://192.168.0.2:8080/shot.jpg";
//String url = "face.jpg";
PImage src,dst;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

void setup()
{
    size(1080, 720);
    src = loadImage(url);
    src.resize(1080,720);
    opencv = new OpenCV(this,src);
    createGUI();
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}


void draw()
{
  src = loadImage(url);
  src.resize(1080,720);
  opencv.loadImage(src);
  opencv.blur( 13 );
  opencv.gray();
  opencv.threshold(70);
  
  dst = opencv.getSnapshot();

  
  
  
  image(src, 0, 0);
  //image(dst, 0, 0);
  //image_icon.setIcon(src,1,GAlign.LEFT ,GAlign.TOP);
  noFill();
  strokeWeight(3);
  stroke(0, 255, 0);
  //cascadeDetector();
  detectContours();
}

void cascadeDetector()
{
  Rectangle[] rs = opencv.detect();
  println("found " + rs.length + " objects");
  for(Rectangle r : rs)
  {
    rect(r.x,r.y,r.width,r.height);
  }
}

void detectContours()
{
  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    Rectangle  r = contour.getBoundingBox();
    if( detectObject(r,contour) )
    {
      contour.draw();
      rect(r.x,r.y,r.width,r.height);
      Point p = calCenter(r);
     
      println(p);
    }
    //double area = OpenCV.contourArea(contour);
    
    /*stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();*/
  }
}

boolean detectObject(Rectangle  r,Contour contour)
{
  ArrayList<PVector> pts = contour.getPoints();
  boolean det = Math.abs(r.width - 118) < 25 || Math.abs(r.width - 65) < 25;
  if( det ) return true;
  det = det && pts.get(0) == pts.get(contour.numPoints()-1);
  if( det ) return true;
  return false;
}

Point calCenter(Rectangle  r)
{
  return new Point(r.width/2+r.x,r.height/2+r.y);
}

void saveImage()
{
  save("snap.jpg");
}
