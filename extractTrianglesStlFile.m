function [ Piece PiecePatch] = extractTrianglesStlFile( filename )
% COPYRIGHT -- CEIT IK4
%-------------------------------------------------------------------
%  Program: CSZ_GRASP_PLANNER
%  File: extractTrianglesStlFile.m
%  Toobox Dependencies: None
%  Function Dependencies: None
%
% Authors : Carlos Suarez Zapico (csuarez@ceit.es)
%  Created: Mar 16, 2017
%-------------------------------------------------------------------
% Extract properties of a 3D model from an STL file
%-------------------------------------------------------------------
% INPUTS -----------------------------------------------------------
% filename - string variable that contains the route to the file
% OUTPUTS ----------------------------------------------------------
% Piece - Structure containing the data required in the grasp planner 
% PiecePatch - Patch object to visualize easier the model in Matlab 3Dplot
%-------------------------------------------------------------------
fid = fopen(filename);
C = textscan(fid,'%s');
k = cellfun(@length,C);
m = 11;
ni = 5;
i = 1;
p = 1;
Matrix = [0 0 0];
Matrix_normal = [0 0 0];
while ( m < (k-3) )
    j = 1;
    while (j < 4)
        l = 1;
        normales(p,1) = str2double( C{1,1}{ni,1} );
        p = p+1;
        ni = ni+1;
        while(l < 4)
            coordenates(i,1) = str2double( C{1,1}{m,1} );
            l = l+1;
            m = m+1;
            i = i+1;
        end
        m = m+1;
        j = j+1;
    end
    m = m+9;
    ni=ni+18;
end
S = size(coordenates,1);
T = S(1,1);
S2 = size(normales,1);
T2 = S2(1,1);
n = 1;

while(n < T)
    o = 1;
    while(o < 4)
        X(o,1) = coordenates(n,1);
        n = n+1;
        Y(o,1) = coordenates(n,1);
        n = n+1;
        Z(o,1) = coordenates(n,1);
        n = n+1;
        o = o+1;
    end
    Puntos = [X,Y,Z];
    Matrix = [Matrix; Puntos];
end
n = 1;
o = 1;

while(n<T2)
    Piece.Xnormal(o,1)= normales(n,1);
    n = n+1;
    Piece.Ynormal(o,1)= normales(n,1);
    n = n+1;
    Piece.Znormal(o,1)= normales(n,1);
    n = n+1;
    o = o+1;
end

%vertices of the triangles that form the model of the piece; X_piece, Y_piece and Z_piece
Piece.X = Matrix(2:size(Matrix),1);
Piece.Y = Matrix(2:size(Matrix),2);
Piece.Z = Matrix(2:size(Matrix),3);

PiecePatch.Vertices = Matrix(2:size(Matrix),:);

PiecePatch.Faces=[1 2 3]
for v = 1:((size(PiecePatch.Vertices)/3)-1)
  PiecePatch.Faces=[PiecePatch.Faces; 3*v+1 3*v+2 3*v+3];
end

fclose(fid);
end

