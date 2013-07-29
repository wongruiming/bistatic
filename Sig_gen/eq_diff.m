
function F=eq_diff(t,y)

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

global omegami
global per phase

omx1t = omegami(1)*cos( 2*pi*t/per(1) + phase(1) );   
omx2t = omegami(2)*cos( 2*pi*t/per(2) + phase(2) );   
omx3t = omegami(3)*cos( 2*pi*t/per(3) + phase(3) );
omxt=[omx1t omx2t omx3t];

F=cross(omxt,y')';    