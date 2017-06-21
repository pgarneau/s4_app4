%Axel Bosco - bosa2002
%Philippe Garneau - garp2405
function [y1, y2, y3] = GetEnvelope(sound_1, sound_2, sound_3)
% Find envelope
env1 = abs(sound_1);
env2 = abs(sound_2);
env3 = abs(sound_3);

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
title('Signal redressé vs enveloppe pour son 1');

subplot(3,1,2)
plot(env2);
hold on;
plot(y2);
title('Signal redressé vs enveloppe pour son 2');

subplot(3,1,3)
plot(env3);
hold on;
plot(y3);
title('Signal redressé vs enveloppe pour son 3');

end

