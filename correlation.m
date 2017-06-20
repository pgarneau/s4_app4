clear all
close all

[s1, fe] = audioread('SonsACompresser/son1.wav');
[s2, fe] = audioread('SonsACompresser/son2.wav');
[s3, fe] = audioread('SonsACompresser/son3.wav');

[t1, fe] = audioread('TramesAReconnaitre/trame1.wav');
[t2, fe] = audioread('TramesAReconnaitre/trame2.wav');
[t3, fe] = audioread('TramesAReconnaitre/trame3.wav');

figure
subplot(3,1,1)
plot(t1);
subplot(3,1,2)
plot(t2);
subplot(3,1,3)
plot(t3);

% Augmentation des arrays des sons et signal centré

Q1(numel(t1)) = 0;
Q1 = Q1';

Q2(numel(t2)) = 0;
Q2 = Q2';

Q3(numel(t3)) = 0;
Q3 = Q3';

for index = length(Q1)/2 - length(s1)/2:length(Q1)/2 - length(s1)/2 + length(s1) - 1
    patate = index - length(Q1)/2 + length(s1)/2 + 1;
    Q1(index) = s1(patate);
    Q2(index) = s2(patate);
    Q3(index) = s3(patate);
end

s1(numel(t1)) = 0;
s2(numel(t1)) = 0;
s3(numel(t1)) = 0;

% Corrélation avec la trame 1 avec xcorr et non centré
corrT1S1 = xcorr(t1,s1);
corrT1S2 = xcorr(t1,s2);
corrT1S3 = xcorr(t1,s3);

% Corrélation avec la trame 2 avec xcorr et non centré
corrT2S1 = xcorr(t2,s1);
corrT2S2 = xcorr(t2,s2);
corrT2S3 = xcorr(t2,s3);

% Corrélation avec la trame 3 avec xcorr et non centré
corrT3S1 = xcorr(t3,s1);
corrT3S2 = xcorr(t3,s2);
corrT3S3 = xcorr(t3,s3);

% Corrélation avec la trame 1 centré et unbiased
corrT1S1Q = xcorr(t1,Q1,'unbiased');
corrT1S2Q = xcorr(t1,Q2,'unbiased');
corrT1S3Q = xcorr(t1,Q3,'unbiased');

% Corrélation avec la trame 2 centré et unbiased
corrT2S1Q = xcorr(t2,Q1,'unbiased');
corrT2S2Q = xcorr(t2,Q2,'unbiased');
corrT2S3Q = xcorr(t2,Q3,'unbiased');

% Corrélation avec la trame 3 centré et unbiased
corrT3S1Q = xcorr(t3,Q1,'unbiased');
corrT3S2Q = xcorr(t3,Q2,'unbiased');
corrT3S3Q = xcorr(t3,Q3,'unbiased');

figure
subplot(3,2,1)
plot(corrT1S1);
hold on
plot(corrT1S2);
hold on
plot(corrT1S3);

subplot(3,2,3)
plot(corrT2S1);
hold on
plot(corrT2S2);
hold on
plot(corrT2S3);

subplot(3,2,5)
plot(corrT3S1);
hold on
plot(corrT3S2);
hold on
plot(corrT3S3);

subplot(3,2,2)
plot(corrT1S1Q);
hold on
plot(corrT1S2Q);
hold on
plot(corrT1S3Q);

subplot(3,2,4)
plot(corrT2S1Q);
hold on
plot(corrT2S2Q);
hold on
plot(corrT2S3Q);

subplot(3,2,6)
plot(corrT3S1Q);
hold on
plot(corrT3S2Q);
hold on
plot(corrT3S3Q);


% 0.006205
