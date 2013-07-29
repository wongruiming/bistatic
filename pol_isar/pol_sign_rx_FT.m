
function sigmat = pol_sign_rx_FT( dist_rdin, Ro, S, numscat, N, M, f, sigtype )

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


Sv = squeeze(reshape(S,4,1,numscat));
c = 3e8;  
if sigtype == 'sc'
    Ro1 = repmat( Ro, 1, numscat);
    dist_rd = dist_rdin - Ro1;
else 
    dist_rd = dist_rdin.'; 
end

tao = ( 2 * dist_rd )/c;                                  
% keyboard;
sign = [];
rif = [];
sigmat = zeros(N,M,4);

for nn = 1:4
    
    rif = Sv(nn,:).'*ones(1,N);
    
    sign = [];
    
    for mm = 1:M,
        matfreq = rif.*exp(-j*2*pi*f(mm)*tao);            % Matrice ( numscat x N ) degli sfasamenti relativi alla frequenza m-esima.
        sig = sum( matfreq );
        sign = cat( 1, sign, sig );        % La matrice in uscita ha dimensioni pari a ( M x N ), essendo M il numero di frequenze
    end                                          %   ed N il numero di sweeps.

    sigmat(:,:,nn) = sign.';
    
end


