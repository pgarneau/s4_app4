function [s1_total, s2_total, s3_total] = RebuildSinus(s1mag, s2mag, s3mag, s1phase, s2phase, s3phase, fe, N)
% Find peaks S1
min_peak_distance = 5;
min_peak_height = 67;

[amp, freq] = findpeaks(s1mag(1:end/2), 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);
disp(length(freq));
% Rebuild sine
s1_total = 0;
t = 0:1/fe:(N/fe - 1/fe);
for index = 1:length(amp)
    cos_content = 2*pi*(freq(index)-1)*t + s1phase(freq(index));
    result = 2*amp(index)*cos(cos_content);
    s1_total = s1_total + result;
end
s1_total = s1_total / N;
figure
subplot(3,1,1)
plot(s1mag(1:end/2))
hold on
plot(freq, amp, 'o')
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Identification des peaks dans le spectre de S1')

% Find peaks S2
min_peak_distance = 20;
min_peak_height = 50;

[amp, freq] = findpeaks(s2mag(1:end/2), 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);
disp(length(freq));
% Rebuild sine
s2_total = 0;
t = 0:1/fe:(N/fe - 1/fe);
for index = 1:length(amp)
    cos_content = 2*pi*(freq(index)-1)*t+s2phase(freq(index));
    result = 2*amp(index)/N*cos(cos_content);
    s2_total = s2_total + result;
end
s2_total = s2_total / N;
subplot(3,1,2)
plot(s2mag(1:end/2))
hold on
plot(freq, amp, 'o')
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Identification des peaks dans le spectre de S2')

% Find peaks S3
min_peak_distance = 10;
min_peak_height = 200;

[amp, freq] = findpeaks(s3mag(1:end/2), 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);
disp(length(freq));
% Rebuild sine
s3_total = 0;
t = 0:1/fe:(N/fe - 1/fe);
for index = 1:length(amp)
    cos_content = 2*pi*(freq(index)-1)*t+s3phase(freq(index));
    result = 2*amp(index)/N*cos(cos_content);
    s3_total = s3_total + result;
end
s3_total = s3_total / N;
subplot(3,1,3)
plot(s3mag(1:end/2))
hold on
plot(freq, amp, 'o')
xlabel('f (Hz)')
ylabel('Amplitude (V)')
title('Identification des peaks dans le spectre de S3')

%Plot the new sins
% figure
% subplot(3,1,1)
% plot(s1_total)
% 
% subplot(3,1,2)
% plot(s2_total)
% 
% subplot(3,1,3)
% plot(s3_total)
end

