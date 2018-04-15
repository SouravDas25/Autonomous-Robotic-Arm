#include <Servo.h>
#include "input.h"

#define no_of_servos 4

class Arm 
{
    Servo s[no_of_servos];
    Input inp;

    public:

    Arm() : inp(){}

    void execute(String msg)
    {
        static unsigned long t = millis() ;
        inp.parseMsg(msg);
        if(inp.prevID != inp.servoID || t - millis() > 500 )
        {
            write(inp.servoID,inp.servoValue);
            inp.prevID = inp.servoID;
            t = millis();
        }
    }

    void write(int i,int value)
    {
        s[i].write(value);
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

    void init()
    {
        s[0].attach(3);
        s[1].attach(5);
        s[2].attach(6);
        s[3].attach(9);
        writeAll(0);
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
