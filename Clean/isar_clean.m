%%% Single Pol CLEAN

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

Ic = Icen;

masksize = zp*2; % removal frame (mask_size = 0 means only one pixel is removed, mask_size = 1 means 9 pixels are removed)
Ma = 30; % number of chirp rates
bmax = 3*c/2/fo/norm(omegaeff)^2;
b = 10*[-bmax,bmax]; % chirp rate bounds
a = linspace(b(1),b(2),Ma).';
[Nzp] = zp*[N];
[Mzp] = zp*[M];

indran = zeros(1,numscat);
est_ampl = zeros(1,numscat);
inddop = zeros(1,numscat);

tzp = linspace(-Tob/2,Tob/2,Nzp);

I = abs(Ic);
clean_image = zeros(Nzp,Mzp);

for mm = 1:numscat

    % find max position in the image

    [maxdop inddp] = max(I);
    [maxim indran(mm)] = max(maxdop);
    inddopr = inddp(indran(mm)); 

    % select range cell where the max has been found

    rcd = ifft(Ic(:,indran(mm))).'; % slow time domain

    % calculate the polynomial FT


    pFT = polyFT(rcd,b,Ma,tzp);


    [maxdop inddp] = max(abs(pFT));
    [maxval inda] = max(maxdop);
    inddop(mm) = inddp(inda);
    
    aopt(mm) = a(inda);

    est_ampl(mm) = pFT(inddop(mm),inda);
    
    % scatterer removal
    
    Ic(inddop(mm)-masksize:inddop(mm)+masksize,indran(mm)-masksize:indran(mm)+masksize) = zeros(2*masksize+1,2*masksize+1);
    
    I = abs(Ic);
    
    figure (4)
    hold on
    imagesc(I)
    colormap(hot)
    colorbar
    title(['Range-Doppler ISAR Image after removing ',num2str(mm),' scatterers'])
    xlabel('Range')
    ylabel('Cross-range')

    
    clean_image(inddop(mm),indran(mm)) = est_ampl(mm);
    
    figure(5)
    hold on
    imagesc(abs(clean_image))
    colormap(hot)
    colorbar
    title(['CLEAN ISAR image after extracting ',num2str(mm),' scatterers'])
    xlabel('Range')
    ylabel('Cross-range')
    
%     keyboard

end


