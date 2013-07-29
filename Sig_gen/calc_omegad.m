
function [ om ] = calc_omegad( v, Ro, t, Iv, Vrng )

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


Id = cross( Iv, Vrng ); 
modId = sqrt( Id(1)^2 + Id(2)^2 + Id(3)^2 );
Id = ( 1/(modId+eps))*Id; % direction of apparent rotation vector

% angle between the LoS and the direction of target's trajectory
THETA = asin( modId ); 

d = ( v*t*sin(THETA) )/( Ro + v*t*cos(THETA) ); % target aspect angle

modom = ( v*Ro*sin(THETA) )/( Ro + v*t*cos(THETA) )^2;
om = modom *Id; % apparent rotation speed



