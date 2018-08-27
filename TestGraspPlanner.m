% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: TestGraspPlanner.m
%  Toobox Dependencies: Matlab Robotics System Toolbox
%  Function Dependencies: grasp_planner.m
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Test grasp planner funcionality
%-------------------------------------------------------------------
minGrip = 0.022;
maxGrip = 0.037;
numSolutions = 6;
PiecefilePath = 'Botella.STL';
gravity_vector = [0;0;-1];
%tfGripperTouchEE = trvec2tform([0 0 -0.1356]);
tfGripperTouchEE = trvec2tform([0 0 -0.11]);
[ Tgoals GraspSolution ] = graspPlanner(minGrip, maxGrip, tfGripperTouchEE, numSolutions, PiecefilePath, gravity_vector);

[ Piece PiecePatch] = extractTrianglesStlFile( 'Botella.STL')
figure(1)
axis([-0.1 0.6 -0.1 0.6 -0.1 0.6])
hold on
showPiece(PiecePatch, 'green','blue',1)
hold on


[ Gripper GripperPatch] = extractTrianglesStlFile( 'pinza_matlab.STL');
for i=1:length(GripperPatch.Vertices)
    Vertex = Tgoals(:,:,3) * [GripperPatch.Vertices(i,:)'; 1];
    GripperPatch.Vertices(i,:)= Vertex(1:3);
end
showPiece(GripperPatch,'red','blue',1)
