function [I Ic] = rd(s,zp)

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


[N M] = size(s);

%% data windowing for SLL reduction

kp = 2;
kaiser_win = kaiser(N,kp)*kaiser(M,kp).';
s = s.*kaiser_win;

%% Image formation

Ic = fft2(s,zp*N,zp*M);

I = abs(Ic);