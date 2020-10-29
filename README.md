# SLAM-Using-Scan-Matching

## Description 
 This Project Developed by Sina Shahsavari alonge side Pulak Sarangi and Hadi Givechian. In this project we have considered a scenario in which a mobile agent is located in an unknown environment. Our goal is to  a robustly and accurately estimate its location as well as tracking the trajectory it traverses. To realize this goal, we have implemented PL-ICP algorithm to estimates relative rotation and translation of the agent and then determine its trajectory. To enhance the performance of the algorithm,  we have employed several approaches, such as outlier detection module and different mechanisms for initialization.



## Abstract 
Localizing an agent in an unknown environment has received lots of attention from both industry and academia for years. A variety of sensors have been built in autonomous cars and robots to enable localization. Lidar sensors, in particular, provide dense and accurate point clouds. A variety of algorithms have been proposed to exploit these Lidar scans to localize the agent. Iterative Closest Point (ICP) family can estimate the pose variation of the agent between two different scans which can be further used to localize the agent given the starting point. In this work, we implement the PL-ICP algorithm to localize the agent. Moreover, we found PL-ICP sometimes does not estimate pose variation on real-world data correctly which can devastate the estimated trajectory. To mitigate this problem, we propose a simple yet effective outlier rejection mechanism which improves the pose estimation. Furthermore, it turns out that PL-ICP is highly sensitive to initialization. To this end, we incorporate an initialization mechanism to the algorithm to avoid unreasonable estimates. We extensively evaluate our implementation and modifications to the algorithm on both synthetic and real-world data (Oxford robotcar dataset) and compare our results with the scan matching implementation provided in the Matlab navigation toolbox.



## For more details please read our final paper 
- https://github.com/Sinashahsavari/SLAM-Using-Scan-Matching/blob/master/SLAM%20Using%20Scan%20Matching.pdf


## Requirements and Usage
Matlab Navigation Toolbox




## Code organization 

### experiment1

 - codes/main.m: 
 
