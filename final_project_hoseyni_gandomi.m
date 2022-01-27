clc
clear
close all
%---------------------part A 1-------------------%extract Data
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
semilogx(axes_array(2,1),(time),magnitudeConverted,'red');
hold(axes_array(2),'off')
hold(axes_array(1),'on')
semilogx(axes_array(1,1),time,phase,'red');

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
%----------lead1 start-------------%
C1=LeadGenerator(db2mag(7.657),30,4.952);
%------------lead1 end-----------%
L=minreal(((1+C1*approximateSys)^-1)/s);
ess=evalfr(L,0)
%---------lag start-------------%
C2=LagGenerator(190,4,0.04);
%--------------- lag end-------------------%
sys=C1*C2*approximateSys;
figure('name','bode diagram after compensating')
margin(sys)
figure('name','nyquist diagram after compensating')
nyquist(sys)
figure('name','step response after compensating')
step(feedback(sys,1))
figure('name','ramp response after compensating')
step(feedback(sys,1)/s)
L=minreal(((1+sys)^-1)/s);
final_ess=evalfr(L,0)
