function ch=MF_chirp2(a,Ti,N,fd,SNR)

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

%%% Example ch=MF_chirp(1,10,1000,0,inf);

%---------------
% defines a baseband chirp signal and calculates the output of the 
% relative Matched Filter 
%---------------

t=linspace(-Ti/2,Ti/2,N);
f=linspace(-N/2/Ti,N/2/Ti,N);
xch=exp(j*pi*a*t.^2);
ch=(1/N)*fftshift((abs(fft(xch))));
% ch(1:M)=ch(mod(M/2:(M/2+M-1),M)+1);
chdB=10*log(ch);
chdB=chdB-max(chdB);

%%% Add Gaussian White Noise
sp = sum((abs(xch)).^2);
snr = 10^(SNR/10);
np = N/snr;
w = sqrt(np/2/N)*(randn(1,N) + j*randn(1,N));
rx = xch.*exp(j*2*pi*fd*t) + w;
hmf = conj(fliplr(xch));

fout = linspace(-N/2/Ti,N/2/Ti,2*N-1);
tout = linspace(-Ti,Ti,2*N-1);
sout = conv(rx,hmf);

%%%plots the real part of the uncompressed chirp signal
figure(1)
plot(t,real(rx))
title('Chirp Signal - Real part')
xlabel('Time (s)')
ylabel('Real part')
grid on
axis([-Ti,Ti,-1,1])

%%% plots the chirp spectrum amplitude in dB
figure(2)
plot(f,chdB)
title('Chirp Spectrum')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
axis([-4*Ti*a,4*Ti*a,-60,0])

%%% Side lobe Leveling
Sout = fftshift(fft(sout)); % linear

KW = kaiser(floor(2*a*Ti^2),3);
Sout(N-floor(a*Ti^2):N-floor(a*Ti^2)+floor(2*a*Ti^2)-1) = Sout(N-floor(a*Ti^2):N-floor(a*Ti^2)+floor(2*a*Ti^2)-1).*KW.';
wsout = ifft(fftshift(Sout));
% wsout = wsout * max(abs(sout)) / max(abs(wsout));

%%%plots the non-weighted compressed pulse
figure(3)
plot(tout,20*log10(abs(sout))-max(20*log10(abs(sout))))
title('Output Signal')
xlabel('Time (s)')
ylabel('Magnitude')
grid on
axis([-Ti/2,Ti/2,-60,0])

%%% plots the weighted compressed pulse
figure(4)
plot(tout,20*log10(abs(wsout))-max(20*log10(abs(sout))),'r')
title('Output Signal - Weighted')
xlabel('Time (s)')
ylabel('Magnitude')
grid on
axis([-Ti/2,Ti/2,-60,0])

