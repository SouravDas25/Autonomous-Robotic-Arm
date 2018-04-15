from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np

"""
class Point():

    def __init__(self,x,y,z):
        self.x = x
        self.y = y
        self.z = z

    @property
    def x(self):
        return self.x

    @property
    def y(self):
        return self.y

    @property
    def z(self):
        return self.z
"""

class Canvas(object):

    def __init__(self):
        self.xs = []
        self.ys = []
        self.zs = []

    def addLine(self,p1,p2):
        self.addPoint(p1)
        self.addPoint(p2)

    def addPoint(self,x,y = None,z=None,c=None):
        if y is None and z is None :
            self.xs.append(x.x)
            self.ys.append(x.y)
            self.zs.append(x.z)
        else :
            self.xs.append(x)
            self.ys.append(y)
            self.zs.append(z)
        return True

    def show(self):
        fig = plt.figure()
        ax = fig.add_subplot(111, projection='3d')
        ax.plot3D(self.xs, self.ys, self.zs)
        ax.set_xlabel('X Label')
        ax.set_ylabel('Y Label')
        ax.set_zlabel('Z Label')

        plt.show()

