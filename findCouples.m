function [ Possible_couples Best_couples] = findCouples( Triangle, minGrip, maxGrip )
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: findCouples.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Look for couples of triangles in the 3D model and returns
% a classification of the best candidates
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% Triangle- Variable containing the properties of all the triangles 
% minGrip - minimun distance between the fingers of the gripper when it is
% close
% maxGrip maximun distance between the fingers of the gripper when it is
% open
% OUTPUTS ----------------------------------------------------------
% Possible_couples- Found Couples with their propertie
% Best_couples- Number of couples found
%-------------------------------------------------------------------
%--PARAMETERS TO RATE BEST COUPLES
  distance_factor=1; %Parameter to select the couple of triangles with a distance between them about 22 mm
  area_factor=-1; %Parameter to select the couple of triangles with bigger area
  proximity_factor=+2;  %Parameter to select the couple ot triangles nearer to the robot  
  
  %-------------------PARAMETERS TUNNING OF THE GRASP PLANNER----------------------0
 number_couples = 1;
  Best_couples = 1;
  Total_Area = 0;
  Total_distance =  0;
  Total_proximity = 0;
  for b0 = 1:length(Triangle)
      for b1 = 1:length(Triangle)
          %If the normals of two triangles are parallel or their angle is less than a tolerance angle then
          % both are selected in the struct of data Couples          
          if ((dot(Triangle(b0).Normal,Triangle(b1).Normal)/(norm(Triangle(b0).Normal)*norm(Triangle(b1).Normal)))<-0.940)
              Couples(number_couples).t1 = b0;
              Couples(number_couples).t2 = b1;
                if (abs(dot(Triangle(b0).Normal,Triangle(b0).Centroid-Triangle(b1).Centroid)/(norm(Triangle(b0).Normal)*norm(Triangle(b0).Centroid-Triangle(b1).Centroid)))>0.940)
                   distance=abs(norm(Triangle(b0).Centroid-Triangle(b1).Centroid));
                     if((minGrip<distance)&&(distance<maxGrip))
                          Possible_couples(Best_couples).t1 = b0;
                          Possible_couples(Best_couples).t2 = b1;
                          Possible_couples(Best_couples).Area = Triangle(b1).Area+Triangle(b0).Area;
                          Total_Area = Possible_couples(Best_couples).Area+Total_Area;
                          Possible_couples(Best_couples).distance=distance;
                          Total_distance = Possible_couples(Best_couples).distance+Total_distance;
                          Middle_point = ([(Triangle(Possible_couples(Best_couples).t1).Centroid+Triangle(Possible_couples(Best_couples).t2).Centroid)/2  1]');
                          Possible_couples(Best_couples).proximity = norm(Middle_point);
                          Total_proximity = Possible_couples(Best_couples).proximity+Total_proximity;                           
                          Best_couples = Best_couples+1;                            
                     end
                end
                number_couples = number_couples+1;             
          end
      end    
  end

  for w = 1:(Best_couples-1)
      %Depending of the properties of the couples, a value is assigned to each, in order to select the best ones  
      Possible_couples(w).value= distance_factor * (Possible_couples(w).distance / Total_distance) + area_factor * (Possible_couples(w).Area / Total_Area) ...
      + proximity_factor * (Possible_couples(w).proximity / Total_proximity);
      Possible_couples(w).check = 0;
  end 
end

