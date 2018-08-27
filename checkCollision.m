function [ contact ] = checkCollision( Piece, Gripper, Tf_Piece_Grasp, Tf_GripperBase_Grasp)
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: checkCollision.m
%  Toobox Dependencies: None
%  Function Dependencies: triTriContact.m
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Checks that, for a possible grasp pose, the gripper achieve the goal 
% without colliding with the piece
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% Piece- Structure containing data from piece model to grasp
% Gripper- Structure containing data from gripper model 
% Tf_Piece_Grasp- Solution to check if contact exist 
% Tf_GripperBase_Grasp- Transformation matrix from gripper grasp point to 
% gripper mounting point on robot end-effector
% OUTPUTS ----------------------------------------------------------
% contact- 0 Grasping Pose is not on collision
%          1 Grasping Pose is on collision
%-------------------------------------------------------------------


i = 1;
Xtf = 0;
Ytf = 0;
Ztf = 0;
contact = 0;

Tf_Grasp_GripperBase= inv(Tf_GripperBase_Grasp);

% Transform all the points of the gripper model to the grasp pose with
% reference to the piece frame
while (i < length(Gripper.X))
    TR1 = Tf_Piece_Grasp * Tf_Grasp_GripperBase * [Gripper.X(i)   ; Gripper.Y(i)   ; Gripper.Z(i)    ; 1];
    TR2 = Tf_Piece_Grasp * Tf_Grasp_GripperBase * [Gripper.X(i+1) ; Gripper.Y(i+1) ; Gripper.Z(i+1)  ; 1];
    TR3 = Tf_Piece_Grasp * Tf_Grasp_GripperBase * [Gripper.X(i+2) ; Gripper.Y(i+2) ;  Gripper.Z(i+2) ; 1];
    
    T1 = [TR1(1) TR2(1) TR3(1)];
    T2 = [TR1(2) TR2(2) TR3(2)];
    T3 = [TR1(3) TR2(3) TR3(3)];
    
    Xtf = [Xtf;TR1(1);TR2(1);TR3(1)];
    Ytf = [Ytf;TR1(2);TR2(2);TR3(2)];
    Ztf = [Ztf;TR1(3);TR2(3);TR3(3)];
    
    i = i+3;
end

%----------CHECK COLLISION BETWEEN GRIPPER SIMULATION MODEL AND PIECE MODEL 
dim = 2;
dim2 = 1;
while(dim <= length(Gripper.X))
    while(dim2 <=length(Piece.X))
        t1 = [Xtf(dim) Ytf(dim) Ztf(dim);Xtf(dim+1) Ytf(dim+1) Ztf(dim+1);Xtf(dim+2) Ytf(dim+2) Ztf(dim+2)];
        t2 = [Piece.X(dim2) Piece.Y(dim2) Piece.Z(dim2);Piece.X(dim2+1) Piece.Y(dim2+1) Piece.Z(dim2+1);Piece.X(dim2+2) Piece.Y(dim2+2) Piece.Z(dim2+2)];
        contact = triTriContact(t1, t2);
        dim2 = dim2+3;
    end
    dim = dim+3;
end
end

