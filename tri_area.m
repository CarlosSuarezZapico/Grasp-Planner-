% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: tri_area.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
%  calculates the triangle area given the triangle vertices (using Heron's formula)
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% P1, P2, P3 = triangle vertices
% OUTPUTS ----------------------------------------------------------
% A = triangle area
%-------------------------------------------------------------------
function A = tri_area(P1, P2, P3)

u1 = P1 - P2;
u2 = P1 - P3;
u3 = P3 - P2;

a = norm(u1);
b = norm(u2);
c = norm(u3);

s=(a+b+c)/2;
A = sqrt(s * (s-a) * (s-b) * (s-c));


end

