%%% main

% for testing the commit

clear variables
close all
clc

addpath('Autofocus','Clean','Image_formation','image_scaling')
addpath('pol_clean','pol_dec','pol_isar','Range_compression')
addpath('Sig_gen','tftb','time_window')

global omegami
global per phase
global type comp

% type = 1; % frequency-slow time signal generation
type = 2; % fast time-slow time signal generation

% comp = 1; % uncompensated signal is generated
 comp = 2; % compensated signal is generated

% bi_static = 1; % monostatic signal is generated
bi_static = 2; % bistatic signal is generated

target_generation

target_or_mot

% H = target_display(posTz);

radar_target_kin

if bi_static == 1
    signal_gen
else
    signal_gen_bistatic
end

target_display_motion(posTz,Tob,N,numscat,Rphi,Rni,Rmu,Po,Iv,v,...
    bi_static,Po_Tx);


if type == 2 % fast time-slow time signal
    filedata = fftshift(fft(filedata,[],2),2);
    B = 1/Ti;
end

if comp == 1 % uncompensated signal
    autofocus
end

contr = measure_imcon(filedata)

%%% image formation

zp = 10; % zero padding factor

%% Range Doppler

[I Ic] = rd(filedata,zp);

%% automatic image shift

[Icen Cm Cn] = im_cen(Ic);

% figure(3)
% imagesc(abs(Icen))
% title('Range-Doppler ISAR Image')
% xlabel('Range')
% ylabel('Cross-range')

figure(4)
imagesc(20*log10(abs(Icen)/max(abs(Icen(:)))+10e-1).')
set(gca,'YDir','normal')
% ylim([280 380])
% xlim([1100 1450])
title('Range-Doppler ISAR Image')
ylabel('Range')
xlabel('Cross-range')

% figure(5)
% Icen_cs = Icen(:,320);
% plot(20*log10(abs(Icen_cs)/max(abs(Icen_cs(:)))+10e-1).')
% ylim([280 380])
% xlim([1100 1450])
% title('Doppler ISAR Image')
% ylabel('Amplitude [dB]')
% xlabel('Cross-range')

%% manual image shift

% sr = 0;
% scr = 200;
% Ic = circs(Ic,sr,scr,'Shifted Range-Doppler ISAR Image');



%% JTFA

% src = fftshift(fft(filedata,[],2),2);
% 
% K = 1; %number of frames
% 
% [I Ic] = jtfa(src,zp,K);
% 
% 
% for nn = 1:K
% 
%     figure
%     imagesc(fftshift(squeeze(I(:,nn,:))))
%     title(['JTFA - ',num2str(nn)])
%     colorbar
%     colormap(hot)
%     
% end


% %% image shift (central image)
% 
% IN2 = squeeze(I(:,ceil(K/2),:));
% 
% sr = 30;
% scr = 300;
% Ics = circs(IN2,sr,scr,'Shifted Range-Instantaneous-Doppler ISAR Image');

%% ISAR CLEAN

% isar_clean

%% ISAR image full scaling

% isar_scaling