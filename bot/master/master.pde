import g4p_controls.*;

Talker talker;  // Create object from Serial class
Arm arm;
public String val;     // Data received from the serial port
int Servo1 = 0;

void setup()
{
  size(700,400);
  talker = new Talker(this,28800,"COM8");
  talker.waitUntilConnect();
  arm = new Arm();
  createGUI();
  initIP();
} 

void draw()
{
  background(128);
  if( talker.available() > 0) 
  {
    val = talker.readStringUntil('\n');
    if(val != null )
    print("Received : ",val);
  }
}

void handOverCoords(Point p)
{
  //Home();
  float x = (float)p.x+70;
  float y = (p.y < 250) ? (float)p.y+70 : (float)p.y - (float)(p.y-250)/2 ;
  int z = 70;
  /*float theta = radians(17.5);
  x = x*cos(theta)+y*sin(theta);
  y = -x*sin(theta)+y*cos(theta);*/
  x = abs(893 - x)  ;
  y = 470 - y ;
  float theta = (float)Math.atan2(y,x);
  x = x/3;
  y = x * tan(theta);
  println(x,y,z);
  //arm.setCoordinate((int)x,(int)y,50);
  //delay(5000);
  IPpick((int)x,(int)y);
}

int gx=50,gy=50,gz=50,diff = 5;
boolean gp = true;

void keyPressed() {
    if (key == 'w') {
      gx+=diff;
      arm.setCoordinate(gx,gy,gz);
    } 
    if (key == 's') {
      gx-=diff;
      arm.setCoordinate(gx,gy,gz);
    } 
    if (key == 'a') {
      gy+=diff;
      arm.setCoordinate(gx,gy,gz);
    } 
    if (key == 'd') {
      gy-=diff;
      arm.setCoordinate(gx,gy,gz);
    } 
    if (key == 'e' ) {
      gz+=diff;
      arm.setCoordinate(gx,gy,gz);
    } 
    if (key == 'q'  ) {
      gz-=diff;
      arm.setCoordinate(gx,gy,gz);
    } 
    if ( key == 'g' ) {
      if(gp)
      {
        arm.closeGripper();
      }
      else 
      {
        arm.openGripper();
      }
      gp = !gp;
    }
    
    //println("NOW Cord" , gx,gy,gz);
    //displayCoords();
    //displayAngles();
}
