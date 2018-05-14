import gab.opencv.*;
import g4p_controls.*;
import java.awt.Rectangle;
import java.util.LinkedList;
import java.util.Queue;

OpenCV opencv;

String url="http://192.168.0.3:8080/shot.jpg";
//String url = "face.jpg";
PImage src,dst;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

PApplet appc = null;

void initIP()
{
    //size(1080, 720);
    src = loadImage(url);
    src.resize(1080,720);
    opencv = new OpenCV(this,src);
    //createGUI();
}


void loopIP(PApplet app)
{
  if(appc == null) appc = app;
  src = loadImage(url);
  src.resize(1080,720);
  opencv.loadImage(src);
  opencv.blur( 13 );
  opencv.gray();
  opencv.threshold(70);
  
  dst = opencv.getSnapshot();

  
  
  
  appc.image(src, 0, 0);
  //image(dst, 0, 0);
  //image_icon.setIcon(src,1,GAlign.LEFT ,GAlign.TOP);
  appc.noFill();
  appc.strokeWeight(3);
  appc.stroke(0, 255, 0);
  //cascadeDetector();
  detectContours();
}

void cascadeDetector()
{
  Rectangle[] rs = opencv.detect();
  println("found " + rs.length + " objects");
  for(Rectangle r : rs)
  {
    appc.rect(r.x,r.y,r.width,r.height);
  }
}

public Queue<Point> pointQueue = new LinkedList();
public boolean isActive = false;
public Point currentPoint = null;

void runThreadJob()
{
  if(currentPoint != null )handOverCoords(currentPoint);
  isActive = false;
  currentPoint = null;
}

void detectContours()
{
  contours = opencv.findContours();
  //println("found " + contours.size() + " contours");
  
  
  for (Contour contour : contours) {
    appc.stroke(0, 255, 0);
    Rectangle  r = contour.getBoundingBox();
    ///println("de Object " , r);
    if( detectObject(r,contour) )
    {
      contour.draw();
      appc.rect(r.x,r.y,r.width,r.height);
      Point p = calCenter(r);
      println("Found Object " , p);
      if( pointQueue.size() > 10 )
      {
        Point rp = pointQueue.remove();
        if( Math.abs(rp.x - p.x) < 10 && Math.abs(rp.y - p.y) < 10 )
        {
          pointQueue.clear();
          currentPoint = p;
          if(isActive == false)
          {
            isActive = true;
            thread("runThreadJob");
          }
          
        }
      }
      pointQueue.add(p);
      //break;
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
  Point p = calCenter(r);
  boolean det = true;
  det = det && (p.x < 748 && p.x > 177 ) && (p.y < 390 && p.y > 0 );
  if( det == false ) return false;
  det = det && abs(pts.get(0).x - pts.get(contour.numPoints()-1).x ) < 10 && abs(pts.get(0).y - pts.get(contour.numPoints()-1).y ) < 10 ; 
  if(  det == false ) return false;
  int area = r.width * r.height;
  det = det && ( area < 14300 && area > 3180) ;
  if(  det == false) return false;
  return true;
}

Point calCenter(Rectangle  r)
{
  return new Point(r.width/2+r.x,r.height/2+r.y);
}

void saveImage()
{
  appc.save("snap.jpg");
}
