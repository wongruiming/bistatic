
function [ LOS, Ro ] = calc_LOS( path, N )

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

LOS = [];
Ro = [];
for n = 1:N,
    pts = path( n, 1:3);
    rtd = sqrt( pts(1)^2 + pts(2)^2 + pts(3)^2 );     
    Ro = cat( 1, Ro, rtd );                                    
    LOS = cat( 1, LOS, pts/rtd );
    
end

