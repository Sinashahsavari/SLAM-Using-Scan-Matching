function [transformed_point,projected,closest1,closest2,ind] = find_closest(ref_points,points,theta,t)
    %theta = theta/180*pi;
    R = [cos(theta),-sin(theta);sin(theta),cos(theta)];
    transformed_point = (R*points'+t')';
    closest1 = zeros(length(points(:,1)),2);
    closest2 = zeros(length(points(:,1)),2);
     projected = zeros(length(points(:,1)),2);
     ind=zeros(length(points(:,1)),1);
    for i = 1:length(points(:,1))
        distance = sum((transformed_point(i,:) - ref_points).^2,2);
        [~,arg_min] = min(distance);
        closest1(i,:) = ref_points(arg_min,:);
        ind(i)=arg_min;
        distance(arg_min) = inf;
        [~,arg_min] = min(distance);
        closest2(i,:) = ref_points(arg_min,:);
        
        projected(i,:) = (closest_point_on_segment(closest1(i,:)',closest2(i,:)',transformed_point(i,:)'))';
    end