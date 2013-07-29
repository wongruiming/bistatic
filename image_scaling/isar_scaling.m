%%% chirp est based cross range scaling

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


f0 = f(floor(M/2));

% range scaling

if type == 1

    rr = c/2/B/zp; % range bin resolution
    
elseif type == 2
    
    rr = c*Ti/2/zp;
    
end

raxis = [0:rr:rr*(zp*M-1)]; % range axis

indr = raxis(indran);

%% check if chirp estimates are reliable

sel_sc = find(aopt>b(1) & aopt<b(2));

if length(sel_sc) > 1

    indr = indr(sel_sc);
    aopt = aopt(sel_sc);

    clean_image_red = zeros(N,M);

    for mm = 1:length(sel_sc)

        clean_image_red(inddop(sel_sc(mm)),indran(sel_sc(mm))) = est_ampl(sel_sc(mm));

    end


    %%
    figure
    plot(indr,aopt,'.')

    [aa S] = polyfit(indr,aopt,1); % straight line slope

    bb = (indr*aopt.' - mean(indr)*sum(aopt)) / (indr*indr.' - mean(indr)*sum(indr)); %% MLS closed form solution for the above
    

    om_est = sqrt(c/2/f0*abs(aa(1))); % estimated effective rotation vector modulus

    eff_rot_mod = norm(omegaeff); % actual effective rotation vector modulus

    disp(['The modulus of the actual effective rotation vector is equal to ',num2str(eff_rot_mod),' rad/s'])
    disp(['The modulus of the estimated effective rotation vector is equal to ',num2str(om_est),' rad/s'])
    err_per = abs(om_est-eff_rot_mod)/eff_rot_mod*100; % effective rotation vector estimation relative error (in %)
    err_per_scal = abs(1/om_est-1/eff_rot_mod)*eff_rot_mod*100; % scaling factor estimation relative error (in %)
    disp(['The relative percentage error is equal to ',num2str(err_per),'%'])
    disp(['The relative percentage error on the scaling factor is equal to ',num2str(err_per_scal),'%'])
    disp(['The normalised norm of the residuals is equal to ',num2str(S.normr/abs(b(2)-b(1))*2)])
    crr = c/2/f0/om_est/Tob/zp; % cross-range resolution

    craxis = [0:crr:crr*(zp*N-1)]; % cross-range axis

    figure
    imagesc(raxis,craxis,abs(Icen))
    colormap(hot)
    colorbar
    title('Fully scaled ISAR image')
    xlabel('Range (m)')
    ylabel('Cross-range (m)')
    
else
    
    disp('Chirp rate estimates are not accurate enough to apply this technique')
    
end

