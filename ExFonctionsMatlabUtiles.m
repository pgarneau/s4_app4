% On donne ici plusieurs fonctions potentiellement utiles � l'APP

% Lecture (sn: donn�es, fr�quence d'�chantillonnage, nombre de bits de  quantification
[s1, fe] = audioread('SonsACompresser/son1.wav');
[s2, fe] = audioread('SonsACompresser/son2.wav');
[s3, fe] = audioread('SonsACompresser/son3.wav');

% Calcul du pas de la fr�quence pour un spectre discret ainsi que de la plage de fr�quence
N = length(s1);
df = fe/N;
freq = -fe/2:df:(fe/2 - df);


figure;
subplot(3, 1, 1)
plot(s1,'r');
hold on
%plot(env1);

subplot(3, 1, 2)
plot(s2,'r');
hold on
%plot(env2);

subplot(3, 1, 3)
plot(s3,'r');
hold on 
%plot(env3);



res1=fft(s1,N);
res2=fft(s2,N);
res3=fft(s3,N);

ampl_Max=max(res1,[],1)

% Exemple de sortie graphique en supposant que les transform�es de Fourier ad�quates ont �t� calcul�es
figure;
subplot(3, 1, 1)
plot(freq, res1) % Transform�eDeS1 n'existe pas, il faut la trouver dans le cadre de cette unit�
axis([-fe/5, fe/5, 0 , 0.2])
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son 1')

subplot(3, 1, 2)
plot(freq,  res2) % Transform�eDeS2 n'existe pas, il faut la trouver dans le cadre de cette unit�
axis([-fe/5, fe/5, 0 , 0.1])
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son 2')

subplot(3, 1, 3)
plot(freq,  res3) % Transform�eDeS3 n'existe pas, il faut la trouver dans le cadre de cette unit�
axis([-fe/5, fe/5, 0 , 0.1])
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son 3')

figure;
subplot(3, 1, 1)
plot(freq, angle(res1))

subplot(3, 1, 2)
plot(freq, angle(res2))

subplot(3, 1, 3)
plot(freq, angle(res3))

% �coute des fichiers (support� seulement sous windows: wavplay)
% Il est possible d'utiliser soundsc (independant de tous les systemes
%  d'exploitation)
% soundsc(s1, fe);
% soundsc(s2, fe);
% soundsc(s3, fe);
% [s1, fe, NBITS] = wavread('son1');
% [s2, fe, NBITS] = wavread('son2');
% [s3, fe, NBITS] = wavread('son3');