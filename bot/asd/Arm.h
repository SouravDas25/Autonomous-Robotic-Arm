#include <Servo.h>
#include "input.h"

#define no_of_servos 4
#define notNan(x) x == x

#define servo0Pin 3
#define servo1Pin 5
#define servo2Pin 9
#define servo3Pin 10

class Arm 
{
    Servo s[no_of_servos];
    Input inp;

    public:

    Arm() : inp(){}

    void execute(String msg)
    {
        static unsigned long t = millis() ;
        inp.parseCoords(msg);
        if( t - millis() > 500 )
        {
          if( notNan(inp.s0_angle) && inp.s0_angle >= 0) write(0,abs(inp.s0_angle));
          if( notNan(inp.s1_angle) && inp.s1_angle >= 0) write(1,abs(inp.s1_angle));
          if( notNan(inp.s2_angle) && inp.s2_angle >= 0) write(2,abs(inp.s2_angle));
          
            
            
          if( notNan(inp.s3_angle) && inp.s3_angle >= 0) write(3,abs(inp.s3_angle));
          t = millis();
        }
    }

    void write(int i,int value)
    {
        s[i].write((int)abs(value));
        delay(100);
    }

    void writeAll(int value)
    {
        int i;
        for(i=0;i<no_of_servos;i++)
            s[i].write(value);
    }

    String repr()
    {
        return inp.print();
    }

    void slowForward(int servo_no, int ds, int stp, int dly)
    {
        int i;
        for (i = s[servo_no].read(); i < ds; i += stp)
        {
            s[servo_no].write(i);
            delay(dly);
        }
    }

    void slowBackward(int servo_no, int ds, int stp, int dly)
    {
        int i;
        for (i = s[servo_no].read(); i >= ds; i -= stp)
        {
            s[servo_no].write(i);
            delay(dly);
        }
    }

    void refresh()
    {
      int diff = abs(( 180 - inp.s2_angle) - inp.s1_angle) ;
      if( diff < 45)
      {
        write(2,abs(inp.s2_angle + 45 - diff ));
      }
    }

    void init()
    {
        pinMode(servo0Pin,OUTPUT);
        pinMode(servo1Pin,OUTPUT);
        pinMode(servo2Pin,OUTPUT);
        pinMode(servo3Pin,OUTPUT);
        s[0].attach(servo0Pin);
        s[1].attach(servo1Pin);
        s[2].attach(servo2Pin);
        s[3].attach(servo3Pin);
        writeAll(90);
        delay(10);
    }

    void test()
    {
        writeAll(0);
        writeAll(180);
        writeAll(0);
        writeAll(180);
    }
};
