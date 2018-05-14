from Canvas import Canvas
from functions import cosine_angle,Point3D,Point,slope,pol2Cart,printWithName,calAngles,drawArm3Segment

c = Canvas(0)

segments = [35,80,80]
angle_constratin = [ 0, 0,0,0]

def doJOB():
    step = 90
    for i in range(0,181,step) :
        for p in range(0,181,step) :
            for r in range(0,181,step) :
                drawArm3Segment(c,[i,p,r],segments,True)
    return True

def doJOB1():
    uc =  100
    for i in range(0,100,30):
        t = Point3D(uc,uc,i)
        angles = calAngles(t,segments)
        if angles is not None:
            print(angles)
            drawArm3Segment(c,angles,segments,True)
        else :
            print("ERROR : COORDINATES CANNOT BE REACHED.")
    return True

def gotoPoint(x,y,z):
    t = Point3D(x,y,z)
    angles = calAngles(t,segments)
    if angles is not None:
        print(angles)
        drawArm3Segment(c,angles,segments,True)
    else :
        print("ERROR : COORDINATES CANNOT BE REACHED.")

def main():
    
    doJOB()
    #doJOB1()
    #gotoPoint(100,120,30)
    #drawArm3Segment(c,[45,120,45],segments,True)
    #drawArm3Segment(c,[0,60,60],segments,True)
    #drawArm3Segment(c,[0,120,120],segments,True)
    #drawArm3Segment(c,[0,180,180],segments,True)
            
    c.show()


    
main()


