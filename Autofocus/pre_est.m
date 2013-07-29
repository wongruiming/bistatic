%%% provides an initial guess for the radial velocity and acceleration

transf = fft(filedata.'); % FT into delay-slow time domain
maxval = max(max(abs(transf)));
transf1=abs(transf);
mask=transf1>0.8*maxval;
transf2=mask.*transf1; % noise filtering mask

r = radon(transf2); % Radon transform

% figure
% imagesc(r)
% 
% keyboard

[mar indr] = max(r);
[mat indt]=max(mar);
indteta = (indt-1)-90; % angle in the radon domain
teta_rad = indteta/180*pi;     

dtao = 1/B; % Delay time resolution

betaapp=c*dtao*tan(teta_rad)/(2*Tr);   % estimation of the radial velocity

presize = 32; % data size reduction for fast implementation (must be >= original data size)

srx=filedata(1:presize,1:presize);

t1=t(1:presize);
f1=f(1:presize);

gm = 5; % max value of the radial acceleration
Nc = 100;
vettgamma=linspace(-gm,gm,Nc);
contr = zeros(1,Nc);
for n=1:Nc,
    gamma=vettgamma(n);
    contr(n)=imcon([betaapp,gamma],srx,t1,fstep,fmin); % 1D opt. problem
end

[maxcontr ind] = min(contr);

gammaapp=vettgamma(ind);    % estimation of radial acceleration

deltaapp = 0; % second order acceleration is set equal to zero

