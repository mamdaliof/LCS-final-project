function [transferFunction] = LeadGenerator(magnitude,max_phase,freq)
s=tf('s');
a=(1+sind(max_phase))/(1-sind(max_phase));
T=(freq*sqrt(a))^(-1);
C=magnitude/sqrt(a)*((a*T*s+1)/(T*s+1));
transferFunction=C;
end

