import gab.opencv.*;

OpenCV opencv;

String url="http://192.168.43.1:8080/shot.jpg";

PImage src,dst;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

void setup()
{
    size(1080, 720);
    src = loadImage(url);
    src.resize(1080,720);
    opencv = new OpenCV(this,src);
}


void draw()
{
  src = loadImage(url);
  src.resize(1080,720);
  opencv.loadImage(src);
  opencv.gray();
  opencv.threshold(70);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  
  image(src, 0, 0);
  image(dst, src.width, 0);
  
  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
  
}
