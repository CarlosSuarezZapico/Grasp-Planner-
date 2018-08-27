function [ pick_approximation_v pick_approximation_h ] = aproxDirections()
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: aproxDirections.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Define direction vectors for grasping approximation
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% None
% OUTPUTS ----------------------------------------------------------
% pick-approximation_v- possible approximation vectors to attack vertically
% pick-approximation_h- possible approximation vectors to attack
% horizontally
%-------------------------------------------------------------------


  %Directions in strategy 1
  pick_approximation_v(1,:)=[0 1 0];
  pick_approximation_v(2,:)=[0 0 1];
  pick_approximation_v(3,:)=[0 -1 0];
  pick_approximation_v(4,:)=(pick_approximation_v(1,:)+pick_approximation_v(2,:))/2;
  pick_approximation_v(5,:)=(pick_approximation_v(2,:)+pick_approximation_v(3,:))/2;
  pick_approximation_v(6,:)=(pick_approximation_v(1,:)+pick_approximation_v(4,:))/2;  
  pick_approximation_v(7,:)=(pick_approximation_v(4,:)+pick_approximation_v(2,:))/2;
  pick_approximation_v(8,:)=(pick_approximation_v(2,:)+pick_approximation_v(5,:))/2;
  pick_approximation_v(9,:)=(pick_approximation_v(5,:)+pick_approximation_v(3,:))/2;

  %Directions in strategy 2
  pick_approximation_h(1,:)=[0 1 0];
  pick_approximation_h(2,:)=[0 0 1];
  pick_approximation_h(3,:)=[0 -1 0];
  pick_approximation_h(4,:)=[0 0 -1];
  pick_approximation_h(5,:)=(pick_approximation_h(1,:)+pick_approximation_h(2,:))/2;
  pick_approximation_h(6,:)=(pick_approximation_h(2,:)+pick_approximation_h(3,:))/2;
  pick_approximation_h(7,:)=(pick_approximation_h(3,:)+pick_approximation_h(4,:))/2;  
  pick_approximation_h(8,:)=(pick_approximation_h(4,:)+pick_approximation_h(1,:))/2; 
  pick_approximation_h(9,:)=(pick_approximation_h(1,:)+pick_approximation_h(5,:))/2;
  pick_approximation_h(10,:)=(pick_approximation_h(5,:)+pick_approximation_h(2,:))/2; 
  pick_approximation_h(11,:)=(pick_approximation_h(2,:)+pick_approximation_h(6,:))/2;
  pick_approximation_h(12,:)=(pick_approximation_h(6,:)+pick_approximation_h(3,:))/2;
  pick_approximation_h(13,:)=(pick_approximation_h(3,:)+pick_approximation_h(7,:))/2;
  pick_approximation_h(14,:)=(pick_approximation_h(7,:)+pick_approximation_h(4,:))/2;
  pick_approximation_h(15,:)=(pick_approximation_h(4,:)+pick_approximation_h(8,:))/2;
  pick_approximation_h(16,:)=(pick_approximation_h(8,:)+pick_approximation_h(1,:))/2;

  
end

