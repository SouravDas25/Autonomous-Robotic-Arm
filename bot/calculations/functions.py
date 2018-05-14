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

def sqrt(x):
    return math.sqrt(x)

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

def rotatePoint(point,angle,centerPoint = Point3D(0,0,0)):
    """Rotates a point around another centerPoint. Angle is in degrees.
    Rotation is counter-clockwise"""
    angle = math.radians(angle)
    x,z = (point.x-centerPoint.x , point.z-centerPoint.z)
    x,z = ( x*math.cos(angle)-z*math.sin(angle) , x*math.sin(angle)+z*math.cos(angle))
    x,z = x+centerPoint.x , z+centerPoint.z
    return Point3D(x,point.y,z)

def drawArm3Segment(canvas,angles,segments,all=None):
    theta0 = angles[0]
    theta1 = angles[1] - 90
    theta2 = angles[2] - ( 90 + 180 - angles[1])
    s1 = segments[0]
    s2 = segments[1]
    s3 = segments[2]
    print(theta0,theta1,theta2)

    origin = Point3D(0,0,10)
    s1p = Point3D(0,0,s1)
    s2p = Point3D(s1p.x + s2,s1p.y,s1p.z)
    s2p = rotatePoint(s2p,theta1,s1p)

    s3p = Point3D(s2p.x + s3,s2p.y,s2p.z)
    s3p = rotatePoint(s3p,theta2,s2p)
    s4p = Point3D(s3p.x + 35,s3p.y,s3p.z)
    

    canvas.addPoint(origin)
    canvas.addPoint(s1p)
    canvas.addPoint(s2p)
    canvas.addPoint(s3p)
    canvas.addPoint(s4p)
    
    

    canvas.plot()
    return True

def calAngles(target,segments):
    x = target.x
    y = target.y
    z = target.z
    s1 = segments[0]
    s2 = segments[1]
    s3 = segments[2]
    theta0 = atan(y/x)
    theta1 = acos((s1**2 - z**2 + (s1 - z)**2)/(2*s1*sqrt(x**2 + y**2 + (s1 - z)**2))) \
            + acos((s2**2 - s3**2 + x**2 + y**2 + (s1 - z)**2)/(2*s2*sqrt(x**2 + y**2 + (s1 - z)**2)))
    theta2 = acos((s2**2 + s3**2 - x**2 - y**2 - (s1 - z)**2)/(2*s2*s3))
    return [ theta0, theta1, theta2 ]


