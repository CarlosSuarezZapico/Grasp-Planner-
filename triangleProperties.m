function [ Piece ] = triangleProperties( Piece )
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: triangleProperties.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
%  Estract new properties from the triangles of a 3D model
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% Piece - structure to save data
% OUTPUTS ----------------------------------------------------------
% Piece- updated variable to contain new fields and data
%-------------------------------------------------------------------
 t = 1;
  h = 1;
  while(t<length(Piece.X))
      
      P1 = [Piece.X(t) Piece.Y(t) Piece.Z(t)];
      P2 = [Piece.X(t+1) Piece.Y(t+1) Piece.Z(t+1)];
      P3 = [Piece.X(t+2) Piece.Y(t+2) Piece.Z(t+2)];
      
      %The properties of the triangles are save in the fields of the struct Triangle
      Piece.Triangle(h).P1 = P1;
      Piece.Triangle(h).P2 = P2;
      Piece.Triangle(h).P3 = P3;
      Area = tri_area(P1,P2,P3);
      Piece.Triangle(h).Area = Area;
      Piece.Triangle(h).Centroid = [(Piece.X(t)+Piece.X(t+1)+Piece.X(t+2))/3 (Piece.Y(t)+Piece.Y(t+1)+Piece.Y(t+2))/3 (Piece.Z(t)+Piece.Z(t+1)+Piece.Z(t+2))/3];
      Piece.Triangle(h).Normal = [Piece.Xnormal(h) Piece.Ynormal(h) Piece.Znormal(h)];
      t = t+3;
      h = h+1;
  end
end

