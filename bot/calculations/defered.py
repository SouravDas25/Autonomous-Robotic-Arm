from sympy import *
import math

ab_len = 35
ad_len = 80
bc_len = 80 
cd_len = 35

a1_val = 176

def main(act = False):
    a1 = Symbol('a1')
    if act :
        a1 = math.radians(a1_val)

    myprint(act,"a1",a1,True)

    tmp = pi - a1
    myprint(act,"tmp",tmp,True)

    bd_len = inverseCosineLaw(ab_len,ad_len,tmp)
    myprint(act,"bd_len",bd_len)

    bcd = cosineLaw(bc_len,cd_len,bd_len)
    myprint(act,"bcd",bcd)

    cbd = cosineLaw(bc_len,bd_len,cd_len)
    myprint(act,"cbd",cbd)

    cdb = pi - ( bcd + cbd )
    myprint(act,"cdb",cdb)

    adb = cosineLaw(ad_len,bd_len,ab_len)
    myprint(act,"adb",adb)

    cda = cdb + adb
    myprint(act,"cda",cda)

    theta = pi - cda
    myprint(act,"theta",theta,True)




def inverseCosineLaw(a, b, angle):
    tmp = a**2 + b**2 - (2 * a * b * cos(angle))
    return sqrt(tmp)

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

print "\nEquation"
print "===================================="
main()

print "\n\nValues"
print "===================================="
main(True)