function [ Final ] = CoifletImage( IMAGE, alpha )
%COIFLETIMAGE Summary of this function goes here
%   Detailed explanation goes here

% SET MODE
dwtmode('per','nodisp');

% DECONSTRUCT WAVEFORM
NUMLEVELS = 5;
[Coef,S] = wavedec2(IMAGE, NUMLEVELS, 'coif2');

% COMPRESSION
Sorted = sort(abs(Coef), 'descend');
Cutoff = Sorted(round(256*256*alpha));
Coef(abs(Coef) < Cutoff) = 0;

% RECONSTRUCT IMAGE

Final = uint8(waverec2(Coef, S, 'coif2'));
MSE = mse(IMAGE(:)-double(Final(:)));
fprintf('MSE for C.I. %.2f: %d\n',alpha,MSE)

end
