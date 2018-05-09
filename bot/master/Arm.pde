

class Arm
{
  public float[] angles = {90,90,90};
  public float x,y,z;
  public boolean gripperOpen = false;
  
  final boolean coords_from_angle = true;
  final boolean angle_from_coords = false;
  
  public float getx()
  {
    return x;
  }
  public float gety()
  {
    return y;
  }
  public float getz()
  {
    return z;
  }
  public PVector getCoord()
  {
    return new PVector(x,y,z);
  }
  public float getAngle(int index)
  {
    return angles[index];
  }
  
  public void setGripper(int angle)
  {
     sendAngle("s3",angle);
  }
  
  public void openGripper()
  {
     setGripper(180);
  }
  
  public void closeGripper()
  {
     setGripper(21);
  }
  
  public boolean setCoordinate(int x,int y,int z)
  {
    println("\nNew Coords",x,y,z);
    float [] t = coords2angle(x,y,z);
    if(t != null)
    {
      angles = t;
      this.x = x;
      this.y = y;
      this.z = z;
      return sendAllAngles(angles);
    }
    println("CANNOT BE REACHED");
    return false;
  }
  
  public boolean setAngles(float [] d)
  {
    angles = d;
    reCalculate(coords_from_angle);
    return sendAllAngles(angles);
  }
  
  public boolean setAngle(int i,int angle)
  {
    if(Double.isNaN(angle) ) return false;
    angles[i] = angle;
    String key = "s" + i;
    sendAngle(key,angle);
    reCalculate(coords_from_angle);
    return true;
  }
  
  void reCalculate(boolean ang_coor)
  {
    if(ang_coor)
    {
      PVector t = angle2coords(angles);
      this.x = t.x;
      this.y = t.y;
      this.z = t.z;
    }
    else
    {
      angles = coords2angle(x,y,z);
    }
  }
  
  boolean sendAllAngles(float [] d)
  {
    if(d == null)return false;
    JSONObject json = new JSONObject();
    for(int i =0;i<d.length;i++)
    {
      if( Double.isNaN(d[i]) ) return false;
      String key = "s" + i;
      d[i] = Math.round(d[i]);
      json.setDouble(key, d[i]);
    }
    sendJson(json);
    return true;
  }
  
  void sendAngle(String key, int value)
  {
    JSONObject json = new JSONObject();
    json.setInt(key, value);
    sendJson(json);
  }


  void sendJson(JSONObject json)
  {
    String msg = json.toString();
    msg = msg.replace("\n","");
    msg = msg.replace(" ","");
    talker.send(msg);
    println(msg);
  }

}
