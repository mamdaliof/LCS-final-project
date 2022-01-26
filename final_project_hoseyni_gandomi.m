clc
clear
fileName='Data.xlsx';
Data=xlsread(fileName);
time=Data(:,1);
phase=Data(:,3);
magnitude=Data(:,2);
magnitudeConverted=mag2db(magnitude);
figure('name','bode diagram')
subplot(2,1,1)
semilogx(time,magnitudeConverted);
subplot(2,1,2)
semilogx(time,phase);
