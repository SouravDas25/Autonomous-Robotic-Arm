#include "Arm.h"
#include "Talker.h"


Arm arm;
Talker talker;


void setup() {
  talker.begin(19200);
  arm.init();
  //if( talker.connect() ) talker.send("Connected From Board.");
}

void loop()  
{
  if( talker.available() )
  {
      String s = talker.getStringUntil('\n');
      arm.execute(s);
      talker.send(s);
  }
  //delay(2000);
}

