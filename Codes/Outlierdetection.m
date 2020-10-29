%%%%% Sina Shahsavari, 
function output_ind = Outlierdetection(tr_points,closest_corr,curr_rfl,ref_rfl,ind,thr_dist,thr_reflect,flag)
   %% Guide
    %%%%%%%   tr_points : n*2 matrice  roto-translated version of the
    %%%%%%%   poiints of first scan
    
    %%%%%%%   e= 
    
    %%%%%%% 
   %%
if  flag==1
    for i=1:length(tr_points(:,1))
        rfl_dist(i)=abs(ref_rfl(i)-curr_rfl(ind(i)));
    end
    rfl_dist_sorted=sort(rfl_dist);
    threshold2= rfl_dist_sorted(floor(thr_reflect*length(rfl_dist)));
end

dists=sqrt((tr_points(:,1)-closest_corr(:,1)).^2+(tr_points(:,2)-closest_corr(:,2)).^2);
dist_sorted=sort(dists);
threshold1= dist_sorted(floor(thr_dist*length(dists)));
k=1;
    for i=1:length(tr_points(:,1))
        
        if  dists(i)<=threshold1 
            if flag==1
                if   rfl_dist(i)<=threshold2
                      output_ind(k)=i;
                      k=k+1;
                end
            else
                 output_ind(k)=i;
                      k=k+1;
            end
        end
            
     
       
    end

end

        

