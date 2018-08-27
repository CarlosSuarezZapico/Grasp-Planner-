function plot3DModel(numWindow, Piece, strcolor1, strcolor2)
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: plot3DModel.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Function made to plot a model in 3D in Matlab
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% numWindow- number of the figure to plot the model
% OUTPUTS ----------------------------------------------------------
% Piece- Structure containing the properties of the model
% strcolor1- Color 1 for the plotting
% strcolor2 - Color 2 for the plotting
%-------------------------------------------------------------------
t=1;
flap = 1;
while(t < length(Piece.X))
    T1 = [X_piece(t) X_piece(t+1) X_piece(t+2)];
    T2 = [Y_piece(t) Y_piece(t+1) Y_piece(t+2)];
    T3 = [Z_piece(t) Z_piece(t+1) Z_piece(t+2)];
    if flap==1
        i = 1:(Number_directions * Number_couple_iterations)
        figure(numWindow)
        patch(T1,T2,T3,strcolor1);
        hold on;
        flap = 0;        
    else
        patch(T1,T2,T3,strcolor2);
        hold(graphics(i),'on');
        hold on        
        flap = 1;
    end    
end

