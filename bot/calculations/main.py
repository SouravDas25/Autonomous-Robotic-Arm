from sympy import *
import math

s1_val = 47
s2_val = 80
s3_val = 80

angle1_val = 0
angle2_val = 0
angle3_val = 0

#######################################

x_val = 70.0
y_val = 70.0
z_val = 70.0

theta1_val = 100
theta2_val = 100
theta3_val = 100


def coords2angles(act=False):
    s1 = Symbol('s1')
    s2 = Symbol('s2')
    s3 = Symbol('s3')
    if act:
        s1 = s1_val
        s2 = s2_val
        s3 = s3_val

    x = Symbol('x')
    y = Symbol('y')
    z = Symbol('z')
    if act:
        x = x_val
        y = y_val
        z = z_val

    myprint(act, "x", x)
    myprint(act, "y", y)
    myprint(act, "z", z)

    theta0 = atan(y / x)
    #r = x - x * cos(theta0)
    #myprint(act, "r", r)

    # x =  sqrt(x**2+y**2)
    # myprint(act, "x", x)

    be = sqrt( pow(x,2) + z**2 + y**2)
    myprint(act, "BE", be)


    ce = sqrt(x**2 + (s1 - z)**2 + y**2)
    myprint(act, "ce", ce)

    theta2 = cosineLaw(s2, s3, ce)

    

    alpha = cosineLaw(s1, ce, be)
    myprint(act, "alpha", alpha, True)
    beta = cosineLaw(ce, s2, s3)
    myprint(act, "beta", beta, True)

    theta1 = alpha + beta
    myprint(act, "theta0", theta0, True)
    myprint(act, "theta1", simplify(theta1), True)
    myprint(act, "theta2", theta2, True)


def angle2coords(act=False):
    s1 = Symbol('s1')
    s2 = Symbol('s2')
    s3 = Symbol('s3')
    if act:
        s1 = s1_val
        s2 = s2_val
        s3 = s3_val
    theta1 = Symbol('theta1')
    theta2 = Symbol('theta2')
    theta3 = Symbol('theta3')
    if act:
        theta1 = math.radians(theta1_val)
        theta2 = math.radians(theta2_val)
        theta3 = math.radians(theta3_val)

    tx = 0
    tz = s1

    tmpt = theta2 - pi / 2
    myprint(act, "tmpt", tmpt, True)

    tx = s2 * cos(tmpt) + tx
    tz = s2 * sin(tmpt) + tz
    myprint(act, "tx", tx)
    myprint(act, "tz", tz)

    tmpt = pi - theta2
    myprint(act, "tmpt", tmpt, True)
    tmpt = theta3 - tmpt - pi / 2
    myprint(act, "tmpt", tmpt, True)

    tx = s3 * cos(tmpt) + tx
    tz = s3 * sin(tmpt) + tz
    ty = tan(theta1) * tx

    myprint(act, "tx", tx)
    myprint(act, "tz", tz)
    myprint(act, "ty", ty)


def cosineLaw(a, b, c):
    tmp = a**2 + b**2 - c**2
    tmp = tmp / (2 * a * b)
    return acos(tmp)


def myprint(act, name, var, deg=False):
    if act:
        if hasattr(var,"evalf") : ev = var.evalf()
        else : ev = var
        if deg:
            ev = math.degrees(ev)
        print name, "=", var, " : abs = ", ev
    else:
        print name, "=", var


if __name__ == "__main__" :
    print "Equations"
    print "===================================="
    coords2angles()
    print "\n\nValues"
    print "===================================="
    coords2angles(True)


    # print "\n\nEquations"
    # print "===================================="
    # angle2coords()
    # print "\n\nValues"
    # print "===================================="
    # angle2coords(True)
