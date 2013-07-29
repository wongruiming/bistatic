%%%pauli representation

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


function V = pauli_repr(H)

[M N P] = size(H);

V = zeros(M,N,3);

V(:,:,1) = 1./sqrt(2).*(H(:,:,1)+H(:,:,4));
V(:,:,2) = 1./sqrt(2).*(H(:,:,4)-H(:,:,1));
V(:,:,3) = 1./sqrt(2).*(H(:,:,2)+H(:,:,3));
