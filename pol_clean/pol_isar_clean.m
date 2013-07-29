%%% Multi Pol CLEAN

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

close all

masksize = zp*2; % removal frame (mask_size = 0 means only one pixel is removed, mask_size = 1 means 9 pixels are removed)
Ma = 10; % number of chirp rates
b = [-1/2/Tob^2,1/2/Tob^2]; % chirp rate bounds
a = linspace(b(1),b(2),Ma).';
[Nzp] = zp*[N];
[Mzp] = zp*[M];

indran = zeros(1,numscat);
est_ampl = zeros(3,numscat);
inddop = zeros(1,numscat);
indpol = zeros(1,numscat);
aopt = zeros(1,numscat);

tzp = linspace(-Tob/2,Tob/2,Nzp);

Icp = pauli_repr(Ic);
Ip = abs(Icp);

clean_image = zeros(Nzp,Mzp,3);

for mm = 1:numscat

    % find max position in the pol image
    
        [maxdop inddp] = max(Ip);
        [maxran indrn] = max(maxdop);
        [maxim indpol(mm)] = max(maxran);
        indran(mm) = indrn(indpol(mm));
        inddopr = inddp(1,indran(mm),indpol(mm)); 

        % select range cell where the max has been found

        rcd = ifft(Icp(:,indran(mm),indpol(mm))).'; % slow time domain

        % calculate the polynomial FT

        pFT = polyFT(rcd,b,Ma,tzp);

        [maxdop inddp] = max(abs(pFT));
        [maxval inda] = max(maxdop);
        inddop(mm) = inddp(inda);

        aopt(mm) = a(inda);
        
        for np = 1:3
            
            rcd = ifft(Icp(:,indran(mm),np)).'; % slow time domain

            pFT = polyFT(rcd,aopt(mm),Ma,tzp);
            
            est_ampl(np,mm) = pFT(inddop(mm));
           
            % scatterer removal

            Icp(inddop(mm)-masksize:inddop(mm)+masksize,indran(mm)-masksize:indran(mm)+masksize,np) = zeros(2*masksize+1,2*masksize+1);
        
            clean_image(inddop(mm),indran(mm),np) = est_ampl(np,mm);

        end



        Ip = abs(Icp);
        
        norm=zeros(1,3);
        norm(1)=max(max(abs(Ip(:,:,1))));
        norm(2)=max(max(abs(Ip(:,:,2))));
        norm(3)=max(max(abs(Ip(:,:,3))));
        norm=max(norm);
        Irgb(:,:,1)=abs(Ip(:,:,1))/norm;
        Irgb(:,:,2)=abs(Ip(:,:,2))/norm;
        Irgb(:,:,3)=abs(Ip(:,:,3))/norm;

        figure(4)
        hold on
        image(Irgb);
        title(['RGB Image after removing ',num2str(mm),' scatterers']);
        xlabel('Range')
        ylabel('Cross-range')

        norm=zeros(1,3);
        norm(1)=max(max(abs(clean_image(:,:,1))));
        norm(2)=max(max(abs(clean_image(:,:,2))));
        norm(3)=max(max(abs(clean_image(:,:,3))));
        norm=max(norm);
        Irgb(:,:,1)=abs(clean_image(:,:,1))/norm;
        Irgb(:,:,2)=abs(clean_image(:,:,2))/norm;
        Irgb(:,:,3)=abs(clean_image(:,:,3))/norm;

        figure(5)
        hold on
        image(Irgb);
        title(['RGB Image after extracting ',num2str(mm),' scatterers']);
        xlabel('Range')
        ylabel('Cross-range')

%         keyboard

end


