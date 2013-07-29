%%% provides an initial guess for the radial velocity and acceleration

transf = fft(filedata.'); % FT into delay-slow time domain
maxval = max(max(abs(transf)));
transf1=abs(transf);
mask=transf1>0.3*maxval;
transf2=mask.*transf1; % noise filtering mask

rcoord = linspace(0,c/2/B*(M-1),M);
tcoord = linspace(0,Tob,N);

figure
imagesc(tcoord,rcoord,transf2)
xlabel('Time (s)')
ylabel('Range (m)')

betaapp=input('Please guess the radial velocity  ');   % estimation of the radial velocity

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

