import controlP5.*;


ControlP5 cp5;
Talker talker;  // Create object from Serial class
public String val;     // Data received from the serial port
int Servo1 = 0;

void setup()
{
  size(700,400);
  talker = new Talker(this,19200,"COM8");
  //talker.waitUntilConnect();
  cp5 = new ControlP5(this);
  cp5.addSlider("Servo0")
     .setPosition(100,100+26*0)
     .setRange(0,180)
     .setSize(400,25);
  cp5.addSlider("Servo1")
     .setPosition(100,100+26*1)
     .setRange(0,180)
     .setSize(400,25);
  cp5.addSlider("Servo2")
     .setPosition(100,100+26*2)
     .setRange(0,180)
     .setSize(400,25);
  cp5.addSlider("Servo3")
     .setPosition(100,100+26*3)
     .setRange(0,180)
     .setSize(400,25);

}

void draw()
{
  background(128);
  /*String s = "Hello" + i++;
  talker.send(s);
  println("Hello SEND " + i);*/
  if( talker.available() > 0) 
  {
    val = talker.readStringUntil('\n');
    print(val);
  }
  /*delay(1000);*/
}

void Servo0(float theDegree) {
  String s = "0:" + (int)theDegree;
  talker.send(s);
  //println(s);
}

void Servo1(float theDegree) {
  String s = "1:" + (int)theDegree;
  talker.send(s);
  //println(s);
}

void Servo2(float theDegree) {
  String s = "2:" + (int)theDegree;
  talker.send(s);
  //println(s);
}

void Servo3(float theDegree) {
  String s = "3:" + (int)theDegree;
  talker.send(s);
  //println(s);
}
