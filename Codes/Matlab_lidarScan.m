function param = Matlab_lidarScan()
load lidarScans.mat
for i=1:690-1
    points{i,1}=lidarScans(1,i).Cartesian;
    points{i,2}=lidarScans(1,i+1).Cartesian;   
end
timesteps=689;
param.thr_dist=0.8;    
param.thr_reflect=0;  
param.timesteps=timesteps;
param.points=points;
% param.ranges=input_data;
init=[0,0,0];
param.initial=init;
param.maxiter=100;
param.reflections=cell(690-1,2);
param.rfl_exists=0;


end

