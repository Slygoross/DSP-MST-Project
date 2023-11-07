clc;
close all;
clear;

[Clean, Fs2] = audioread('expected.m4a');
[sample_data, sample_rate] = audioread('corrupted.m4a');

% Applying a bandpass IIR filter
Fs = sample_rate;
d1 = designfilt('bandpassiir', 'FilterOrder', 20, ...
    'HalfPowerFrequency1', 100, 'HalfPowerFrequency2', 600, ...
    'SampleRate', Fs);

filtered_sound2 = filtfilt(d1, sample_data);

% Playing the filtered audio
Audio2 = audioplayer(filtered_sound2, Fs);
play(Audio2);

% Plotting the filter response (magnitude)
figure;
freqz(d1);
title('Filter Response');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');

% Ploting the frequency domain representation of the original signal
N = length(sample_data);
f = linspace(0, Fs, N);
figure;
plot(f, abs(fft(sample_data)))
title('Original Signal Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('Amplitude');

% Plotting the frequency domain representation of the expected clean signal
figure;
plot(f, abs(fft(Clean)))
title('Expected Signal Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('Amplitude');

% Plotting the frequency domain representation of the filtered signal
figure;
plot(f, abs(fft(filtered_sound2)))
title('Filtered Signal Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('Amplitude');

% Plotting the original signal
figure;
subplot(3, 1, 1);
plot(sample_data);
title('Original Signal');
xlabel('Time (s)'); ylabel('Amplitude');

% Plotting the filtered output
subplot(3, 1, 2);
plot(filtered_sound2);
title('Filtered Signal');
xlabel('Time (s)'); ylabel('Amplitude');

% Plotting the expected signal
subplot(3, 1, 3);
plot(Clean);
title('Expected Signal');
xlabel('Time (s)'); ylabel('Amplitude');
