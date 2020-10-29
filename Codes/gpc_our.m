function res=gpc_our(p,projected,p1,p2,theta,t)
%      p = (rot(theta)*p+t);
    for i=1:size(p1,2)
		corr{i}.p = p(:,i);
		corr{i}.q = p1(:,i);
		alpha=rot(pi/2)*((p1(:,i)-p2(:,i)));
        alpha=alpha/(norm(alpha)+1e-7);
         corr{i}.C = alpha*alpha';
%  	    corr{i}.C = eye(2);
    end
    
    res = gpc(corr);
end