## UR10e controlder: 
simulation and calculation kinematic for UR10e use Webots and Matlab
## Install 
* Download : ```git clone 
https://github.com/Mr-QB/UR10e-controlder.git```
* Install environment for webots:
    * Download Webots from [here](https://cyberbotics.com/)
    * Open Webots, click ```file```, select ```open world```,find the folder you just downloaded, select ```/UR10e controlder/vehicles/worlds/UR10e.wbt```.
## Programs include:
* [```Calc_Trajectory_v1.m```](https://github.com/Mr-QB/UR10e-controlder/blob/main/vehicles/controllers/Control_UR10_v1_basic_controler/Calc_Trajectory_v1.m): Calculate dimensional reference points and matching variables from a given trajectory. The results are returned to the file waypoint.txt and Trajectory.txt
* [```Control_UR10_v1_basic_controler.py```](https://github.com/Mr-QB/UR10e-controlder/blob/main/vehicles/controllers/Control_UR10_v1_basic_controler/Calc_Trajectory_v1.m): Get the list of matching variables from the above IK calculation that executes robot control in the simulation
## Demo
You can watch the resulting demo video here: https://www.youtube.com/watch?v=gPxO5dmJ8sU
