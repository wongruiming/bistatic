%%% main_movie_rd

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

zp = 4; % zero pedding factor

type = 1; % frequency-slow time signal generation
% type = 2 % fast time-slow time signal generation

comp = 1; % uncompemsated signal is generated
% comp = 2; % compnesated signal is generated


target_generation

target_or_mot

H = target_display(posTz,'Target');

radar_target_kin

signal_gen

filedata_orig = filedata;


%% image formation

currDir = cd;
movieFileName = ['test'];
mov = avifile(movieFileName, 'fps', 1, 'QUALITY', 100);

% window definition

dN = 128;
dstep = 64;
Tr = Tob/(N-1);

for mm = 1:floor((N-dN)/dstep)
    
    filedata = filedata_orig(1+(mm-1)*dstep:(mm-1)*dstep+dN,:);
    t = linspace( -Tr*dN/2, Tr*dN/2, dN );

    autofocus

    [I Ic] = rd(filedata,zp);
    
    I = im_cen(I);
    figure(2)
    imagesc(I)
    title(['Range-Doppler ISAR Image - frame ',num2str(mm)])
    xlabel('Range')
    ylabel('Cross-range')

    Fi = getframe(gcf);
    mov = addframe(mov,Fi);
    
end

mov = close(mov);



