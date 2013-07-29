% funzione CONTRASTOBETAGAMMA: definisco la funzione da massimizzare

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


function contr=contr_pol(x,V,t,fstep,fmin)

c=3e8;

k1 = x(1); %%%radial velocity
k2 = x(2); %%%radial acceleration

alpha = x(3); %%% is an internal degree of freedom of the scatterer that ranges in the interval [0 90]
beta = x(4); %%% physical rotation of the scatterer
delta = x(5); %%% scatterer phase
gamma = x(6); %%% scatterer phase
phi = x(7); %%% scatterer phase

srx = pauli_proj(V,alpha,beta,delta,gamma,phi);

[N,M]=size(srx);
% N: numero di sweep
% M: numero di frequenze

fmax=(M-1)*fstep+fmin;
f=linspace(fmin,fmax,M);

H=0;
for n=1:N,
   for m=1:M,
      H(n,m)=exp(sqrt(-1)*4*pi*f(m)*(x(1)*t(n)+x(2)*(t(n))^2)/c);
%       H(m,n)=exp(sqrt(-1)*4*pi*f(m)*(x(1)*t(n)+x(2)*(t(n))^2)/c);
   end
end

Immagine=abs(fft2(srx.*H));

I=mean2(Immagine);
con=sqrt(mean2((Immagine-I).^2))/I;

contr=-con;