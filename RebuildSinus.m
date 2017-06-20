function [ sum_total ] = RebuildSinus(sound_mag, sound_phase, fe, N)
% Find peaks
% Adjust depending on signal
min_peak_distance = 600;
min_peak_height = 1;
[amp, freq] = findpeaks(sound_mag(1:end/2), 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);

disp(length(amp));
% Rebuild sine
sum_total = 0;
t = 0:1/fe:(N/fe - 1/fe);
for index = 1:length(amp)
    cos_content = 2*pi*(freq(index)-1)/N*fe*t+sound_phase(freq(index));
    result = 2*amp(index)/N*cos(cos_content);
    sum_total = sum_total + result;
end
end

