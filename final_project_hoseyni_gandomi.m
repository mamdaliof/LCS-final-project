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
close all
figure
C1=db2mag(4);
C2=(s/6+1)^2
%----------lead1 start-------------%
phi_maxLead1=50;
aLead1=(1+sind(phi_maxLead1))/(1-sind(phi_maxLead1))
w_mLead1=10;
TLead1=(w_mLead1*sqrt(aLead1))^(-1)
K_cLead1=db2mag(8)
C1=K_cLead1/sqrt(aLead1)*((aLead1*TLead1*s+1)/(TLead1*s+1))
%------------lead1 end-----------%
%------------lead2 start---------%
phi_maxLead1=15;
aLead1=(1+sind(phi_maxLead1))/(1-sind(phi_maxLead1))
w_mLead1=6.2;
TLead1=(w_mLead1*sqrt(aLead1))^(-1)
K_cLead1=db2mag(-1)
C3=K_cLead1/sqrt(aLead1)*((aLead1*TLead1*s+1)/(TLead1*s+1))
%----------lead2 end-------------%
%------------lead3 start---------%
approximateSys=0.3981*(-s/5+1)/(s/5+1)/s/(s^2/25+2/5*0.09752*s+1);
bode(approximateSys)
phi_maxLead1=50;
aLead1=(1+sind(phi_maxLead1))/(1-sind(phi_maxLead1))
w_mLead1=7;
TLead1=(w_mLead1*sqrt(aLead1))^(-1)
K_cLead1=db2mag(0)
C4=K_cLead1/sqrt(aLead1)*((aLead1*TLead1*s+1)/(TLead1*s+1))
%----------lead3 end-------------%
%---------lag start-------------%
K_cL1=257;
K1L_1=K_cL1-1;
aL1=1/K_cL1;
epsilon1=0.1;
w_mL1=5;
TL1=1/w_mL1*sqrt((K1L_1/epsilon1)^2-1);
C2=K_cL1*(aL1*TL1*s+1)/(TL1*s+1);
%--------------- lag end-------------------%
sys=C1^4*C3^2*C4^2*approximateSys;
margin(sys)
hold on
bode(C4)
% hold on
% bode(C1)
figure
nyquist(sys)
figure
step(feedback(sys,1))