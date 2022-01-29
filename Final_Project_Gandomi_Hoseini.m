clc
clear
close all
%---------------------part A 1-------------------%extract Data
s=tf('s');
fileName='Data.xlsx';
Data=xlsread(fileName);
friquency=Data(:,1);
phase=Data(:,3);
magnitude=Data(:,2);
magnitudeConverted=mag2db(magnitude);
figure('name','bode diagram')
subplot(2,1,1)
semilogx(friquency,magnitudeConverted);
title("Bode Diagram")
ylabel('magnitude(dB')
subplot(2,1,2)
semilogx(friquency,phase);
ylabel('phase(deg')
xlabel('frequency(rad/s)')
%---------------------part A 2-------------------% estimate transfer function
approximateSys=0.3981*(-s/5+1)/(s/5+1)/s/(s^2/25+2/5*0.09752*s+1);
zpk(approximateSys)
figure('name','approximate System')
margin(approximateSys)
%---------------------part A 3-------------------%compare bode diagram with data
x=0:100;
figure('name','compare');
bode(approximateSys)
axes_array = findobj(gcf,'type','axes');
a=axes_array(2,1);
hold(a,'on')
semilogx(axes_array(2,1),(friquency),magnitudeConverted,'red');
hold(axes_array(2),'off')
hold(axes_array(1),'on')
semilogx(axes_array(1,1),friquency,phase,'red');
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
K=3;
figure('name','bode diagram after compensating0')
margin(k*approximateSys)
C1=LagGenerator(84.5,4.5,0.05);
sys1=K*C1*approximateSys;
figure('name','bode diagram after compensating1')
margin(sys1)
figure('name','nyquist diagram after compensating1')
nyquist(sys1)
figure('name','step response after compensating1')
step(feedback(sys1,1))
figure('name','ramp response after compensating1')
step(feedback(sys1,1)/s)
hold on 
h = ezplot('x',[0,20]);
set(h, 'Color', 'r');
legend('ramp response','y=x')
Kv=minreal(s*(sys1));
final_ess = evalfr(1/Kv,0)
%---------------------part C 2-------------------%
T = (256*(-0.2*s+1))/((s+4)^4);
C = minreal(T/((1-T)*approximateSys));
sys2=C*approximateSys;
figure('name','bode diagram after compensating2')
margin(sys2)
figure('name','nyquist diagram after compensating2')
nyquist(sys2)
figure('name','step response after compensating2')
step(feedback(sys2,1))
figure('name','ramp response after compensating2')
step(feedback(sys2,1)/s)
hold on 
h = ezplot('x',[0,20]);
set(h, 'Color', 'r');
legend('ramp response','y=x')
figure('name', 'controll effort for step response');
controlEffortStep=C/(1+C*approximateSys);
step(controlEffortStep)
figure('name', 'controll effort for ramp response');
step(controlEffortStep/s)
