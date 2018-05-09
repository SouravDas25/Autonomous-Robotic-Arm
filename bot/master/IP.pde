import gab.opencv.*;
import g4p_controls.*;
import java.awt.Rectangle;

OpenCV opencv;

String url="http://192.168.0.2:8080/shot.jpg";
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
      handOverCoords(p);
      println("Found Object " , p);
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
  boolean det = true;
  det = det && (r.x < 800 && r.x > 268 ) && (r.y < 700 && r.y > 100 );
  if( det == false ) return false;
  det = det && abs(pts.get(0).x - pts.get(contour.numPoints()-1).x ) < 10 && abs(pts.get(0).y - pts.get(contour.numPoints()-1).y ) < 10 ; 
  if(  det == false ) return false;
  //det = det && (abs(r.width - 118) < 25 || abs(r.width - 45) < 25) ;//&& abs(r.width/r.height) < 1.2 && abs(r.width/r.height) > 0.8;
  //if(  det == false) return false;
  Point p = calCenter(r);
  color c = get((int)p.x, (int)p.y);
  println("color",c,color(0,0,0));
  det = det && c == color(0,0,0);
  if( det == false) return false;
  //println(pts.get(0),pts.get(contour.numPoints()-1));
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
