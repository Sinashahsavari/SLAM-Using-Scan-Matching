clear 
close all;
addpath(genpath('gpc-master'))

%%  loading data
% [param,Gr_tr]=symthetic_data();
[param,Gr_tr,GR_pose] = Oxford_realdata(50);    %%Oxford dataset
% param = Matlab_lidarScan();
%   [param,Gr_tr] = real_data();       %%[29] Data set
% [param,GR_pose] = Matlab_HWstyle();   
%    param.timesteps=2;

%% Running our Algorithm
estimated = Our_ScanMatching(param);

%% error computation 

disp('error translation')
norm(estimated(1:param.timesteps,1:2)-Gr_tr(1:param.timesteps,1:2),'fro')/norm(Gr_tr(1:param.timesteps,1:2),'fro')

disp('error rotation')
norm(estimated(1:param.timesteps,3)-Gr_tr(1:param.timesteps,3),'fro')/norm(Gr_tr(1:param.timesteps,3),'fro')
%% Showing trajectory
 param.timesteps=100;
traj=zeros(param.timesteps+1,3);
gr_traj=zeros(param.timesteps+1,2);
simple_traj=zeros(param.timesteps+1,2);
% simple_traj(1,:)=GR_pose(1,1:2);
% traj(1,1:2)=GR_pose(1,:);
% gr_traj(1,:)=GR_pose(1,:);
for j=1:param.timesteps
%     absolutePose = exampleHelperComposeTransform(GR_pose(j,:),estimated(j,:));
%     simple_traj(j+1,:)=simple_traj(j,:)+estimated(j,1:2);
     gr_traj(j+1,:)=gr_traj(j,1:2)+Gr_tr(j,1:2);
    absolutePose = exampleHelperComposeTransform(Gr_tr(j,:),estimated(j,:));
%     gr_traj(j,:)= exampleHelperComposeTransform(gr_traj(j-1,:),-Gr_tr(j,:));
     traj(j+1,:) = absolutePose;
end
%  plot(traj(:,1),traj(:,2))
% showAll_our(GR_pose(1:param.timesteps+1,1:2).',traj(:,1:2).',1)
% showAll_our(GR_pose(1:param.timesteps+1,1:2).',simple_traj(:,1:2).',1)
% showAll_our(gr_traj(:,1:2).',traj(:,1:2).',1)
% showAll_our(zeros(param.timesteps,2).',traj(:,1:2).',1)
%  plot(GR_pose(1:param.timesteps,1),GR_pose(1:param.timesteps,2))
 plot(Gr_tr(1:param.timesteps+1,1),Gr_tr(1:param.timesteps+1,2))
 hold on
plot(traj(2:end,1),traj(2:end,2))

%% Matlab toolbox 
% param.timesteps;
traj_matlab= zeros(param.timesteps,3);
 traj_matlab(1,1:2)=GR_pose(:,1)';
estimated_matlab=zeros(param.timesteps+1,3);
for i=1:param.timesteps
 estimated_matlab(i+1,:) = matchScans(lidarScan(param.points{i,2}),...
     lidarScan(param.points{i,1}),'MaxIterations',200,'InitialPose',estimated_matlab(i,:));
 absolutePose = exampleHelperComposeTransform(traj_matlab(i,:),-estimated_matlab(i+1,:));
%  absolutePose = exampleHelperComposeTransform(GR_pose(i,:),estimated_matlab(i,:));
     traj_matlab(i+1,:) = absolutePose;
end
 plot(GR_pose(1,:),GR_pose(2,:))
hold on
plot(traj_matlab(:,1),traj_matlab(:,2))
plot(traj(:,1),traj(:,2))
% showAll_our(GR_pose(:,1:2).',traj_matlab(:,1:2).',1)
% showAll_our(zeros(param.timesteps,2).',traj_matlab(:,1:2).',1)
% axis=[-2  6 -6 2];
%% Plotting scan points

% odo=param.initial;

for j=1:param.timesteps
    figure(j)
%     estimated(j,2)=-estimated(j,2);
    points_est=(rot(estimated(j,3))*param.points{j,1}'+estimated(j,1:2)').';
%     points_odo=(rot(odo(j,3))*param.points{j,1}'+odo(j,1:2)').';
    points_gr=(rot(Gr_tr(j,3))*param.points{j,1}'+Gr_tr(j,1:2)').';
    scatter(param.points{j,1}(:,1),param.points{j,1}(:,2),'r')
    hold on
    scatter(param.points{j+1}(:,1),param.points{j+1,1}(:,2),'b')
    scatter(points_est(:,1),points_est(:,2),'k')
    % scatter(points_odo(:,1),points_odo(:,2),'k')
    scatter(points_gr(:,1),points_gr(:,2),'m')
end

%%      Generation  plots
j=1;
h2=figure(2)


    scatter(param.points{j,1}(:,1),param.points{j,1}(:,2),'r','LineWidth',2.5)
    hold on
    scatter(param.points{j+1}(:,1),param.points{j+1,1}(:,2),'b','LineWidth',2.5)
    scatter(points_est(:,1),points_est(:,2),'k','LineWidth',0.5)
    % scatter(points_odo(:,1),points_odo(:,2),'k')
%     scatter(points_gr(:,1),points_gr(:,2),'m','LineWidth',2.5)
%     
% plot(Gr_tr(1:param.timesteps+1,1),Gr_tr(1:param.timesteps+1,2),'b','LineWidth',2.5)
%  hold on
% plot(traj(2:end,1),traj(2:end,2),'r','LineWidth',2.5)

%  plot(GR_pose(:,1),GR_pose(:,2),'.-b','LineWidth',2.5,'MarkerSize',6)
% hold on
% % plot(traj_matlab(:,1),traj_matlab(:,2),'r','LineWidth',2.5,'MarkerSize',6)
% plot(simple_traj(:,1),simple_traj(:,2),'.r','LineWidth',1.5,'MarkerSize',6)
% %  plot(traj(:,1),traj(:,2),'b*','LineWidth',1.5,'MarkerSize',6)
% hold on
% stem(estimated_nest(2,:),ones(1,size(estimated_nest,2)),'r')
% stem(estimated2_nest(2,:),0.8.*ones(1,size(estimated2_nest,2)),'-.rd','LineWidth',3.0,'MarkerSize',6)
lgd = legend({'RefScan','CurrScan','Translated without \newline using Reflections'},'Location','northeast');
grid on
xlabel('x (in meters)','FontSize',45)
ylabel('y (in meters)','FontSize',45)
lgd.FontSize = 15;
  xlim([20,90])
%   ylim([-50,-250])

set(gca,'FontSize',20,'lineWidth',2.5,'color','none')

set(h2,'Units','Inches');
pos = get(h2,'Position');
set(h2,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h2,'Ofxord_scan_without_reflection','-dpdf','-r0')