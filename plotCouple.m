function  plotCouple( Piece, Possible_couples, number)
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: plotCouple.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Plot the a candidate couple where to grasp the piece 
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% Piece- Structure containing the properties of the 3D model
% Possible_couples - Array containing the couple candidates
% number - Solution selected among the availble in Possible_couples
%-------------------------------------------------------------------

%-------------------PLOT SELECTED COUPLE----------------------------------------------0 
  S1 = [Piece.Triangle(Possible_couples(number).t1).P1(1) Piece.Triangle(Possible_couples(number).t1).P2(1) Piece.Triangle(Possible_couples(number).t1).P3(1)];
  S2 = [Piece.Triangle(Possible_couples(number).t1).P1(2) Piece.Triangle(Possible_couples(number).t1).P2(2) Piece.Triangle(Possible_couples(number).t1).P3(2)];
  S3 = [Piece.Triangle(Possible_couples(number).t1).P1(3) Piece.Triangle(Possible_couples(number).t1).P2(3) Piece.Triangle(Possible_couples(number).t1).P3(3)];

  C1 = [Piece.Triangle(Possible_couples(number).t2).P1(1) Piece.Triangle(Possible_couples(number).t2).P2(1) Piece.Triangle(Possible_couples(number).t2).P3(1)];
  C2 = [Piece.Triangle(Possible_couples(number).t2).P1(2) Piece.Triangle(Possible_couples(number).t2).P2(2) Piece.Triangle(Possible_couples(number).t2).P3(2)];
  C3 =  [Piece.Triangle(Possible_couples(number).t2).P1(3) Piece.Triangle(Possible_couples(number).t2).P2(3) Piece.Triangle(Possible_couples(number).t2).P3(3)];

  %The couple selected is painted in green

  for i = 1:(Number_directions * Number_couple_iterations)
      subplot(Number_directions,Number_couple_iterations,i)
      patch(S1,S2,S3,'green');         
      patch(C1,C2,C3,'green');
      hold(graphics(i),'on');
      hold on
  end
  
end

