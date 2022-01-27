function [transferFunction] = LagGenerator(magnitude,freq,eps)
s=tf('s');
K1=magnitude-1;
a=1/magnitude;
T=1/freq*sqrt((K1/eps)^2-1);
C=magnitude*(a*T*s+1)/(T*s+1);
transferFunction=C;
end

