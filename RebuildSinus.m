function [ sum_total ] = RebuildSinus(sound_mag, sound_phase, fe, freq)
% Find peaks
nb_peaks = 32;
min_peak_height = 100;
[amp, freq_index] = findpeaks(sound_mag(1:end/2), 'MinPeakHeight', min_peak_height, 'NPeaks', nb_peaks);

% Get peak phase values
phase = ones(32);
for index = 1:nb_peaks
    phase(index) = sound_phase(freq_index(index));
end

% Rebuild sine
sum_total = 0;
%t = 1/fe;
for index = 1:nb_peaks
    syms t
    cos_content = 2*pi*freq(freq_index(index))*t+sound_phase(freq_index(index));
    result = amp(index)*cos(cos_content);
    sum_total = sum_total + result;
end

t = 0:1:50;
figure;
plot(t, subs(sum_total, t));

end

