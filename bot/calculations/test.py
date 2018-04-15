from Canvas import Canvas
from functions import cosine_angle,calTheta,Point3D,Point,slope,pol2Cart

c = Canvas()
s1_size = 5

segment1_length = 5
segment2_length = 5
segment3_length = 5

o = Point3D(0,0,0)
t = Point3D(4,6,8)
shadow_t = Point3D(t.x,t.y,0)
s1 = Point3D(0,0,segment1_length)

const_angle = slope(t.x,t.y)

def main():
    # center
    c.addPoint(o)

    # target
    c.addPoint(t)

    # projection in xy plane
    c.addPoint(shadow_t)
    c.addPoint(o)
    # servo 1
    c.addPoint(s1)
    c.addPoint(t)

    l4 = s1.distance(t).evalf()

    # calculate servo1 angle
    pc1 = calTheta(o,t,s1)
    pc2 = cosine_angle(l4,segment2_length,segment3_length)
    pc = pc1 + pc2
    print(pc1,pc2 , " = ", pc)
    tmp = pc - 90 
    print(tmp)
    x1,y1,z1 = pol2Cart(segment2_length,tmp,const_angle)
    s2 = Point3D(x1+s1.x,y1+s1.y,z1+s1.z)
    c.addPoint(s1)
    c.addPoint(s2)

    # calculate servo2 angle
    qc = cosine_angle(segment3_length,segment2_length,l4)
    tmp = 180 - qc
    x1,y1,z1 = pol2Cart(segment3_length,tmp,const_angle)
    s3 = Point3D(x1+s2.x,y1+s2.y,z1+s2.z)
    c.addPoint(s3)
    print(qc)

    c.show()

main()


