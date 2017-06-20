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

% Display original sound
figure
subplot(3,1,1);
plot(s1,'r');
title('S1');
grid on

subplot(3,1,2);
plot(s2,'r');
title('S2');
grid on

subplot(3,1,3);
plot(s3,'r');
title('S3');
grid on

% Fourier transform to put in frequential domain
s1fft = fft(s1, fe);
s2fft = fft(s2, fe);
s3fft = fft(s3, fe);
%s1fft = s1fft(1:length(freq)); % keep first half of fft


% Find magnitude
s1mag = abs(s1fft);
s2mag = abs(s2fft);
s3mag = abs(s3fft);

% Plot magnitude
figure
subplot(3,1,1)
plot(s1mag)
%axis([-fe/5, fe/5, 0 , 0.2])
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son s1')

subplot(3,1,2)
plot(s2mag)
%axis([-fe/5, fe/5, 0 , 0.2])
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son s2')

subplot(3,1,3)
plot(s3mag)
%axis([-fe/5, fe/5, 0 , 0.2])
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son s3')

% Find phase
s1phase = angle(s1fft);
s2phase = angle(s2fft);
s3phase = angle(s3fft);

% Plot phase
figure
subplot(3,1,1)
plot(s1phase)
xlabel('f (Hz)')
ylabel('Phase')
title('Phase du son s1')

subplot(3,1,2)
plot(s2phase)
xlabel('f (Hz)')
ylabel('Phase')
title('Phase du son s2')

subplot(3,1,3)
plot(s3phase)
xlabel('f (Hz)')
ylabel('Phase')
title('Phase du son s3')

% PLot moi la plotte
rebuilt_sin_1 = RebuildSinus(s1mag, s2phase, fe, N);
rebuilt_sin_2 = RebuildSinus(s2mag, s2phase, fe, N);
rebuilt_sin_3 = RebuildSinus(s3mag, s2phase, fe, N);

figure
subplot(3,1,1)
plot(rebuilt_sin_1)

subplot(3,1,2)
plot(rebuilt_sin_2)

subplot(3,1,3)
plot(rebuilt_sin_3)

% Find envelope
env1 = abs(s1);
env2 = abs(s2);
env3 = abs(s3);

L = 3000; %Filter length
h = ones(1, L)/L;

%Convolution
y1 = conv(env1, h);
y2 = conv(env2, h);
y3 = conv(env3, h);

%Signal redressé vs env
figure
subplot(3,1,1)
plot(env1);
hold on;
plot(y1);
title('Signal redressé vs env pour son 1');

subplot(3,1,2)
plot(env2);
hold on;
plot(y2);
title('Signal redressé vs env pour son 2');

subplot(3,1,3)
plot(env3);
hold on;
plot(y3);
title('Signal redressé vs env pour son 3');

%Échantillonage
sampleS1 = [];
sampleS2 = [];
sampleS3 = [];

for index = 1:1000:length(s1)
    sampleS1(end + 1) = y1(index);
end

for index = 1:1000:length(s2)
    sampleS2(end + 1) = y2(index);
end

for index = 1:1000:length(s3)
    sampleS3(end + 1) = y3(index);
end

%Préparation pour interpolation
x_sampleS1 = 1:1000:length(sampleS1) * 1000;
x_sampleS2 = 1:1000:length(sampleS2) * 1000;
x_sampleS3 = 1:1000:length(sampleS3) * 1000;

k1 = 1:1:length(s1);
k2 = 1:1:length(s2);
k3 = 1:1:length(s3);

%Interpolation linéaire
lin1 = interp1(x_sampleS1, sampleS1, k1);
lin2 = interp1(x_sampleS2, sampleS2, k2);
lin3 = interp1(x_sampleS3, sampleS3, k3);

%Interpolation par spline
splin1 = spline(x_sampleS1, sampleS1, k1);
splin2 = spline(x_sampleS2, sampleS2, k2);
splin3 = spline(x_sampleS3, sampleS3, k3);

figure
subplot(3,1,1)
plot(k1,splin1);
hold on;
plot(y1);
hold on;
plot(lin1);
title('Spline vs linéaire vs env (s1)');

subplot(3,1,2)
plot(k2,splin2);
hold on;
plot(y2);
hold on;
plot(lin2);
title('Spline vs linéaire vs env (s2)');

subplot(3,1,3)
plot(k3,splin3);
hold on;
plot(y3);
hold on;
plot(lin3);
title('Spline vs linéaire vs env (s3)');

rebuilt_s1_lin = rebuilt_sin_1 .* lin1;
rebuilt_s1_splin = rebuilt_sin_1 .* splin1;
rebuilt_s2_lin = rebuilt_sin_2 .* lin2;
rebuilt_s2_splin = rebuilt_sin_2 .* splin2;
rebuilt_s3_lin = rebuilt_sin_3 .* lin3;
rebuilt_s3_splin = rebuilt_sin_3 .* splin3;

figure
subplot(3,1,1)
plot(s1)
subplot(3,1,2)
plot(rebuilt_s1_lin)
subplot(3,1,3)
plot(rebuilt_s1_splin)

figure
subplot(3,1,1)
plot(s2)
subplot(3,1,2)
plot(rebuilt_s2_lin)
subplot(3,1,3)
plot(rebuilt_s2_splin)

figure
subplot(3,1,1)
plot(s3)
subplot(3,1,2)
plot(rebuilt_s3_lin)
subplot(3,1,3)
plot(rebuilt_s3_splin)

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

soundsc(s3, fe);
pause(3)
soundsc(rebuilt_s3_lin, fe);
pause(3)
soundsc(rebuilt_s3_splin, fe);

filename = 'son3Spline.wav';
newson3Spline = rebuilt_s3_splin./(max(abs(rebuilt_s3_splin)));
audiowrite(filename,newson3Spline,fe)