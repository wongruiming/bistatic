%%% main pol only type 1 non-compensated signal generation

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



clear all
close all

global omegami
global per phase

pol_target_generation

target_or_mot

D = target_display(posTz,'Target');

radar_target_kin

pol_signal_gen


%% Single pol autofocus

pol_channels = ['HH','VH','HV','VV'];

for nn = 1:4
    
    filedata = H(:,:,nn);
    
    autofocus
    
    zp = 4; % zero pedding factor

    % Range Doppler

    [I(:,:,nn) Ic] = rd(filedata,zp);
        
end

I = im_cen_pol(I);

for nn = 1:4

    figure(2)
    hold on
    subplot(2,2,nn)
    imagesc(I(:,:,nn))
    title(['Channel ',pol_channels((nn-1)*2+1:nn*2)])
    xlabel('Range')
    ylabel('Cross-range')
    colormap(hot)
    colorbar
    
end


%%

Iv = pauli_repr(I);

norm=zeros(1,3);
norm(1)=max(max(abs(Iv(:,:,1))));
norm(2)=max(max(abs(Iv(:,:,2))));
norm(3)=max(max(abs(Iv(:,:,3))));
norm=max(norm);
Irgb(:,:,1)=abs(Iv(:,:,1))/norm;
Irgb(:,:,2)=abs(Iv(:,:,2))/norm;
Irgb(:,:,3)=abs(Iv(:,:,3))/norm;
 
figure;
image(Irgb);title('RGB Image - Single');


%% Multi pol autofocus

global V

V = pauli_repr(H);


alpha_in = pi/4; %%% is an internal degree of freedom of the scatterer that ranges in the interval [0 90]
beta_in =  [0 pi/4 pi/2]; %%% physical rotation of the scatterer
delta_in =  0; %%% scatterer phase
gamma_in =  0; %%% scatterer phase
phi_in =  0; %%% scatterer phase


for nn = 1:3
    %The polarimetric received signal is projected onto the polarisation initial guess 

    s_in = pauli_proj(V,alpha_in,beta_in(nn),delta_in,gamma_in,phi_in);

    filedata = s_in;

    pre_est

    % Estimation of the radial components (velocity and acceleration)

    options_contr_in = optimset('TolX',1e-6,'MaxFunEvals',100,'MaxIter',100);
    [param_in contr_in(nn)]=fminsearch(@imcon,[betaapp gammaapp,0],options_contr_in,s_in,t,fstep,fmin)

    k1_in(nn) = param_in(1); %%%radial velocity
    k2_in(nn) = param_in(2); %%%radial acceleration
    
end

[maxcon indmax] = max(-contr_in);

k1_init = k1_in(indmax);
k2_init = k2_in(indmax);

%% Nelder Mead

init_guess=[k1_init k2_init alpha_in beta_in(indmax) delta_in gamma_in phi_in];

options_contr = optimset('TolX',1e-10,'MaxFunEvals',200,'MaxIter',200);
[param2 contr]=fminsearch(@contr_pol,init_guess,options_contr,V,t,fstep,fmin)

k1 = param2(1); %%%radial velocity
k2 = param2(2); %%%radial acceleration


scp1 = comp_scalar(V(:,:,1),[k1 k2],t,fstep,fmin);
scp2 = comp_scalar(V(:,:,2),[k1 k2],t,fstep,fmin);
scp3 = comp_scalar(V(:,:,3),[k1 k2],t,fstep,fmin);




%% best pol image

alpha = param2(3); %%% is an internal degree of freedom of the scatterer that ranges in the interval [0 90]
beta = param2(4); %%% physical rotation of the scatterer
delta = param2(5); %%% scatterer phase
gamma = param2(6); %%% scatterer phase
phi = param2(7); %%% scatterer phase
srxb = pauli_proj(V,alpha,beta,delta,gamma,phi);

disp('The polarisation projection that provides the most focussed ISAR image is')
if alpha<pi/8
    sc_type = 'Trihedral-like';
elseif alpha<3*pi/8
    sc_type = 'Dipole-like'
else
    sc_type = 'Dihedral-like'
end
disp(['Alpha = ',num2str(alpha*180/pi),' - ',sc_type])
disp(['Beta = ',num2str(beta*180/pi),' (degrees)'])


srxb = pauli_proj(V,alpha,beta,delta,gamma,phi);

scb = comp_scalar(srxb,[k1 k2],t,fstep,fmin);

imb = fft2(scb);

%%
im1=((fft2(scp1,zp*N,zp*M)));
im2=((fft2(scp2,zp*N,zp*M)));
im3=((fft2(scp3,zp*N,zp*M)));

[N1,M1]=size(im1);

norm=zeros(1,3);
norm(1)=max(max(abs(im1)));
norm(2)=max(max(abs(im2)));
norm(3)=max(max(abs(im3)));
norm=max(norm);
I=zeros(N1,M1,3);
I(:,:,1)=abs(im1)/norm;
I(:,:,2)=abs(im2)/norm;
I(:,:,3)=abs(im3)/norm;

%%automatic image shift

I = im_cen_pol(I);

figure;
image(I);title('RGB Image - Multi');

%%best pol image

imb = im_cen_pol(imb);

figure
imagesc(abs(imb));colormap('hot');colorbar;title('best pol Image');

%%
%%% plot principal channels

scph1 = comp_scalar(H(:,:,1),[k1 k2],t,fstep,fmin);
scph2 = comp_scalar(H(:,:,2),[k1 k2],t,fstep,fmin);
scph3 = comp_scalar(H(:,:,3),[k1 k2],t,fstep,fmin);
scph4 = comp_scalar(H(:,:,4),[k1 k2],t,fstep,fmin);

Ic(:,:,1) = fft2(scph1,zp*N,zp*M);
Ic(:,:,2) = fft2(scph2,zp*N,zp*M);
Ic(:,:,3) = fft2(scph3,zp*N,zp*M);
Ic(:,:,4) = fft2(scph4,zp*N,zp*M);

Ic = im_cen_pol(Ic);

figure
subplot(2,2,1)
imagesc(abs(Ic(:,:,1)));
title('Channel HH')
xlabel('Range')
ylabel('Cross-range')
colormap(hot)
colorbar

subplot(2,2,2)
imagesc(abs(Ic(:,:,2)));
title('Channel VH')
xlabel('Range')
ylabel('Cross-range')
colormap(hot)
colorbar

subplot(2,2,3)
imagesc(abs(Ic(:,:,3)));
title('Channel HV')
xlabel('Range')
ylabel('Cross-range')
colormap(hot)
colorbar

subplot(2,2,4)
imagesc(abs(Ic(:,:,4)));
title('Channel VV')
xlabel('Range')
ylabel('Cross-range')
colormap(hot)
colorbar

%% Pol ISAR CLEAN

% pol_isar_clean

%% Polarimetric Coherent Decomposition (Cameron)

% Cameron_dec


