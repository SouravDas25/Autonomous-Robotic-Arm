#include "Arduino.h"

class Talker
{
  public:
    static char startByte;
    static char ackByte;
    static char ackBackByte;

    void begin(int baud)
    {
        Serial.begin(baud);
    }

    bool connect()
    {
        tryConnection();
        return true;
    }

    bool tryConnection()
    {
        int c = 0;
        while (c != Talker::startByte)
        {
            if (Serial.available() > 0)
            {
                c = Serial.read();
            }
            delay(1);
        }
        Serial.write(ackByte);
        return true;
    }

    int available()
    {
        return Serial.available();
    }

    String getStringUntil(char end)
    {
        if(Serial.available() > 15)
        {
          Serial.flush();
        }
        char current = 0;
        String msg;
        while (current != end)
        {
            if (Serial.available() > 0)
            {
                current = Serial.read();
                if(current == end) break;
                msg += current;
            }
            else delay(1);
        }
        return msg;
    }

    void send(String msg)
    {
        Serial.println(msg);
    }

    void flush()
    {
        Serial.flush();
    }
};

char Talker::startByte = 1;
char Talker::ackByte = 2;
char Talker::ackBackByte = 3;
