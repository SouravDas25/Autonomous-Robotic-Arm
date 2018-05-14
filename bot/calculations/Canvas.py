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

    def __init__(self,type=0):
        self.xs = []
        self.ys = []
        self.zs = []
        self.type = type
        self.fig = plt.figure()
        self.ax = self.fig.add_subplot(111, projection='3d')
        self.ax.set_xlabel('X Label')
        self.ax.set_ylabel('Y Label')
        self.ax.set_zlabel('Z Label')

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

    def plot(self):
        self.xs = np.array(self.xs)
        self.ys = np.array(self.ys)
        self.zs = np.array(self.zs)
        if self.type == 0 :
            self.ax.plot3D(self.xs, self.ys, self.zs)
        else :
            self.ax.scatter(self.xs, self.ys, self.zs)
        self.xs = []
        self.ys = []
        self.zs = []
        

    def show(self):
        self.plot()
        set_axes_equal(self.ax)
        plt.show()


def set_axes_equal(ax):
    '''Make axes of 3D plot have equal scale so that spheres appear as spheres,
    cubes as cubes, etc..  This is one possible solution to Matplotlib's
    ax.set_aspect('equal') and ax.axis('equal') not working for 3D.

    Input
      ax: a matplotlib axis, e.g., as output from plt.gca().
    '''

    x_limits = ax.get_xlim3d()
    y_limits = ax.get_ylim3d()
    z_limits = ax.get_zlim3d()

    x_range = abs(x_limits[1] - x_limits[0])
    x_middle = np.mean(x_limits)
    y_range = abs(y_limits[1] - y_limits[0])
    y_middle = np.mean(y_limits)
    z_range = abs(z_limits[1] - z_limits[0])
    z_middle = np.mean(z_limits)

    # The plot bounding box is a sphere in the sense of the infinity
    # norm, hence I call half the max range the plot radius.
    plot_radius = 0.5*max([x_range, y_range, z_range])

    ax.set_xlim3d([x_middle - plot_radius, x_middle + plot_radius])
    ax.set_ylim3d([y_middle - plot_radius, y_middle + plot_radius])
    ax.set_zlim3d([z_middle - plot_radius, z_middle + plot_radius])
