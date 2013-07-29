
function [ dist_nnord ] = calc_dist( ptTx, Ro, N, numscat,LOS )

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

dist_nnord = [];
for n = 1:N,
    out = [];
    for s = 0:( numscat-1 ),
        pro = ptTx( n, ( 1 + 3*s ):( 3 + 3*s ) )*LOS( n, 1:3 )';
        out = cat( 2, out, pro );
    end
    dist_nnord = cat( 1, dist_nnord, out );
end

Ro1 = repmat( Ro, 1, numscat);
dist_nnord = dist_nnord + Ro1;



