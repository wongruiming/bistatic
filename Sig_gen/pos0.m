
function vett = pos0( yTz, amp, per, phase )

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

alpha = amp'.*sin(phase');  %rotation due to the initial phase of target's own motions

rot1 = [ 1 0 0; 0 cos(alpha(1)) -sin(alpha(1)); 0 sin(alpha(1)) cos(alpha(1)) ];   % Pitch
rot2 = [ cos(alpha(2)) 0 sin(alpha(2)); 0 1 0; -sin(alpha(2)) 0 cos(alpha(2)) ];   % Roll
rot3 = [ cos(alpha(3)) -sin(alpha(3)) 0; sin(alpha(3)) cos(alpha(3)) 0; 0 0 1 ];   % Yaw

yTy = ( rot3*rot1*rot2 )*yTz';      % Rotation

vett = yTy';



