a = audiorecorder(44100, 16, 2);
disp('Start speaking.')
record(a,5);
disp('End of Recording.');
b = getaudiodata(a);
plot(abs(fft(b)));