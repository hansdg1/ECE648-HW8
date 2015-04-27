function [ Final ] = DaubechiesImage( IMAGE, alpha )
%DAUBECHIESIMAGE Summary of this function goes here
%   Detailed explanation goes here

% SET MODE
dwtmode('per','nodisp');

% DECONSTRUCT WAVEFORM
NUMLEVELS = 4;
[Coef,S] = wavedec2(IMAGE, NUMLEVELS, 'db4');

% COMPRESSION
Sorted = sort(abs(Coef), 'descend');
Cutoff = Sorted(round(256*256*alpha));
Coef(abs(Coef) < Cutoff) = 0;

% RECONSTRUCT IMAGE
Final = double(waverec2(Coef, S, 'db4'));
MSE = mse(IMAGE(:)-Final(:));
fprintf('MSE for D.I. %.2f: %d\n',alpha,MSE)

end

