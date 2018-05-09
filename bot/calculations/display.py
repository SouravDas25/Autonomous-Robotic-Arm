
import pygame
from math import *

red = (255,0,0)
green = (0,255,0)
blue = (0,0,255)
darkBlue = (0,0,128)
white = (255,255,255)
black = (0,0,0)
pink = (255,200,200)

s1 = 47
s2 = 80
s3 = 80

def calAngles(point):
    x = point[0]
    #y = point[1]
    z = point[1]
    theta2 = acos((s1**2 - z**2 + (s1 - z)**2)/(2*s1*sqrt(x**2 + (s1 - z)**2))) + \
    acos((s2**2 - s3**2 + x**2 + (s1 - z)**2)/(2*s2*sqrt(x**2 + (s1 - z)**2)))
    theta3 = acos((s2**2 + s3**2 - x**2 - (s1 - z)**2)/(2*s2*s3))
    #theta1 = atan(y/x)

    #theta1 = degrees(theta1)
    #theta2 = degrees(theta2)
    #theta3 = degrees(theta3)
    return theta2,theta3

def addOrigin(point):
    return point[0] + 10 , 250 - point[1]

def rotatePoint(point,angle):
    return point[0]*cos(angle),point[1]*sin(angle)

def drawLine(point1 , point2):
    p1 = addOrigin(point1)
    p2 = addOrigin(point2)
    pygame.draw.line(gameDisplay, white , p1, p2 )

def drawBot(p2):
    th2,th3 = calAngles((70,70))
    print(degrees(th2))
    drawLine((0,0),(0,s1))
    
    drawLine((0,s1),(x,y))



def main():
    pygame.display.set_caption('A bit Racey')
    crashed = False
    while not crashed:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                crashed = True
            if event.type == pygame.MOUSEBUTTONUP:
                drawBot(event.pos)
            #print(event)
        pygame.display.update()
        clock.tick(60)
    pygame.quit()
    quit()


if __name__ == "__main__" :
    pygame.init()
    gameDisplay = pygame.display.set_mode((800,600))
    clock = pygame.time.Clock()
    main()