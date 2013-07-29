%%% Target's orientation and motions

%--------------------------------------------------------------------------
% Target's position with respect to the radar
%--------------------------------------------------------------------------
Po = [10 30 0];

Po_Tx = [0 0 0]; % Transmitter's position for bistatic case
%--------------------------------------------------------------------------
% Target's orientation
%--------------------------------------------------------------------------
PHI = 0;        % roll          
NI  = 0;        % pitch         
MU  = 90*pi/180;% yaw        

v = 50*1000/60/60; % target's velocity (m/s)
 
%--------------------------------------------------------------------------
% Target's oscillations
%--------------------------------------------------------------------------
% amp = 1*[0 10 20]*pi/180; % oscillation amplitudes (pitch, roll, yaw)         
% per = [5 5 5]*2; % oscillation period (pitch, roll, yaw)    
% phase = [0 0 0]; % oscillation initial phase (pitch, roll, yaw)    

%--------------------------------------------------------------------------
% No target's oscillations
%--------------------------------------------------------------------------
amp = zeros(1,3); % oscillation amplitudes (pitch, roll, yaw)         
per = [10 8 12]; % oscillation period (pitch, roll, yaw)    
phase = zeros(1,3); % oscillation initial phase (pitch, roll, yaw)    
