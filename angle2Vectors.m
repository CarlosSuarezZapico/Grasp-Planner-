function [ angle] = angle2Vectors( v1, v2 )
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: angle2Vectors.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Angle between two vectors
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% v1- vector 1
% v2- vector 2
% OUTPUTS ----------------------------------------------------------
% angle- measurement from 0 to 180
%-------------------------------------------------------------------
angle = atan2d(norm(cross(v1,v2)),dot(v1,v2));
end

