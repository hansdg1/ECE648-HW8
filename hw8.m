%------------------------------------------------
%----------------AUDIO COMPRESSION---------------
%================================================

% READ IN FILE
[AUDIO,SAMPLE_RATE] = audioread('audio1.wav');

alphas = [0.01, 0.05, 0.1, 0.3, 0.5, 0.7, 0.9];
for n = 1:length(alphas)
    DaubechiesAudio(AUDIO,SAMPLE_RATE,alphas(n));
end


%------------------------------------------------
%----------------IMAGE COMPRESSION---------------
%================================================

% READ IN FILE
Lena = double(imread('lena.bmp'));

figure(1);
subplot(2,4,1);
imshow(Lena,[]);
title('Original Image');
for n = 1:length(alphas)
    coifletImage = CoifletImage(Lena,alphas(n));
    subplot(2,4,n+1);
    str = strcat('\alpha = ', num2str(alphas(n),'%.2f'));
    imshow(coifletImage,[]);
    title(str);
end

figure(2);
subplot(2,4,1);
imshow(Lena,[]);
title('Original Image');
for n = 1:length(alphas)
    daubechiesImage = DaubechiesImage(Lena,alphas(n));
    subplot(2,4,n+1);
    str = strcat('\alpha = ', num2str(alphas(n),'%.2f'));
    imshow(daubechiesImage,[]);
    title(str);
end
