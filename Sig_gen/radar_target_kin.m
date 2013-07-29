%%% Radar-Target Kinematics

c = 3e8; % light speed

Rphi = [ cos(PHI) 0 sin(PHI); 0 1 0; -sin(PHI) 0 cos(PHI) ];% Roll rotation
Rni  = [ 1 0 0; 0 cos(NI) -sin(NI); 0 sin(NI) cos(NI) ];    %Pitch rotation
Rmu  = [ cos(MU) -sin(MU) 0; sin(MU) cos(MU) 0; 0 0 1 ];    % Yaw rotation

% Target's trajectory unit vector
Iv = [ -cos(NI)*sin(MU), cos(NI)*cos(MU), sin(NI) ];  

% target's own motions rotation vector
omegami = calc_omegami(0,amp,per,phase);  

% target's own motions rotation vector with respect to the radar reference system
omega0b = ( Rmu*Rni*Rphi )*omegami';      
omega0b = omega0b';                       

% Target's scatterers position with respect to LoS 
posTy = pos0(posTz,amp,per,phase);  

% radar-target distance at time t=0.
Ro = sqrt( Po(1)^2 + Po(2)^2 + Po(3)^2 );  
Vrng = ( 1/Ro )*( Po ); % LoS

e3 = [ 0 0 1 ];         
V1 = cross( Vrng, e3 );                        
V1 = V1/sqrt(sum(V1.^2));  % First cross-range.

V2 =  cross( V1, Vrng );                              
V2 = V2/sqrt(sum(V2.^2));  % Second cross-range.

% apparent target rotation speed component due to the translational motion
omega0d = calc_omegad( v, Ro, 0, Iv, Vrng ); 

% total target's rotation speed vector
omega0t = omega0d + omega0b; 

% effective rotation speed vector
omegaeff = cross(Vrng,(cross(omega0t,Vrng))); 

Vcrg = cross( Vrng, omegaeff );  % 
Vcrg = Vcrg/sqrt(sum(Vcrg.^2));   % cross-range unit vector