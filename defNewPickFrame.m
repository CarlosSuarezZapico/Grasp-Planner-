function [ Tf_Piece_Grasp ] = defNewPickFrame( Piece, PossibleCouples, number, gravity_vector, pick_approximation_v, pick_approximation_h, iteration_number_directions)
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: defNewPickFrame.m
%  Toobox Dependencies: None
%  Function Dependencies: angle2vector.m
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
pick_frame_x = (Piece.Triangle(PossibleCouples(number).t1).Normal);
pick_frame_x = (Piece.Triangle(PossibleCouples(number).t1).Normal)/norm(pick_frame_x);
pick_frame_origin = (Piece.Triangle(PossibleCouples(number).t1).Centroid+Piece.Triangle(PossibleCouples(number).t2).Centroid)/2;
angle = angle2Vectors( -gravity_vector, pick_frame_x );

if ((angle > 45) && (angle < 135))
    directions_v = true;
    directions_h = false;

    
if (directions_v == 1)
    pick_approximation_pick = pick_approximation_v(iteration_number_directions,:);
    disp('vertical')
end
if (directions_h == 1)
    pick_approximation_pick = pick_approximation_h(iteration_number_directions,:);
    disp('horizontal')
end

pick_approximation_pick = transpose(pick_approximation_pick);
gravity_vector = gravity_vector/norm(gravity_vector);
proyection = dot(gravity_vector,pick_frame_x)/norm(pick_frame_x);
pick_frame_z = gravity_vector' - proyection*pick_frame_x;
pick_frame_z = pick_frame_z/norm(pick_frame_z);
pick_frame_y = cross(pick_frame_x,pick_frame_z);
pick_frame_y = pick_frame_y/norm(pick_frame_y);
pick_frame_x = pick_frame_x/norm(pick_frame_x);

%----------DEFINE PICK FRAME --------------------------------------------------------1

%Rotation matrix from piece frame to pick frame
rotm_Piece_Pick = transpose([pick_frame_x ; pick_frame_y ; pick_frame_z]);
%Transform matrix from piece frame to pick frame
tf_Piece_Pick=[rotm_Piece_Pick];
tf_Piece_Pick(1:3,4)=pick_frame_origin;
tf_Piece_Pick(4,1:4)=[0 0 0 1];

%------------DEFINE SIMULATION GRIPPER TOUCH FRAME ----------------------------------0
pick_approximation_piece = rotm_Piece_Pick * [pick_approximation_pick];
pick_approximation_piece = transpose(pick_approximation_piece);
pick_approximation_piece = pick_approximation_piece / norm(pick_approximation_piece);
frame_y = cross(pick_frame_x , pick_approximation_piece);
frame_y = frame_y / norm(frame_y);
%-----------DEFINE SIMULATION GRIPPER TOUCH FRAME -----------------------------------1

%Rotation matrix from piece frame to simulation gripper touch frame
rotm_Piece_Grasp = transpose([pick_frame_x ; frame_y ; pick_approximation_piece]);

%Transform matrix from piece frame to simulation gripper touch frame
Tf_Piece_Grasp = [rotm_Piece_Grasp];
Tf_Piece_Grasp(1:3,4) = pick_frame_origin;
Tf_Piece_Grasp(4,1:4) = [0 0 0 1];

end

