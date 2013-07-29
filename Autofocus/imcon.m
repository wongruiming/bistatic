% funzione CONTRASTOBETAGAMMA: definisco la funzione da massimizzare

function contr=imcon(x,srx,t,fstep,fmin)

c=3e8;
[N,M]=size(srx);

fmax=(M-1)*fstep+fmin;
f=linspace(fmin,fmax,M);


H=zeros(N,M);

for n=1:N,
   for m=1:M,
      H(n,m)=exp(sqrt(-1)*4*pi*f(m)*(x(1)*t(n)+x(2)*(t(n))^2)/c);
   end
end

immag=srx.*H;

im=ifft2(immag);

Im=abs(im);

I=mean2(Im);
con=sqrt(mean2((Im-I).^2))/I;
contr=-con;