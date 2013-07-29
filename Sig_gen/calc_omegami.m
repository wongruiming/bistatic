
function [ om, ompr, omse ] = calc_omegami( t, amp, per, phase )

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

%%% calculates the components of the rotation vector due to the target's
%%% oscillations

pitch = (2*pi/per(1))*amp(1)*cos( (2*pi/per(1))*t + phase(1) );   
roll  = (2*pi/per(2))*amp(2)*cos( (2*pi/per(2))*t + phase(2) );       
yaw   = (2*pi/per(3))*amp(3)*cos( (2*pi/per(3))*t + phase(3) );      

om = [pitch roll yaw];                      


