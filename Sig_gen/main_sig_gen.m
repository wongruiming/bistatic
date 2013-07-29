%%% main sig gen

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
global type comp

% type = 1; % frequency-slow time signal generation
type = 2 % fast time-slow time signal generation

% comp = 1; % uncompemsated signal is generated
comp = 2; % compensated signal is generated

target_generation

target_or_mot

H = target_display(posTz,'Target');

radar_target_kin

signal_gen

%% display generated data
figure
imagesc(abs(filedata))
xlabel('time bin')
ylabel('frequency bin')
title('Data - Intensity')