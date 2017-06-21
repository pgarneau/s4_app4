%Axel Bosco - bosa2002
%Philippe Garneau - garp2405
function [s1mag, s2mag, s3mag, s1phase, s2phase, s3phase] = GetMainCurves(sound_1, sound_2, sound_3, fe)
% Display original sound
figure
subplot(3,1,1);
plot(sound_1,'r');
title('S1');
grid on

subplot(3,1,2);
plot(sound_2,'r');
title('S2');
grid on

subplot(3,1,3);
plot(sound_3,'r');
title('S3');
grid on

% Fourier transform to put in frequential domain
s1fft = fft(sound_1, fe);
s2fft = fft(sound_2, fe);
s3fft = fft(sound_3, fe);

% Find magnitude
s1mag = abs(s1fft);
s2mag = abs(s2fft);
s3mag = abs(s3fft);

% Plot magnitude
figure
subplot(3,1,1)
plot(s1mag)
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son s1')

subplot(3,1,2)
plot(s2mag)
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Spectre du son s2')

subplot(3,1,3)
plot(s3mag)
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
end

