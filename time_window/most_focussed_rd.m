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

s = filedata;
%% image formation

% initial window definition

dN = 64;
dstep = 16;
Tr = Tob/(N-1);
% zp = 2; % zero pedding factor

for mm = 1:floor((N-dN)/dstep)
    
    filedata = filedata_orig(1+(mm-1)*dstep:(mm-1)*dstep+dN,:);
    t = linspace( -Tr*dN/2, Tr*dN/2, dN );

    autofocus
    
    [I Ic] = rd(filedata,zp);
    
    ICon(mm) = sqrt(mean2((I-mean2(I)).^2))/mean2(I.^2);
    
end

[maxcon indmax] = max(ICon);

mcn_new = maxcon;

enl_step = 4;

for nn = 1:N
    
    if (indmax-1)*dstep+1-enl_step*nn>0 && (indmax-1)*dstep+dN+enl_step*nn<=N
        
        if mcn_new >= .95*maxcon
            
            maxcon = mcn_new;
            
            filedata = filedata_orig((indmax-1)*dstep+1-enl_step*nn:(indmax-1)*dstep+dN+enl_step*nn,:);

            t = linspace( -Tr*(dN/2+enl_step*nn), Tr*(dN/2+enl_step*nn), dN+2*enl_step*nn );

            autofocus

            [I Ic] = rd(s,zp);

            mcn_new = sqrt(mean2((I-mean2(I)).^2))/mean2(I.^2);
            
            maxnn = nn;
                        
        end
        
    end
    
end

start_frame = (indmax-1)*dstep+1-enl_step*maxnn;
end_frame = (indmax-1)*dstep+dN+enl_step*maxnn;
disp(['The selected frame starts at ',num2str(start_frame),' and ends at ',num2str(end_frame)])
disp(['The length of the selected frame is ',num2str(end_frame-start_frame+1)])
figure
imagesc(I)
title('Most focussed ISAR image')
xlabel('Range')
ylabel('Cross-range')
colormap(hot)
colorbar

sr = 20;
scr = 40;
Ics = circs(I,sr,scr,'Shifted most focussed ISAR Image');




