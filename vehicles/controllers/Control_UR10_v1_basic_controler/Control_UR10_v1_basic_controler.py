# You may need to import some classes of the controller module. Ex:
#  from controller import Robot, Motor, DistanceSensor
from controller import Robot

# create the Robot instance.
robot = Robot()

timestep = 64

# Define joint:
joint = [robot.getDevice('shoulder_pan_joint'),
            robot.getDevice('shoulder_lift_joint'),
            robot.getDevice('elbow_joint'),
            robot.getDevice('wrist_1_joint'),
            robot.getDevice('wrist_2_joint'),
            robot.getDevice('wrist_3_joint')]
joint[0].setPosition(1.0)
joint[0].setVelocity(1.0)

while robot.step(timestep) != -1:
    joint[0].setPosition(1.3)
    #joint[0].setVelocity(0.5)
    
    joint[1].setPosition(0)
    #joint[1].setVelocity(0.5)
    
    joint[2].setPosition(0)
    #joint[2].setVelocity(0.5)
    
    joint[3].setPosition(0)
    #joint[3].setVelocity(0.5)
   
    joint[4].setPosition(0.9)
    #joint[4].setVelocity(0.5)
    
    joint[5].setPosition(1.5708)
    #joint[5].setVelocity(0.5)
    # joint[2].setPosition(2)
    # joint[0].setPosition(position)
    # Read the sensors:
    # Enter here functions to read sensor data, like:
    #  val = ds.getValue()

    # Process sensor data here.

    # Enter here functions to send actuator commands, like:
    #  motor.setPosition(10.0)
    pass

# Enter here exit cleanup code.
