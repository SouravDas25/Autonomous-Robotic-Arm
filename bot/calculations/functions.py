import numpy as np
from sympy import Point,Point3D
from mpmath import degrees,acos,atan,sin,cos,radians


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
    tmp = a**2 + b**2 - c**2
    tmp = tmp / (2 * a * b)
    return degrees(acos(tmp.evalf()))

def calTheta(p1,p2,p3):
    """
    @p1 Point
    @p2 Point
    @p3 Point

    =================

            p3
           //\\
          //--\\
       a //    \\  b
        //______\\
      p1    c    p2

    ================

    p1 -> p2 = C
    p2 -> p3 = b
    p3 -> p1 = a
    """
    c = p1.distance(p2)
    b = p2.distance(p3)
    a = p3.distance(p1)
    #print(a,b,c)
    return cosine_angle(a,b,c)

def slope(x,y):
    return degrees(atan(y/x))


def cart2Pol(x, y, z):
    r = np.sqrt(x**2 + y**2 + z**2)
    theta = acos(z/r)
    sigma = atan(y/x)
    return(r, theta,sigma)

def pol2Cart(r, theta,sigma):
    x = r * sin(radians(theta)) * cos(radians(sigma))
    y = r * sin(radians(theta)) * sin(radians(sigma))
    z = r *  cos(radians(theta))
    return(x, y, z)


