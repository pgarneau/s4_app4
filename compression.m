%Axel Bosco - bosa2002
%Philippe Garneau - garp2405
clear all;
close all;

% Extract sound
[s1, fe] = audioread('SonsACompresser/son1.wav');
[s2, fe] = audioread('SonsACompresser/son2.wav');
[s3, fe] = audioread('SonsACompresser/son3.wav');

% Calcul du pas de la fréquence pour un spectre discret ainsi que de la plage de fréquence
N = length(s1);
df = fe/N;
freq = -fe/2:df:(fe/2 - df);

[s1mag, s2mag, s3mag, s1phase, s2phase, s3phase] = GetMainCurves(s1, s2, s3, fe);

% Reassemble curves from peaks
[rebuilt_sin_1, rebuilt_sin_2, rebuilt_sin_3] = RebuildSinus(s1mag, s2mag, s3mag, s1phase, s2phase, s3phase, fe, N);

% Get envelopes
[y1, y2, y3] = GetEnvelope(s1, s2, s3);

% Get linearised envelopes
[lin1, lin2, lin3, splin1, splin2, splin3, sampleS1, sampleS2, sampleS3] = Interpolation(y1, y2, y3, s1, s2, s3);

rebuilt_s1_lin = rebuilt_sin_1 .* lin1;
rebuilt_s1_splin = rebuilt_sin_1 .* splin1;
rebuilt_s2_lin = rebuilt_sin_2 .* lin2;
rebuilt_s2_splin = rebuilt_sin_2 .* splin2;
rebuilt_s3_lin = rebuilt_sin_3 .* lin3;
rebuilt_s3_splin = rebuilt_sin_3 .* splin3;

figure
subplot(3,1,1)
plot(s1)
title('Signal original')
subplot(3,1,2)
plot(rebuilt_s1_lin)
title('Signal reconstruit avec interpolation lineaire')
subplot(3,1,3)
plot(rebuilt_s1_splin)
title('Signal reconstruit avec interpolation splinecubique')

figure
subplot(3,1,1)
plot(s2)
title('Signal original')
subplot(3,1,2)
plot(rebuilt_s2_lin)
title('Signal reconstruit avec interpolation lineaire')
subplot(3,1,3)
plot(rebuilt_s2_splin)
title('Signal reconstruit avec interpolation splinecubique')

figure
subplot(3,1,1)
plot(s3)
title('Signal original')
subplot(3,1,2)
plot(rebuilt_s3_lin)
title('Signal reconstruit avec interpolation lineaire')
subplot(3,1,3)
plot(rebuilt_s3_splin)
title('Signal reconstruit avec interpolation splinecubique')

% soundsc(s1, fe);
% pause(3)
% soundsc(rebuilt_s1_lin, fe);
% pause(3)
% soundsc(rebuilt_s1_splin, fe);

% soundsc(s2, fe);
% pause(3)
% soundsc(rebuilt_s2_lin, fe);
% pause(3)
% soundsc(rebuilt_s2_splin, fe);

% soundsc(s3, fe);
% pause(3)
% soundsc(rebuilt_s3_lin, fe);
% pause(3)
% soundsc(rebuilt_s3_splin, fe);

filename = 'son1Spline.wav';
newson1Spline = rebuilt_s1_splin./(max(abs(rebuilt_s1_splin)));
audiowrite(filename,newson1Spline,fe)

filename = 'son2Spline.wav';
newson2Spline = rebuilt_s2_splin./(max(abs(rebuilt_s2_splin)));
audiowrite(filename,newson2Spline,fe)

filename = 'son3Spline.wav';
newson3Spline = rebuilt_s3_splin./(max(abs(rebuilt_s3_splin)));
audiowrite(filename,newson3Spline,fe)