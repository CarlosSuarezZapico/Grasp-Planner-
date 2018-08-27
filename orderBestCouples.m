function [ Possible_couples numCoupleIterations CoupleSolution candidateIndex] = orderBestCouples( Possible_couples, Best_couples, numCoupleIterations )
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: orderBestCouples.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Order and select best couples candidates
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% Possible_couples - Structured data containing the properties of all the
% couples
% Best_couples - num of couples 
% numCoupleIterations - number of iterations to try
% OUTPUTS ----------------------------------------------------------
% Possible_couples- Candidates approved
% numCoupleIterations- variable updated considering the amount of solutions
% available
% CoupleSolution- Indicates that it exist at least one solution available
% candidateIndex - Save the index of the array that contains a candidate
% solution
%-------------------------------------------------------------------
if ((Best_couples-1) > 1) 
     %A solution was found and it is indicated to the requester     
     CoupleSolution = 1;
     cuenta = 1;
     %Classify the best couples by sorting the field value     
      for w = 0:(numCoupleIterations)
          maximo = -10;
          for wi = 1:(Best_couples-1)
              value = Possible_couples(wi).value;
              check = Possible_couples(wi).check;
              if ((maximo < Possible_couples(wi).value) && (Possible_couples(wi).check == 0))
                 maximo = Possible_couples(wi).value;  
                 cuenta = wi;
              end
          end
      candidateIndex(w+1) = cuenta;
      Possible_couples(cuenta).check = 1;
      end
      disp('The are some available solutions')
      if ( numCoupleIterations > (Best_couples-1))
         numCoupleIterations = Best_couples-1;
      end
  else
      %No couples found so there is no solution and has to indicate to the requester
      CoupleSolution = 0;
  end

end

