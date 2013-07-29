%%% signal generation

Tob = 0.1; % radar observation time

N = 256; % number of pulses

M = 128; %frequency points or range cells

% fo = 10e9; 
% B = 1e9; % !! high bandwidth to get the range resolution

fo = 1800e6;
B = 80e3;

Tr = Tob/(N-1); % PRI

Ti = 1/B;

t = linspace( -Tob/2, Tob/2, N );

f = linspace(fo-B/2,fo+B/2,M);

% position of each scatterer at each time instant with respect to the radar 
ptTx = calc_pos( posTz, t, numscat, Rphi, Rni, Rmu ); 

% Calculation for Receiver
% contains the coordnates of point O on the target 
path_Rx = calc_traj( t, Po, Iv, N, v );  
% LoS contains the LoS unit vector coordinates as a function of time
[LOS_A,R_A] = calc_LOS( path_Rx, N );    

% Calculation for Receiver
% contains the coordnates of point O on the target 
Po_wrt_Tx = Po - Po_Tx;
path_Tx = calc_traj( t, Po_wrt_Tx, Iv, N, v );  
% LoS contains the LoS unit vector coordinates as a function of time
[LOS_B,R_B] = calc_LOS( path_Tx, N ); 

% Calculate the value of K(t)
K_t = repmat(sqrt(sum(((LOS_A+LOS_B)./2).^2,2)),1,3); 
LOS_AB = (LOS_A+LOS_B)./repmat(sqrt(sum((LOS_A+LOS_B).^2,2)),1,3); 

% distance of each scatterer as function of time
R_bi = (R_A+R_B)./2;
dist_rd = calc_dist( ptTx, R_bi, N, numscat,K_t.*LOS_AB); 

if type == 1
    if comp == 1
        % not compensated frequency - slow time signal
        filedata = sign_rx_FT( dist_rd,R_bi,rifl,numscat, N, M, f, 'sr' ); 
    elseif comp == 2
        % compensated frequency - slow time signal
        filedata = sign_rx_FT( dist_rd,R_bi,rifl,numscat, N, M, f, 'sc' ); 
    end 
elseif type == 2
    if comp == 1
        % not-compensated fast time - slow time signal
        filedata = sign_rx_TT( dist_rd,R_bi,rifl,numscat, N, Ti, fo,'sr'); 
    elseif comp == 2
        % compensated fast time - slow time signal
        filedata = sign_rx_TT( dist_rd,R_bi,rifl,numscat, N, Ti, fo,'sc'); 
    end    
    M = size(filedata,2);    
    f = linspace(fo-1/Ti/2,fo+1/Ti/2,M);
end


