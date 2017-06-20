% Extract sound
[s1, fe] = audioread('SonsACompresser/son1.wav');

% Calcul du pas de la fréquence pour un spectre discret ainsi que de la plage de fréquence
N = length(s1);
df = fe/N;
freq = -fe/2:df:(fe/2 - df);

% Display original sound
figure
plot(s1,'r');
grid on

% Fourier transform to put in frequential domain
s1fft = fft(s1, N);
%s1fft = s1fft(1:length(freq)); % keep first half of fft


% Find magnitude
s1mag = abs(s1fft);

% Plot magnitude
figure;
plot(freq, s1mag)
%axis([-fe/5, fe/5, 0 , 0.2])
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son')

% Find phase
s1phase = angle(s1fft);

% Plot phase
figure;
plot(freq, s1phase)
xlabel('f (Hz)')
ylabel('Phase')
title('Phase du son')

sum_total = RebuildSinus(s1mag, s1phase, fe, freq);

% Find envelope
env = abs(s1);
L = 150; %Filter length
h = ones(1, L)/L;
y = conv(env, h);

figure
plot(y);

