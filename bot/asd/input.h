#include <ArduinoJson.h>



const double segment1_length = 62;
const double segment2_length = 62;
const double segment3_length = 62;

class Input {

    public :
    float s0_angle,s1_angle,s2_angle,s3_angle;

    Input():s0_angle(-1),s1_angle(-1),s2_angle(-1),s3_angle(-1){};

    bool parseCoords(String& msg)
    {
        DynamicJsonBuffer jsonBuffer;
        JsonObject& root = jsonBuffer.parseObject(msg);
        //root.printTo(Serial);
        setAngle(root);
        return true;
    }

    void setAngle(const JsonObject& root)
    {
      if( root.containsKey("s0") )
      {
          s0_angle = root["s0"];
      }
      if( root.containsKey("s1") )
      {
          s1_angle = root["s1"];
      }
      if( root.containsKey("s2") )
      {
          s2_angle = root["s2"];
      }
      if( root.containsKey("s3") )
      {
          s3_angle = root["s3"];
      }
    }

    String print()
    {
        String  s = "" ;
        s += String(" 0 : ") + s0_angle + ", 1 : " + s1_angle + ", 2 : " + s2_angle;
        return s;
    }

};
