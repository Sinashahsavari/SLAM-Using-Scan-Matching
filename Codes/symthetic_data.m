function [param,Gr_tr] = symthetic_data()

clear all;
%  rng(1)
%%parameters 
nrays=300;
r=5;
timesteps=5;

%% generating data set
t=zeros(timesteps,2);
theta=zeros(timesteps,1);
points=cell(timesteps,2);
Ranges=zeros(timesteps,nrays);
t_0=zeros(timesteps,2);
theta_0=zeros(timesteps,1);
refRanges = (r+0.*rand(1,nrays)).*ones(1,nrays);
refAngles = linspace(-pi/2,pi/2,nrays); 
Scan(1) = lidarScan(refRanges,refAngles);
    for i=1:timesteps
    t(i,:)=2+rand(1,2);
    theta(i)=-pi/2+pi*rand(1);
    Scan(i+1) = transformScan(Scan(i),[t(i,:), theta(i)]);
    points{i,1}=Scan(i).Cartesian;
    points{i,2}=Scan(i+1).Cartesian;
    Ranges(i,:)=Scan(i).Ranges';
%     pose = matchScans(currScan,refScan);
    t_0(i,:)=2+rand(1,2);
    theta_0(i,:)=theta(i)+(-pi/20+pi/10*rand(1));

    

    end
param.timesteps=timesteps;
param.points=points;
param.overlap=1;
param.ranges=Ranges;
param.initial=[t_0,theta_0];
param.maxiter=100;
Gr_tr=[t,theta];
end

