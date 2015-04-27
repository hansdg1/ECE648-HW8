%------------------------------------------------
%----------------AUDIO COMPRESSION---------------
%================================================

% READ IN FILE
[AUDIO,SAMPLE_RATE] = audioread('audio1.wav');
alphas = [0.01, 0.05, 0.1, 0.3, 0.5, 0.7, 0.9];
for n = 1:length(alphas)
    Daubechies(AUDIO,SAMPLE_RATE,alphas(n));
end


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