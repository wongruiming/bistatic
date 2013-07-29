function [betaapp gammaapp t] = motion_comp_init(filedata,Tr,fstep,fmin)

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


[N,M]=size(filedata); % N: sweep; M: frequenze
c=3e8;

Toss=N*Tr;
B=fstep*(M-1); % banda del segnale trasmesso
fmax=fmin+B;
f=linspace(fmin,fmax,M);

zp = 2;

t=linspace(-Toss/2,Toss/2-Toss/N,N);

trasf=fft(filedata.',zp*M); % trasformata di Fourier di  ogni sweep del segnale rx

% figure
% imagesc(abs(trasf))

massimo=max(max(abs(trasf)));
trasf1=abs(trasf);
mask=trasf1>0.7*massimo;
trasf2=mask.*trasf1; % mascheratura dell'immagine: rimane solo il 20% dei valori (quelli pi? alti)

r = radon(trasf2);

% figure
% imagesc(r)

% keyboard

[mar indr] = max(r);
[mat indt]=max(mar);
 indteta = (indt-1)-90;% angolo
teta_rad = indteta/180*pi;     % <<-- 

 
dtao = 1/B;


betaapp=c*dtao*tan(teta_rad)/(2*Tr);   % <<--


% faccio Nc cicli in cui calcolo il contrasto tenendo fisso il beta e
% facendo variare gamma all'interno del range [-gm,gm]
% si utilizza un dataset ridotto a 32x32

srx = zeros(N,M*zp);

srx=filedata(1:ceil(N/2),1:ceil(M/2));
% srx(1:N,1:M) = filedata(1:N,1:M);
[Nt,Nf]=size(srx);

t1=t(1:Nt);
% f1=f(1:Nf);

% gm = .002;
gm = 4;
% gm = 20;
Nc = 101;
vettgamma=linspace(-gm,gm,Nc);
contr = zeros(1,Nc);
for n=1:Nc,
    gamma=vettgamma(n);
    contr(n)=contrastobetagamma([betaapp,gamma],srx,t1,fstep,fmin);
%     n
end

[maxcontr ind] = min(contr);

gammaapp=vettgamma(ind);    % <<--

% keyboard

