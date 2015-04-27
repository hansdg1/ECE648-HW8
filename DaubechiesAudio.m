function [ MSE ] = DaubechiesAudio( AUDIO, SAMPLE_RATE, alpha )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Calculate things
NUM_SAMPLES = length(AUDIO); %Total number of samples
AUDIO = AUDIO';

% SET MODE
dwtmode('per','nodisp');

% DECONSTRUCT WAVEFORM
NUMLEVELS = 5;
[Coef,S] = wavedec(AUDIO, NUMLEVELS, 'db10');

% COMPRESSION
Sorted = sort(abs(Coef), 'descend');
Cutoff = Sorted(round(NUM_SAMPLES*alpha));
Coef(abs(Coef) < Cutoff) = 0;


% RECONSTRUCT WAVEFORM
Final = waverec(Coef, S, 'db10');
sound(Final, SAMPLE_RATE);
MSE = mse(AUDIO - Final);
fprintf('MSE for D.A. %.2f: %d\n',alpha,MSE)

end