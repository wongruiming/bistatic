%%% Cameron decomposition and classification

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


%Pauli basis (4D)
Sa=(1/sqrt(2))*[1 0 0 1];
Sb=(1/sqrt(2))*[1 0 0 -1];
Sc=(1/sqrt(2))*[0 1 1 0];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Csi angle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
csi=zeros(numscat,1);
for l=1:numscat
appo1(l)=abs(est_ampl(2,l)).^2-abs(est_ampl(3,l)).^2;
appo2(l)=est_ampl(2,l).*conj(est_ampl(3,l))+conj(est_ampl(2,l)).*est_ampl(3,l);
appo3(l)=sqrt((appo2(l))^2+(appo1(l))^2);
    if (appo1(l)==0)&(appo2(l)>0)
        csi(l)=pi/2;
    elseif (appo1(l)==0)&(appo2(l)<0)
        csi(l)=-pi/2;
    elseif (appo1(l)==0)&(appo2(l)==0)
        csi(l)==pi/2;
    else 
        x1(l)=asin(appo2(l)/appo3(l));
        if (x1(l)>=0)
            x2(l)=pi-x1(l);
        else 
            x2(l)=-pi-x1(l);
        end;
        x3(l)=(appo1(l)/appo3(l));
        if (cos(x1(l))-x3(l)<(10^(-5)))
            csi(l)=x1(l);
        else
            csi(l)=x2(l);
        end;
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Symmetry
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
teta=csi/2;%Max symmetric component
Srec = zeros(numscat,4);
Srec(:,1) = sqrt(2)/2*(est_ampl(1,:)-est_ampl(2,:)).';
Srec(:,2) = sqrt(2)/2*(est_ampl(3,:)).';
Srec(:,3) = sqrt(2)/2*(est_ampl(3,:)).';
Srec(:,4) = sqrt(2)/2*(est_ampl(1,:)+est_ampl(2,:)).';
S_appo=zeros(numscat,4);
for l=1:numscat
        S_appo(l,:)=cos(teta(l))*Sb.'+sin(teta(l))*Sc.';
end;
ps1=zeros(numscat,1);
for l=1:numscat
    ps1(l)=Srec(l,:)*Sa';
end;

ps2=zeros(numscat,1);
for l=1:numscat
    ps2(l)=Srec(l,:)*S_appo(l,:)';
end;

DSrec=zeros(numscat,4);
for l=1:numscat
    DSrec(l,:)=ps1(l)*Sa+ps2(l)*S_appo(l,:);
end;
ps=zeros(numscat,1);
for l=1:numscat
    ps(l)=(Srec(l,:))*DSrec(l,:)';
end;

norma1=zeros(numscat,1);
for l=1:numscat
    norma1(l)=sqrt(Srec(l,:)*Srec(l,:)');
end;

norma2=zeros(numscat,1);
for l=1:numscat
    norma2(l)=sqrt(DSrec(l,:)*DSrec(l,:)');
end;

tau=acos(abs(ps./(norma1.*norma2)));
ind=find(tau<=(pi/8));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IF TAU>PI/8 THE SCATTERER IS CLASSIFIED AS NON-SYMMETRIC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind_asym=find(tau>pi/8);
class_est=zeros(numscat,1);
LL_asym=length(ind_asym);
for k=1:LL_asym
    class_est(ind_asym)=7;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ORIENTATION ANGLE ESTIMATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LL=length(ind);
psi1=-csi(ind)/4;
psi2=psi1+pi/2;
psi3=psi1-pi/2;
for ll=1:LL
    if (psi1(ll)<=pi/2)&(psi1(ll)>-pi/2)
        V1=(rotmat(psi1(ll)))*(DSrec(ind(ll),:)).';
        a=abs(V1(1));
        b=abs(V1(4));
        if a>=b
            psi(ll)=psi1(ll);
        end;
    end;
    if (psi2(ll)<=pi/2)&(psi2(ll)>-pi/2)
        V2=(rotmat(psi2(ll)))*(DSrec(ind(ll),:)).';
        a=abs(V2(1));
        b=abs(V2(4));
        if a>=b
            psi(ll)=psi2(ll);
        end;
    end;
    if (psi3(ll)<=pi/2)&(psi3(ll)>-pi/2)
        V3=(rotmat(psi3(ll)))*(DSrec(ind(ll),:)).';
        a=abs(V3(1));
        b=abs(V3(4));
        if a>=b
            psi(ll)=psi3(ll);
        end;
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rotation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R=zeros(4,4);
LAMBDA=zeros(LL,4);
for ll=1:LL
    R(:,:)=rotmat(psi(ll));
    norm=sqrt(DSrec(ind(ll),:)*DSrec(ind(ll),:)');
    LAMBDA(ll,:)=(R(:,:)*(DSrec(ind(ll),:)).'/norm);
end;

rho_est=-angle(LAMBDA(:,1));
LAMBDA=LAMBDA.*repmat(exp(i*rho_est),1,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scatterer metric calculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LAMBDA_ele=zeros(4,6);
LAMBDA_ele(:,1)=(1/sqrt(2))*[1;0;0;1];%trihedral
LAMBDA_ele(:,2)=(1/sqrt(2))*[1;0;0;-1];%dihedral
LAMBDA_ele(:,3)=[1;0;0;0];%dipole
LAMBDA_ele(:,4)=(1/sqrt(1+1/4))*[1;0;0;-1/2];%narrow diplane
LAMBDA_ele(:,5)=(1/sqrt(1+1/4))*[1;0;0;1/2];%cylinder
LAMBDA_ele(:,6)=(1/sqrt(2))*conj([1;0;0;i]);%1/4 wave

metrics=abs((LAMBDA)*LAMBDA_ele);
[val,indmet]=max(metrics,[],2);

for ll=1:LL
    class_est(ind(ll))=indmet(ll);
end;

%map
map=zeros(8,3);
sat=0.8;
val=1;
for l=1:7;
    hue=l/7;
    map(l+1,:)=hsv2rgb([hue,sat,val]); 
end;
figure;imagesc(class_est,[-0.5 7+0.5]);colormap(map);
HC=colorbar('horiz');set(HC,'xtick',[0:1:7]);
grid on
xlabel(['1 - trihedral       2 - dihedral' ; '3 - dipole    4 - narrow diplane' ; '5 - cylinder        6 - 1/4 wave'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

