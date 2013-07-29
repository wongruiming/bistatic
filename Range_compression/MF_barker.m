function bms=MF_barker(bc,f0,Ti,us,zp,SNR,theta0)

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

%---------------
% defines a Barker code phase modulated signal and calculate the phase
% cross-correlation at the receiver
% example: bms=MF_barker(4,5,1,100,4,inf,0);
%---------------

close all

%%% Barker codes

switch bc
    
    case 1 
        bcode = [1,-1]
    case 2
        bcode = [1,1,-1]
    case 3
        bcode = [1,1,-1,1]
    case 4
        bcode = [1,1,1,1,1,-1,-1,1,1,-1,1,-1,1]
end

N = length(bcode);
    

M=us*N;

MM = zp*M;
Tob = zp*Ti;
t=linspace(-Ti/2,Ti/2,M);
tzp=linspace(-Tob/2,Tob/2,MM);
tout = linspace(-Tob,Tob,2*MM-1);
theta0 = theta0*pi/180;

phic = pi/2 - bcode*pi/2;

phimat = phic.'*ones(1,us);

phis = reshape(phimat.',1,M);

phi = cat(2,phis,zeros(1,MM-M));

phi = circshift(phi,[0,(MM-M)/2]);

xbc_bb = cos(phis+theta0);

xbc_bb = cat(2,xbc_bb,zeros(1,MM-M));

xbc_bb = circshift(xbc_bb,[0,(MM-M)/2]);

xbc = cos(2*pi*f0*t+phis+theta0);

%%% add AWGN

sp = sum((abs(xbc)).^2)
snr = 10^(SNR/10);
np = sp/snr;
w = sqrt(np/2/M)*(randn(1,M) + j*randn(1,M));

xbc = xbc + w;

xbc = cat(2,xbc,zeros(1,MM-M));

xbc = circshift(xbc,[0,(MM-M)/2]);

figure
plot(tzp,phi)
title('Phase code')
xlabel('Time (s)')
ylabel('Phase')
grid on

figure
plot(tzp,xbc_bb)
title('Baseband Tx signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on


figure
plot(tzp,xbc)
title('Tx signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

srif = cos(2*pi*f0*t);

srif = cat(2,srif,zeros(1,MM-M));

srif = circshift(srif,[0,(MM-M)/2]);

ct = srif.*xbc;

CT = fft(ct);

% figure
% plot(abs(CT(1:MM/2)))

CTT = CT(1:MM/us); % baseband filter: it filters out the higher frequency demodulatio components

ct = ifft(CTT,MM);

figure
plot(tzp,real(ct));
title('Demodulated signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

rec_code = sign(real(ct(us*([1:N]+(zp*N-N)/2)-us/2)))

figure
plot(rec_code,'.')
grid on
title('recovered code')

bms = xcorr(rec_code,bcode);

% tbc =[0:Ti/N:Ti/N*(2*N-2)];
tbc =[-Ti/N*(N-1):Ti/N:Ti/N*(N-1)];

figure
plot(tbc,bms)
title('Cross-correlation output')
xlabel('n')
ylabel('Cross-correlation')
grid on




