# Autonomous Robotic Arm
Autonomous Robotic Arm With Image Processing + Deep Neural Network and Arduino.

## workings
- The camera on top takes pictures and send it to the connected server.
- The collected picture is processed via the OpenCV library and an contour map of the image is outputted.
- The contour map is feed into the Deep Neural Network and an Object is detected.
- DNN returns the object coordinates.
- The Inverse Kinematics Engine translates these coordinate into the robotic arm motor movements(degrees by which the arm should move).
- Then the Server Relays the movements to the robotic arm's arduino chipset.
- This concludes movement of the robotic arm.



[![Watch the video](https://img.youtube.com/vi/jhQWLCtkUKM/0.jpg)](https://www.youtube.com/watch?v=jhQWLCtkUKM)
