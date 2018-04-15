#include "talker.h"

Talker talker;

void setup() {


    Serial.begin(9600);

    if( talker.connect() ) talker.send("Connected From Board.");
    
}


void loop() {

    if( talker.available() )
    {
        String s = talker.getStringUntil('\n');
        talker.send(s);
    }
}
