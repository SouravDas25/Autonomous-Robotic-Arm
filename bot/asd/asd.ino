#include "Arm.h"
#include "Talker.h"


Arm arm;
Talker talker;


void setup() {
  talker.begin(28800);
  arm.init();
  if( talker.connect() ) talker.send("Connected From Board.");
}

void loop()  
{
  if( talker.available() )
  {
      talker.send(" ");
      String s = talker.getStringUntil('\n');
      arm.execute(s);
      talker.send(s + "\n" +arm.repr() );
  }
  //arm.refresh();
  //delay(2000);
}

