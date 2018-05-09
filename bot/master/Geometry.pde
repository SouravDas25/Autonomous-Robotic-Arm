

int [] segments = {45,80,80};
int [] ac = {0,230,10};

float[] solve(float x,float y ,float z)
{
  //x = x + 70;
  if(x == 0 || y == 0 || z == 0)
  {
    return null;
  }
  double s1 = segments[0];
  double s2 = segments[1];
  double s3 = segments[2];
  double theta1 = atan(y/x);
  double theta3 = Math.acos(( Math.pow(s2,2) + Math.pow(s3,2) - pow(x,2) - Math.pow(y,2) - Math.pow(s1 - z,2))/(2*s2*s3));
  double alpha = Math.acos(( Math.pow(s1,2) - Math.pow(z,2) + Math.pow(s1 - z,2))/(2*s1*Math.sqrt(Math.pow(x,2) + Math.pow(y,2) + Math.pow(s1 - z,2))));
  double beta = Math.acos(( Math.pow(s2,2) - Math.pow(s3,2) + Math.pow(x,2) + Math.pow(y,2) + Math.pow(s1 - z,2))/(2*s2*Math.sqrt(Math.pow(x,2) + Math.pow(y,2) + Math.pow(s1 - z,2))));
  double theta2 = alpha + beta;
  theta1 = (double)Math.toDegrees(theta1);
  theta2 = (double)Math.toDegrees(theta2);
  theta3 = (double)Math.toDegrees(theta3);
  
  
  float[] t1 = {(float)theta1,(float)theta2,(float)theta3};
  return t1;
}


float[] coords2angle(float x,float y ,float z)
{
  float[] ti = solve(x,y,z);
  if(ti == null) return null;
  float theta1 = ti[0];
  float theta2 = ti[1];
  float theta3 = ti[2];
  if(theta3 > 160 || theta3 < 35) return null;
  println("actual angle",theta1,theta2,theta3);
  ti[1] = ac[1] - theta2;
  float epi = 180 - theta2;
  float th2 = 0;
  if(epi < 35) th2 = 35 - epi ;
  float min = th2 + epi;
  float max = ( 120 + epi > 160 ) ? 160 : 120 + epi ;
  if(theta3 < min || theta3 > max) return null;

  float displament = ( theta3 - min );
  //if(displament > max ) displament = displament % max + min;
  ti[2] = displament + th2 + 60;
  ti[0] = 90 - theta1;
  println("defered angle",ti[0],ti[1],ti[2]);
  return ti;
}

/*
 * angles are the servo angles
 */
PVector angle2coords(float [] angles)
{
  println(angles);
  float s1 = segments[0];
  float s2 = segments[1];
  float s3 = segments[2];
  float theta1 = angles[0];
  float theta2 = ac[1] - angles[1];
  float theta3 = 180 - theta2 + angles[2];
  theta1 = (float)Math.toRadians(theta1);
  theta2 = (float)Math.toRadians(theta2);
  theta3 = (float)Math.toRadians(theta3);
  float tx = s2*sin(theta2) - s3*sin(theta2 + theta3);
  float tz = s1 - s2*cos(theta2) + s3*cos(theta2 + theta3);
  float ty = tan(theta1) * tx;
  //tx = tx - 70;
 
  PVector s4 = new PVector(tx,ty,tz);
  return s4;
}
