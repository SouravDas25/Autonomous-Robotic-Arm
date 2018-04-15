

class Input {

    public :
    int servoID,servoValue,prevID;

    Input():servoID(-1),servoValue(-1),prevID(-1){};

    bool parseMsg(String & msg) // 1 : 180
    {
        //Serial.println(msg);
        int n = msg.indexOf(':');
        //Serial.println(n);
        String ID = msg.substring(0,n);
        String Val = msg.substring(n+1,msg.length());
        //Serial.println(ID + " " + Val);
        this->servoID = ID.toInt();
        this->servoValue = Val.toInt();
        //Serial.println(print());
        return true;
    }

    void covertCoords(int x,int y , int z)
    {
      
    }

    bool isValid()
    {
        if(servoID != -1 && servoValue != -1) return true;
        return false;
    }

    String print()
    {
        String  s = "" ;
        s += "Forward On  Motor : " + String(this->servoID) + " => "+ this->servoValue;
        return s;
    }

};
