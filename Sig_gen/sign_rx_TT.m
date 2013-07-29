
function sign = sign_rx_TT( dist_rdin, Ro, rifl, numscat, N, Ti, fo, sigtype )

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

c = 3e8;  
delta = 80;

if sigtype == 'sc'
    Ro1 = repmat( Ro, 1, numscat);
    dist_rd = dist_rdin - Ro1;
else
    dist_rd = dist_rdin;
end

Rmean = mean( mean( dist_rd ) );  % Range gating: center

dist_rd = dist_rd - Rmean;

Rmin = min( min( dist_rd ) );  % Range gating: lower bound
Rmax = max( max( dist_rd ) );  % Range gating: upper bound

M = max([ceil(2*(Rmax-Rmin)/c/Ti) + ceil(delta/100*2*(Rmax-Rmin)/c/Ti),64]); % Min range cells = 64 to allow algorithm to work correctly

tm = linspace(2*Rmin/c-delta/2*Ti,2*Rmax/c+delta/2*Ti,M);

sig_mod = Ti*sin(tm/Ti)./tm;

if rem(M,2)==1
    
    sig_mod((M+1)/2) = 1;
    
end

tao = ( 2 * dist_rd )/c;

sign = zeros(N,M);

for nn = 1:N
    
    for kk = 1:numscat
        
        sign(nn,:) = sign(nn,:) + rifl(kk,1)*exp(j*rifl(kk,2))*exp(j*2*pi*fo*tao(nn,kk))*circshift(sig_mod,[1,round(tao(nn,kk)/Ti)]);
        
    end
    
end



