%%% main
clear all
close all
clc

addpath('Autofocus','Clean','Image_formation','image_scaling')
addpath('pol_clean','pol_dec','pol_isar','Range_compression')
addpath('Sig_gen','tftb','time_window')

global omegami
global per phase

type = 1; % frequency-slow time signal generation
% type = 2 % fast time-slow time signal generation

comp = 1; % uncompemsated signal is generated
% comp = 2; % compnesated signal is generated

target_generation

target_or_mot

H = target_display(posTz);

radar_target_kin

signal_gen

if comp == 1

    autofocus
    
end

%%% image formation

zp = 2; % zero pedding factor

%% JTFA

% currDir = cd;
% movieFileName = ['test'];
% mov = avifile(movieFileName, 'fps', 1, 'QUALITY', 100);

src = fftshift(fft(filedata,[],2),2); % range compression

K = 10; %number of frames

[I Ic] = jtfa(src,zp,K);

%%
for nn = 1:K

    figure(5)
    imagesc(10*log10(fftshift(squeeze(I(:,nn,:))))-max(max(10*log10(fftshift(squeeze(I(:,nn,:)))))),[-40,0])
    title(['JTFA - ',num2str(nn)])
    colorbar
    colormap(jet)
    pause(0.5);
%     Fi = getframe(gcf);
%     mov = addframe(mov,Fi);
    
end

%%
% mov = close(mov);

% %% image shift (central image)
% 
% IN2 = squeeze(I(:,ceil(K/2),:));
% 
% sr = 30;
% scr = 300;
% Ics = circs(IN2,sr,scr,'Shifted Range-Instantaneous-Doppler ISAR Image');




