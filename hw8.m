%------------------------------------------------
%----------------AUDIO COMPRESSION---------------
%================================================

% READ IN FILE
[Audio, fs1, BitsPerSample1] = wavread('audio1.wav');
NumSamples = wavread('audio1.wav', 'size');
Audio = Audio';

% SET MODE
dwtmode('per','nodisp');

% DECONSTRUCT WAVEFORM
[Coef,S] = wavedec2(Audio, 5, 'db10');

% COMPRESSION
ALPHA = .9;
Sorted = sort(abs(Coef), 'descend');
Cutoff = Sorted(round(NumSamples(1)*ALPHA));
Coef(abs(Coef) < Cutoff) = 0;

% RECONSTRUCT WAVEFORM
Final = waverec2(Coef, S, 'db10');
sound(Final, fs1);
MSE = mse(Audio - Final);

%------------------------------------------------
%----------------IMAGE COMPRESSION---------------
%================================================

% READ IN FILE
Lena = imread('lena.bmp');
Level = 4;
Order = 'db4';

% DECONSTRUCT IMAGE
[CoefLena, SLena] = wavedec2(Lena, Level, Order);

% COMPRESSION
SortedLena = sort(abs(CoefLena), 'descend');
CutoffLena = SortedLena(round(256*256*ALPHA));
CoefLena(abs(CoefLena) < CutoffLena) = 0;

% RECONSTRUCT IMAGE
FinalLena = uint8(waverec2(CoefLena, SLena, Order));
MSELena = mse(Lena-FinalLena);

% PRINT IMAGE
figure;
imshow(FinalLena, [])
title('4 Level Daubechies. Alpha = .9. Order = 4');