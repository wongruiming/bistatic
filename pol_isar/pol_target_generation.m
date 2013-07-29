%%% Polarimetric target generation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Copyright
%%%
%Date
%July 2009
%%%
%Author
%Marco Martorella
%%%
%Affiliation
%Dipartimento di ingegneria dell'Informazione, via Caruso 16, 56122 Pisa,
%italy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


posTz = 2*[0 0 1; 0 1 0; 0 -1 0; 1 0 0; -1 0 0; 2 0 0];

[numscat dim] = size(posTz);

S = zeros(2,2,numscat);

S(:,:,1) = [1 ,0; 0, 1]; %trihedral
S(:,:,2) = [1, 0; 0, -1]; % dihedral
S(:,:,3) = [0, 1; 1, 0]; % rotated dihedral
S(:,:,4) = [1, 0; 0, 1]; % trihedral
S(:,:,5) = [0, 0; 0, 1]; % dipole
S(:,:,6) = [1, 0; 0, 0]; % dipole

