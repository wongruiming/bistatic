%%%pauli projection

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


function s = pauli_proj(V,alpha,beta,delta,gamma,phi)

% V = data cube (Pauli representation)

% alpha =  %%% is an internal degree of freedom of the scatterer that ranges in the interval [0 90]
% beta =  %%% physical rotation of the scatterer
% delta =  %%% scatterer phase
% gamma =  %%% scatterer phase
% phi =  %%% scatterer phase

[M N] = size(V(:,:,1));


om = [cos(alpha)*exp(j*delta) ; sin(alpha)*cos(beta)*exp(j*gamma) ; sin(alpha)*sin(beta)*exp(j*phi)];

VP = permute(V,[1 3 2]);

s = zeros(M,N);

for n = 1:N
    s(:,n) = VP(:,:,n)*conj(om);
end