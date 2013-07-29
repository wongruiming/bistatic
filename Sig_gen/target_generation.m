%%% Target generation

%--------------------------------------------------------------------------
% 3D position of the scatterers
% amplitude, phase
%--------------------------------------------------------------------------
% posTz = 1*[0 0 0; 0 1 0; 0 -1 0; 1 0 0; -1 0 0; 0 0 1; 0 0 -1]; 
% rifl = [1 ,0; 2, 0; 1, pi; 3, pi/4; 1, -pi/2; 4, pi/2; 1, -pi/4]; 

% four point diamond
% posTz = [ 0 1 0; 0 -1 0; 1 0 0; -1 0 0;];
% rifl = [ 1, 0; 1, pi; 1, pi/4; 1, -pi/2;];

% four point car
posTz = 0.7*[ 1 -2 0; 1 2 0; -1 2 0; -1 -2 0;];
rifl = [ 1, 0   ; 1, 0 ; 1,0   ; 1, 0   ;];

% one point 
% posTz = [ 0 0 0; ];
% rifl = [ 1, 0 ; ];

[numscat dim] = size(posTz);
