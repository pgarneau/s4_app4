function [lin1, lin2, lin3, splin1, splin2, splin3, sampleS1, sampleS2, sampleS3] = Interpolation(y1, y2, y3, s1, s2, s3)
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
plot(lin1);
hold on;
plot(y1);
title('Spline vs linéaire vs enveloppe (s1)');
legend('Spline', 'Lineaire', 'Enveloppe')

subplot(3,1,2)
plot(k2,splin2);
hold on;
plot(lin2);
hold on;
plot(y2);
title('Spline vs linéaire vs enveloppe (s2)');
legend('Spline', 'Lineaire', 'Enveloppe')

subplot(3,1,3)
plot(k3,splin3);
hold on;
plot(lin3);
hold on;
plot(y3);
title('Spline vs linéaire vs enveloppe (s3)');
legend('Spline', 'Lineaire', 'Enveloppe')
end

