
// public int lastSendTIme = millis(),delaytime = 500;

void fetchAngle(int servo,GSlider slider)
{
  int a0 = slider.getValueI();
  arm.setAngle(servo,a0);
  displayCoords();
}

void fetchGripper(GSlider slider)
{
  int a0 = slider.getValueI();
  arm.setGripper(a0);
  displayCoords();
}

void displayCoords()
{
  PVector t = arm.getCoord();
  //println("Target : ",t);
  coordinate_x.setText(""+t.x);
  coordinate_y.setText(""+t.y);
  coordinate_z.setText(""+t.z);
  //println("Target : ",t);
}

void displayAngles()
{
  slider1.setValue(arm.getAngle(0));
  slider4.setValue(arm.getAngle(1));
  slider3.setValue(arm.getAngle(2));
}

void fetchCoords()
{
  int x = parseInt(coordinate_x.getText());
  int y = parseInt(coordinate_y.getText());
  int z = parseInt(coordinate_z.getText());
  println("\nNEW COORDS");
  println(x,y,z);
  arm.setCoordinate(x,y,z);
  displayAngles();
}



void move()
{
  /*yside();
  xside();
  zside();*/
  pickup();
  //drawRectangle();
}

void pickup()
{
  Home();
  arm.openGripper();
  delay(mutualdelay);
  arm.setCoordinate(50,50,70);
  delay(mutualdelay);
  arm.setCoordinate(50,50,10);
  delay(mutualdelay+500);
  arm.setGripper(30);
  delay(mutualdelay+200);
  arm.setCoordinate(50,50,70);
  delay(mutualdelay+500);
  Home();
  int ym = -10;
  int xm = 90;
  arm.setCoordinate(xm-20,ym,90);
  delay(mutualdelay);
  arm.setCoordinate(xm+5,ym,65);
  delay(mutualdelay);
  arm.setCoordinate(xm,ym,50);
  delay(mutualdelay+500);
  arm.setCoordinate(xm,ym,40);
  delay(mutualdelay+500);
  arm.openGripper();
  delay(mutualdelay);
  arm.setCoordinate(xm,ym,90);
  delay(mutualdelay);
  Home();
  arm.closeGripper();
  //delay(mutualdelay);
}

public int mutualdelay = 1000;

void drawRectangle()
{
  int z;
  z = 35;
  Home();
  arm.closeGripper();
  delay(mutualdelay);
  arm.setCoordinate(70,30,z);
  delay(mutualdelay);
  arm.setCoordinate(70,1,z);
  delay(mutualdelay);
  arm.setCoordinate(150,1,z);
  delay(mutualdelay);
  arm.setCoordinate(150,1,z+50);
  delay(mutualdelay);
  Home();
  arm.setCoordinate(70,30,z+50);
  delay(mutualdelay);
  arm.setCoordinate(70,30,z);
  delay(mutualdelay);
  arm.setCoordinate(130,70,z);
  delay(mutualdelay+500);
  arm.setCoordinate(150,1,z);
  delay(mutualdelay);
  arm.setCoordinate(150,1,z+50);
  delay(mutualdelay);
  Home();
}

void drawTriangle()
{
  int x,y,z,h,b;
  x = 50;
  y = 50;
  z = 70;
  h = 100;
  b = 100;
  arm.setCoordinate(x,y,z);
  delay(mutualdelay);
  arm.setCoordinate(x-b/2,y+h,z);
  delay(mutualdelay);
  arm.setCoordinate(x-b,y,z);
  delay(mutualdelay);
  arm.setCoordinate(x,y,z);
  delay(mutualdelay);
}

void Home()
{
  arm.setCoordinate(50,1,(int)arm.getz());
  delay(mutualdelay);
  arm.setCoordinate(50,1,70);
  delay(mutualdelay);
}

void zside()
{
  for(int i= 30 ;i < 160 ; i+= 10)
  {
    arm.setCoordinate(80,1,i);
    delay(mutualdelay);
  }
}

void yside()
{
  for(int i= -71 ;i < 70 ; i+= 10)
  {
    arm.setCoordinate(65,i,70);
    delay(mutualdelay);
  }
}

void xside()
{
  for(int i= 30 ;i < 140 ; i+= 10)
  {
    arm.setCoordinate(i,1,70);
    delay(mutualdelay);
  }
}
