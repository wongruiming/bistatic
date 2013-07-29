% funzione CONTRASTOBETAGAMMA: definisco la funzione da massimizzare

function contr=measure_imcon(srx)

Im=abs(ifft2(srx)); % RD map before fftshift

I=mean2(Im);
contr=sqrt(mean2((Im-I).^2))/I;
