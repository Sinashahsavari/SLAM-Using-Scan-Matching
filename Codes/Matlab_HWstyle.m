function [param,GR] = Matlab_HWstyle()
addpath '/Users/sinashah/Documents/quarter 6/ECE. 286/HWs/ECE286-Homework2/_common'
parameters.numSteps = 100;
parameters.scanTime = 1;             

parameters.sigmaDrivingNoise = .05;    
parameters.sigmaMeasurementNoise = 15;

parameters.areaSize = [[-500;-500],[500;500]];
parameters.detectionProbability = .9;
parameters.meanClutter = 10;

parameters.priorCovariance = diag([100;100;20;20]);


% generate true track
startState = [0;0;0;0];
[trueTrack,~] = getTrueTrack(parameters,startState);


nrays=300;
r=5;
refRanges = (r+0.*randn(1,nrays)).*ones(1,nrays);
refAngles = linspace(-pi/2,pi/2,nrays); 
refScan = lidarScan(refRanges,refAngles);
timesteps=parameters.numSteps;
for i=2:timesteps
   
    
    theta(i)=0;
    currScan = transformScan(refScan,[(trueTrack(1:2,i)-trueTrack(1:2,i-1))', theta(i)]);

    

    points{i-1,1}=refScan.Cartesian;
    points{i-1,2}=currScan.Cartesian; 
    refScan=currScan;
end


timesteps=100-1;
param.thr_dist=1;    
param.thr_reflect=0;  
param.timesteps=timesteps;
param.points=points;
% param.ranges=input_data;
init=[0,0,0];
param.initial=init;
param.maxiter=100;
param.reflections=cell(100-1,2);
param.rfl_exists=0;
GR=trueTrack(1:2,:);

end