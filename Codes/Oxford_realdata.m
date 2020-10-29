function [param,Gr_tr,GR] = Oxford_realdata(sampling)
%  load OXFORD_front.mat
% 
% load Oxford_radar_odo.mat  % this one is from 128 to 179 
load Oxford_velodyne_right.mat
% 129 macthes exactly with 6 in lidar_right 
% 179 macthes best wiith 628 iin  liidar_right   

% load Oxford_front_Large.mat

%% INS Groundtruth
[timestamp,~]=size(lidarRightPointClouds);
k=1;

for i=1:sampling:timestamp-sampling
%     clear ind
%     m=1;
%     for j=1:length(lidarRightPointClouds{i,1}(1,:))
%     if lidarRightPointClouds{i,1}(1,j)> 90 || lidarRightPointClouds{i,1}(1,j)< 40
%         ind(m)=j;
%         m=m+1;
%     elseif lidarRightPointClouds{i,1}(2,j)< -200 || lidarRightPointClouds{i,1}(2,j)> -115
%         ind(m)=j;
%         m=m+1; 
%     end
%     end
%     lidarRightPointClouds{i,1}(:,ind)=[];
    points{k,1}=lidarRightPointClouds{i,1}(1:2,:)';
    points{k,2}=lidarRightPointClouds{i+sampling,1}(1:2,:)';
    reflections{k,1}=lidarRightPointClouds{i,1}(4,:)';
    reflections{k,2}=lidarRightPointClouds{i+sampling,1}(4,:)';
    k=k+1;
end
GR=GR(1:sampling:end,:);
Gr_tr=diff(GR);

%%  Radar Groundtruth
% [timestamp,~]=size(lidarRightPointClouds);
% k=1;
% for i=6:sampling:628
%     points{k,1}=lidarRightPointClouds{i,1}(1:2,:)';
%     points{k,2}=lidarRightPointClouds{i+sampling,1}(1:2,:)';
%     reflections{k,1}=lidarRightPointClouds{i,1}(3,:)';
%     reflections{k,2}=lidarRightPointClouds{i+sampling,1}(3,:)';
%     k=k+1;
% end
% 
% Gr_tr=Radar_odo(2:49,:);




%% laoding parameters 
param.thr_dist=1;    
param.thr_reflect=0.8;  
initial=Gr_tr; %+0.*randn(k-1,3);
param.initial=initial;
param.timesteps=timestamp-1;
param.points=points;
param.reflections=reflections;
param.rfl_exists=0;
param.maxiter=200;
%% 

end