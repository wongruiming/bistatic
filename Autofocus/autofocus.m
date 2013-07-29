%%% Radial Motion Compensation

fstep = B/(M-1);
fmin = fo-B/2;

pre_est %% provides an initial guess

options_contr = ...
    optimset('TolX',1e-6,'MaxFunEvals',100,'MaxIter',100,'Display','off');

[param3 ic]=fminsearch(@imcon,[betaapp,gammaapp,deltaapp],...
    options_contr,filedata,t,fstep,fmin);

beta=param3(1);
gamma=param3(2);
delta = param3(3);

r0t = beta*t + gamma*t.^2 + delta*t.^3;
% r0t = betaapp*t + gammaapp*t.^2 + 0;

Hcomp = exp(j*4/c*pi*r0t'*f);

filedata = filedata.*Hcomp;

