function estimated = Our_ScanMatching(param)

%% loading parameters
timesteps=param.timesteps;
maxiter=param.maxiter;
initial=param.initial;
points=param.points;
flag=param.rfl_exists;
thr_dist=param.thr_dist;    
thr_reflect=param.thr_reflect;    
reflections=param.reflections;


%%  main  loop 
estimated=zeros(timesteps,3);
% theta_0=initial(1,3);
% t_0=initial(1,1:2);
% theta_0=0;
 t_0=[0,0];
 theta_0=0;
%   t_0=0.5.*randn(1,2);
for i=1:timesteps
     i
     refScan=points{i,1};
     currScan=points{i,2};
     ref_rfl=reflections{i,1};
     curr_rfl=reflections{i,2};
%      theta_0=0;
%        t_0=0.5.*randn(1,2);
%     theta_0=initial(i,3);
%     t_0=initial(i,1:2);
%     theta_0=-0.01;
%     t_0=[0,0];
    for iter=1:maxiter
         [refScan,currScan]=remove_nan(refScan,currScan);
        [transformed_point,projected,closest1,closest2,ind] = find_closest(currScan...
            ,refScan,theta_0,t_0);
        
        new_ind = Outlierdetection(transformed_point,closest1,...
            curr_rfl,ref_rfl,ind,thr_dist,thr_reflect,flag);
        
        res=gpc_our(refScan(new_ind,:).',projected(new_ind,:).',...
            closest1(new_ind,:).',closest2(new_ind,:).',theta_0',t_0');
        
%                 res=gpc_our(refScan.',projected.',...
%             closest1.',closest2.',theta_0',t_0');
        if norm([res.x(1:2)'-t_0,res.x(3)-theta_0])<=1e-10
            break         
        end
%         if abs(res.x(1))>0.4  && iter >30
%             res.x(1)=0.3;
%         end
%         if  abs(res.x(2))>0.7 && iter >30
%             res.x(2)=-0.6;
%         end
        theta_0=res.x(3);
        t_0=res.x(1:2)';
         
    end
%       theta_0=res.x(3);%+1/5.*(rand(1)-0.5);
%        t_0=res.x(1:2)';%1/5.*(rand(1,2)-0.5);
    estimated(i,1:2)=res.x(1:2)';
    estimated(i,3)=res.x(3);
end

end

%%  remove nans from data
function [refScan,currScan]=remove_nan(refScan,currScan)
 refScan(isnan(refScan(:,1)),:) = [];
 currScan(isnan(currScan(:,1)),:) = [];
end

