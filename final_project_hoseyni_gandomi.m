clc
clear
close all
%---------------------part A 1-------------------%
s=tf('s');
fileName='Data.xlsx';
Data=xlsread(fileName);
time=Data(:,1);
phase=Data(:,3);
magnitude=Data(:,2);
magnitudeConverted=mag2db(magnitude);
figure('name','bode diagram')
subplot(2,1,1)
semilogx(time,magnitudeConverted);
title("Bode Diagram")
ylabel('magnitude(dB')
subplot(2,1,2)
semilogx(time,phase);
ylabel('phase(deg')
xlabel('frequency(rad/s)')
%---------------------part A 2-------------------%
approximateSys=0.3981*(-s/5+1)/(s/5+1)/s/(s^2/25+2/5*0.09752*s+1);
zpk(approximateSys)
figure('name','approximate System')
margin(approximateSys)
%---------------------part B 1-------------------%
figure('name','pzmap')
pzmap(approximateSys)
figure('name','root locus')
rlocus(approximateSys)
hold on
rlocus(-approximateSys,'--')
%---------------------part B 2-------------------%
figure('name','responses')
subplot(1,2,1)
k=1.5;
step(feedback(k*approximateSys,1))
title('step response')
subplot(1,2,2)
step(feedback(k*approximateSys,1)/s)
title('ramp response')
hold on 
h=ezplot('x',[0,20]);
set(h, 'Color', 'r');
legend('ramp response','y=x')
%---------------------part C 1-------------------%
