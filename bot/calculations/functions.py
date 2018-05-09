from __future__ import division
import numpy as np
from sympy import Point, Point3D
from mpmath import degrees, acos, atan, sin, cos, radians
import math
from trianglesolver import solve, degree



def cosine_angle(a, b, c):
    """
    the angles of a triangle if one knows the three sides
    theta = acos( ( a**2 + b**2 + x**2 ) / 2ab )

    =================

           //\\
          //--\\
       a //    \\  b
        //______\\
            c    
    ================

    """
    """ 
    #print("a = ",a,"b = ",b,"c = ",c)
    tmp = a**2 + b**2 - c**2
    #print("tmp = ",tmp)
    dn = 2 * a * b
    #print("dn = ",dn)
    tmp = tmp / float(dn)
    if tmp > 1.0000000000000000000000000000000000000000000000000000000000000000000000 or \
        tmp < -1.000000000000000000000000000000000000000000000000000000000000000000000 :
        tmp = round(tmp)
    #print("tmp = ",tmp)
    # return math.degrees(math.acos(tmp))"""
    try :
        a,b,c,A,B,C = solve(a=a,b=b,c=c)
    except AssertionError:
        return None
    return C / degree


def cosine_length(C,a,b):
    a,b,c,A,B,C = solve(a=a,b=b,C=C*degree)
    return c


# def calTheta(p1, p2, p3):
#     """
#     @p1 Point
#     @p2 Point
#     @p3 Point

#     =================

#             p3
#            //\\
#           //--\\
#        a //    \\  b
#         //______\\
#       p1    c    p2

#     ================

#     p1 -> p2 = C
#     p2 -> p3 = b
#     p3 -> p1 = a
#     """
#     c = p1.distance(p2)
#     b = p2.distance(p3)
#     a = p3.distance(p1)
#     # print(a,b,c)
#     return cosine_angle(a, b, c)

def slope(x, y):
    return math.degrees(math.atan(y / x))


def cart2Pol(x, y, z):
    r = np.sqrt(x**2 + y**2 + z**2)
    theta = math.acos(z / float(r))
    sigma = math.atan(y / float(x))
    return(r, theta, sigma)


def pol2Cart(r, theta, sigma):
    x = r * math.sin(radians(theta)) * math.cos(radians(sigma))
    y = r * math.sin(radians(theta)) * math.sin(radians(sigma))
    z = r * math.cos(radians(theta))
    return(x, y, z)

def printWithName(name,value):
    print(name," = ",value)

def filerAngle(ang):
    """if ang > 180 : 
        return 180
    if ang  < 0 : 
        return 0"""
    return ang

def drawArm3Segment(canvas,angless,segments,angle_constratin,all=None):
    angles = filter(lambda x : x <= 180 and x >= 0 ,angless)
    if len(angles) < 3 :
        print("ERROR CANNOT REACH ",angless)
        return False
    o = Point3D(0,0,0)
    s1 = Point3D(0,0,segments[0])
    const_angle = filerAngle(angles[0]) + angle_constratin[0]
    pc = angles[1] + angle_constratin[1]
    pc = filerAngle(pc)
    tmp = 180 - pc
    x1,y1,z1 = pol2Cart(segments[1],tmp,const_angle)
    s2 = Point3D(x1+s1.x,y1+s1.y,z1+s1.z)
    qc = angles[2] + angle_constratin[2]
    qc = filerAngle(qc)
    tmp1 = 180 - qc + tmp
    x1,y1,z1 = pol2Cart(segments[2],tmp1,const_angle)
    s3 = Point3D(x1+s2.x,y1+s2.y,z1+s2.z)
    snd_seg_tst = s1.distance(s2)
    third_seg_tst = s2.distance(s3)
    if all :
        canvas.addPoint(o)
        canvas.addPoint(s1)
        canvas.addPoint(s2)
        canvas.addPoint(s3)
        canvas.addPoint(s3.x,s3.y,s3.z-segments[3])
    else :
        canvas.addPoint(s3)
        canvas.addPoint(s3.x,s3.y,s3.z+0.1)
    #print(angles,s1,s2,s3,pc,qc,tmp,tmp1)
    if( round(third_seg_tst) != segments[2]):
        print("ERROR 3ND segment length did not match : " , third_seg_tst.evalf() , segments[2])
    if( round(snd_seg_tst) != segments[1]):
        print("ERROR 2ND segment length did not match : " , snd_seg_tst.evalf() , segments[1])
    canvas.plot()
    return True

def calAngles(target,segments,angle_constratin):
    print("x = ",target.x,"y = ",target.y,"z = ",target.z)
    t = Point3D(target.x,target.y,target.z + segments[3])
    o = Point3D(0,0,0)
    const_angle = slope(t.x,t.y) - angle_constratin[0]
    if const_angle > 180 and const_angle < 0 :
        return None
    s1 = Point3D(0,0,segments[0])
    l4 = s1.distance(t).evalf()
    m = o.distance(t).evalf()

    print("cosnt_angle = ",const_angle)

    # calculate servo1 angle
    
    pc1 = cosine_angle(segments[0],l4,m)
    print("pc1 = ",pc1)
    if pc1 is None:
        return None
    pc2 = cosine_angle(l4,segments[1],segments[2])
    print("pc2 = ",pc2) 
    if pc2 is None:
        return None
    pc = pc1 + pc2 - angle_constratin[1]
    print("pc = ",pc)

    if pc > 180 and pc < 0 :
        return None

    # calculate servo2 angle
    qc = cosine_angle(segments[2],segments[1],l4) - angle_constratin[2]
    print("qc = ",qc)
    if qc > 180 and qc < 0 :
        return None

    #calculate servo3
    am = o.distance(target).evalf()
    print("am = ",am)
    rc1 = cosine_angle(m,segments[3],am)
    if rc1 is None:
        return None
    print("rc1 = ",rc1)
    rc2 = cosine_angle(m,l4,segments[0])
    if rc2 is None:
        return None
    print("rc2 = ",rc2)
    rc3 = cosine_angle(segments[2],l4,segments[1])
    if rc3 is None:
        return None
    print("rc3 = ",rc3)
    rc = rc1+ rc2 + rc3 - angle_constratin[3]
    print("rc = ",rc)
    if rc > 180 and rc < 0 :
        return None
    return [const_angle, pc , qc , rc ]


