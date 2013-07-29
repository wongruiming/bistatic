function pFT = polyFT(x,b,Ma,t)

% calculates the second order polynomial FT

if length(b) == 2

    a = linspace(b(1),b(2),Ma).';

    A = exp(j*2*pi*a*t.^2);

    X = repmat(x,Ma,1);

    Y = X.*A;

    pFT = fft(Y.');

elseif length(b) == 1
    
    A = exp(j*2*pi*b*t.^2);

    Y = x.*A;

    pFT = fft(Y.');
    
else
    
    disp('b must have one or two components')
    
end

    