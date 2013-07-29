function [K1]=spwv_ISAR(y,gamma,eta,zp,K)


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

N = length(y);
% g=window(@Kaiser,N/2-1,gamma);
% h=window(@Kaiser,N/2-1,eta);    
g=window(@kaiser,N/2-1,gamma);
h=window(@kaiser,N/2-1,eta);
if K == 1
    
    K1=tfrrspwv(y,[floor(N/2)],zp*N,g,h,0); %R
    
else
    
    K1=tfrrspwv(y,[1:floor(N/K):N],zp*N,g,h,0); %R

end

