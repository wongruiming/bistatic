function [Icen Cm Cn] = im_cen(Ic)

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


%%% Image centering based on centroid

I = sum(abs(Ic),3);
Icen = Ic;

[N M] = size(I);

for mm = 1:2

    oM = cumsum(ones(1,M));

    Cm1 = sum(sum(I).*oM)/sum(sum(I));

    Im1 = circshift(sum(I),[0,-round(Cm1)+floor(M/2)]);

    vm1 = sum((Im1.*(oM-floor(M/2))).^2);

    Im2 = fftshift(Im1);

    vm2 = sum((Im2.*(oM-floor(M/2))).^2);

    if vm1<vm2

        Cm = Cm1;

    else

        Cm = mod(Cm1+M/2,M);

    end

    oN = cumsum(ones(1,N));

    Cn1 = sum(sum(I.').*oN)/sum(sum(I));

    In1 = circshift(sum(I.'),[0,-round(Cn1)+floor(N/2)]);

    vn1 = sum((In1.*(oN-floor(N/2))).^2);

    In2 = fftshift(In1);

    vn2 = sum((In2.*(oN-floor(N/2))).^2);

    if vn1<vn2

        Cn = Cn1;

    else

        Cn = mod(Cn1+N/2,N);

    end

    Icen = circshift(Icen,[-round(Cn)+floor(N/2),-round(Cm)+floor(M/2),0]);

    I = sum(abs(Icen),3);
    
%     figure
%     imagesc(I)
    
end


        
        