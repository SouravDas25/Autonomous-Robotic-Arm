#include <Servo.h>

#define ServoRefreshInterval 5

class HarmoinicServo : public Servo
{
    public:
    int target;
    int current = 0;

    HarmoinicServo() : current(0),target(0){};
    
    void turnTo(int angle)
    {
        target = angle;
    }

    void refresh()
    {
        if(target < current)
        {
            current -= ServoRefreshInterval;
        }
        else if(target > current)
        {
            current += ServoRefreshInterval;
        }
        if(current != target)
            write(current);
    }

}