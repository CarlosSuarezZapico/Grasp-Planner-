function [ Tgoals GraspSolution ] = graspPlanner(minGrip, maxGrip, tfGripperTouchEE, numSolutions, PiecefilePath, gravity_vector)
  
  GraspSolution=0;
  Tgoals = eye(4);
  Solution =1;
  %-------------------PARAMETERS TUNNING OF THE GRASP PLANNER---------------------0
  AproxDirectionsIterations=3; %Number of pick approximations for a single couple of triangles used in the iteration proccess 
  
  %--PARAMETERS TO RATE BEST COUPLES
  distance_factor=1; %Parameter to select the couple of triangles with a distance between them about 22 mm
  area_factor=-1; %Parameter to select the couple of triangles with bigger area
  proximity_factor=+2;  %Parameter to select the couple ot triangles nearer to the robot  
  
  %-------------------PARAMETERS TUNNING OF THE GRASP PLANNER----------------------0
  CoupleIterations = round(numSolutions / AproxDirectionsIterations);
  
  %Inializing variables
  %Indicates if there is any solution to grasp a piece
  CoupleSolution=0;
  
  [ pick_approximation_v pick_approximation_h ] = aproxDirections()
  
  %reads the STL file in ASCII format and takes the coordenates of ther
  %vertices and normals
  [ Piece ] = extractTrianglesStlFile( PiecefilePath );  
  [ Piece ] = triangleProperties( Piece );
  % Find Couples on the piece 3D model
  [ PossibleCouples Best_couples] = findCouples( Piece.Triangle, minGrip, maxGrip );
  % Order best couples depending on their features
  [ PossibleCouples CoupleIterations CoupleSolution candidateIndex] = orderBestCouples( PossibleCouples, Best_couples, CoupleIterations );
 
  

  if(CoupleSolution==1)
      number=candidateIndex(1); % select the first candidate of couples
      
      %The vertices of the gripper model are taken from its stl file
      filename = 'matlab_pinza.STL';
      [ Gripper] = extractTrianglesStlFile( filename );
      
      
      
      % LOOP TO CHECK AVAILABLE SOLUTION
      numCouple = 1;
      numAproxDirection = 1;
      while(numCouple < CoupleIterations)
          
          [ Tf_Piece_Grasp ] = defNewPickFrame( Piece, PossibleCouples, number, gravity_vector, pick_approximation_v, pick_approximation_h, numAproxDirection);
          
          %Rotation matrix from piece frame to simulation gripper base frame
          Tf_GripperBase_Grasp = trvec2tform([0 0 +0.1356]);
          
          %Check Collisi�n in new Grasp Ubication
          [ contact ] = checkCollision( Piece, Gripper, Tf_Piece_Grasp, Tf_GripperBase_Grasp);
          
          if (contact ==0)
              tfPieceEE = Tf_Piece_Grasp * tfGripperTouchEE;
              Tgoals(:,:,Solution)=tfPieceEE;
              Solution = Solution + 1;
              GraspSolution=1;
          end
                    
          number = candidateIndex(numCouple);
          numAproxDirection = numAproxDirection + 1;
          
          if (numAproxDirection > AproxDirectionsIterations)
              numCouple = numCouple+1;
          end
          
      end
      
      
  end
  
  %Close the figures
  close all;
  
end

