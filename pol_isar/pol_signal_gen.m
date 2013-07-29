%%% signal generation

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

Tob = .8;

N = 64;

M = 64;

Tr = Tob/(N-1);

Ti = 1e-10;

fo = 1e10;

B = 1800e6;

t = linspace( -Tob/2, Tob/2, N );

f = linspace(fo-B/2,fo+B/2,M);

ptTx = calc_pos( posTz, t, numscat, Rphi, Rni, Rmu );  % position of each scatterer at each time instant with respect to the radar 

flightpath = calc_traj( t, Po, Iv, N, v );  % contains the coordnates of point O on the target 

[ LOS Ro ] = calc_LOS( flightpath, N );    % LoS contains the LoS unit vector coordinates as a function of time

dist_rd = calc_dist( ptTx, Ro, N, numscat, LOS ); % distance of each scatterer as function of time

H = pol_sign_rx_FT( dist_rd, Ro, S, numscat, N, M, f, 'sr' ); % not compensated frequency - slow time signal
