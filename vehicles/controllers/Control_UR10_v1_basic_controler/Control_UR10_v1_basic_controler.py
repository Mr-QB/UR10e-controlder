<<<<<<< HEAD
#
#!/usr/bin/env python3.8
from controller import Robot


=======
# You may need to import some classes of the controller module. Ex:
#  from controller import Robot, Motor, DistanceSensor
from controller import Robot

>>>>>>> main
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

<<<<<<< HEAD
f=open('Trajectory.txt',"r")
lines=f.readlines()
data=[]
for x in lines:
    data.append(x.split(','))
f.close()
Trajectory = []
for dt in data[1:]:
    a = [float(i) for i in dt]
    Trajectory.append(a)
    
joint[0].setPosition(Trajectory[1][0])        
joint[1].setPosition(Trajectory[1][1])
joint[2].setPosition(Trajectory[1][2])
joint[3].setPosition(Trajectory[1][3])
joint[4].setPosition(Trajectory[1][4])
joint[5].setPosition(Trajectory[1][5])
Step = 0
i = 1
Step_check = 70
direction = 1
while robot.step(timestep) != -1:
    Step += 1
    if(Step >= Step_check):
        Step_check += 2
        i += direction
        joint[0].setPosition(Trajectory[i][0])
        # joint[0].setVelocity(0.5)
            
        joint[1].setPosition(Trajectory[i][1])
        # joint[1].setVelocity(0.5)
            
        joint[2].setPosition(Trajectory[i][2])
        # joint[2].setVelocity(0.5)
            
        joint[3].setPosition(Trajectory[i][3])
        # joint[3].setVelocity(0.5)
        
        joint[4].setPosition(Trajectory[i][4])
        # joint[4].setVelocity(0.5)
            
        joint[5].setPosition(Trajectory[i][5])
        # joint[5].setVelocity(0.5)
        print("true___",i)
        if(i == len(Trajectory)-1 or i == -len(Trajectory)):
            direction = direction * -1
    print(Step)
    pass

=======
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
>>>>>>> main
