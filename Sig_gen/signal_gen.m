%%% signal generation

Tob = 0.5; % radar observation time

N = 256; % number of pulses

M = 128; %frequency points or range cells

fo = 10e9; 
B = 1e9; % !! high bandwidth to get the range resolution

% fo = 1800e6;
% B = 80e3;

Tr = Tob/(N-1); % PRI

Ti = 1/B;

t = linspace( -Tob/2, Tob/2, N );

f = linspace(fo-B/2,fo+B/2,M);

% position of each scatterer at each time instant with respect to the radar 
ptTx = calc_pos( posTz, t, numscat, Rphi, Rni, Rmu ); 

% contains the coordnates of point O on the target 
flightpath = calc_traj( t, Po, Iv, N, v );  

% LoS contains the LoS unit vector coordinates as a function of time
[ LOS Ro ] = calc_LOS( flightpath, N );    

% distance of each scatterer as function of time
dist_rd = calc_dist( ptTx, Ro, N, numscat, LOS ); 

if type == 1
    if comp == 1
        % not compensated frequency - slow time signal
        filedata = sign_rx_FT( dist_rd, Ro, rifl, numscat, N, M, f, 'sr' ); 
    elseif comp == 2
        % compensated frequency - slow time signal
        filedata = sign_rx_FT( dist_rd, Ro, rifl, numscat, N, M, f, 'sc' ); 
    end 
elseif type == 2
    if comp == 1
        % not-compensated fast time - slow time signal
        filedata = sign_rx_TT( dist_rd, Ro, rifl, numscat, N, Ti, fo,'sr'); 
    elseif comp == 2
        % compensated fast time - slow time signal
        filedata = sign_rx_TT( dist_rd, Ro, rifl, numscat, N, Ti, fo,'sc'); 
    end    
    M = size(filedata,2);    
    f = linspace(fo-1/Ti/2,fo+1/Ti/2,M);
end


