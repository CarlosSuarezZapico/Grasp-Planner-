function  showPiece( Piece, strFaceColor, strEdgeColor, numfigure )
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: showPiece.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Plot the model in Matlab 3D plotter
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% Piece- Patch structured containing the properties of the 3D model
% strFaceColor - string containing the color to visualize the faces
% of the model
% strEdgeColor - string containing the color to visualize the edges of
% the model
% numfigure - figure where to plot the model
%-------------------------------------------------------------------

%SHOWPIECE Summary of this function goes here
%   Detailed explanation goes here
Piece.FaceColor = strFaceColor;
Piece.EdgeColor = strEdgeColor;
Piece.LineWidth = 2;
figure(numfigure);
patch(Piece)

end

