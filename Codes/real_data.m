function [param,Gr_tr] = real_data()
clear all;
load cenci_data.mat
load cenci_data_2.mat
timesteps=777;
init=Gr_tr+0.*randn(778,3);
% theta_0=pi/4;
param.thr_dist=0.6;    
param.thr_reflect=0;  
param.timesteps=timesteps;
param.points=points;
param.ranges=input_data;
param.initial=init;
param.maxiter=100;
param.reflections=cell(timesteps,2);
param.rfl_exists=0;


end

