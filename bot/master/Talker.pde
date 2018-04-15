import processing.serial.*;

public static char startByte = 1;
public static char ackByte = 2;
public static char ackBackByte = 3;

class Talker extends Serial {
  
  Talker(PApplet instance,int baud,String portName)
  {
    super(instance,portName,baud);
  }
  
  public boolean tryConnection()
  {
    int c = 0;
    println("Waiting for connection...");
    while(c != ackByte)
    {
      this.write(startByte);
      delay(100);
      if(this.available() > 0)
      {
        c = super.read();
      }
    }
    println("Acknoledgement Received...");
    return true;
  }
  
  public boolean waitUntilConnect()
  {
    this.tryConnection();
    println("Connected");
    return true;
  }

  public void printPortNames()
  {
    int i;
    for(i=0;i<Serial.list().length;i++)
    {
      println(Serial.list()[i] + " : " + i);
    }
  }

  void flush()
  {
    while(available() > 0)
    {
      read();
    }
    clear();
  }
  
  public int send(String msg)
  {
    int i;
    for(i=0;i<msg.length() ; i++ )
    {
      this.write(msg.charAt(i));
    }
    this.write('\n');
    return i;
  }

}
