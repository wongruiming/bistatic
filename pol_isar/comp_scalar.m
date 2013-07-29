function scp = comp_scalar(srx,param2,t,fstep,fmin)

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


k1 = param2(1); %%%radial velocity
k2 = param2(2); %%%radial acceleration



[N,M]=size(srx);

c=3e8;

fmax=(M-1)*fstep+fmin;
f=linspace(fmin,fmax,M);


Hcomp=0;
for n=1:N,
   for m=1:M,
      Hcomp(n,m)=exp(j*4*pi*f(m)*(k1*t(n)+k2*(t(n))^2)/c);
   end
end

scp = srx.*Hcomp;